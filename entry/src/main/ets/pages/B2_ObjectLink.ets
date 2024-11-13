interface IStudent {
  id: number
  name: string
  age: number
}

@Observed
class Student {
  id: number
  name: string
  age: number

  constructor(obj: IStudent) {
    this.id = obj.id
    this.name = obj.name
    this.age = obj.age
  }
}

/**
  @Observed 和 @ObjectLink
  参考：B0_State.ets
  正常情况下@State修饰的状态变量，只能监听到第一层属性的变化，如果 @State修饰的状态变量是嵌套对象或嵌套对象组成的数组，当第二层的属性发生变化时就监测不到。

 这时候@Observed 和 @ObjectLink就用到了
 1：对要监测的对象用@Observed修饰，结果就是给这个对象的所有属性设置了get和set方法，系统可以拦截get和set来监测属性的变化；
 2：子组件的对象的使用处，使用@ObjectLink修饰，这样子组件就可以修改这个被@ObjectLink修饰的对象的某个属性，实现UI响应式的更新；

 注意：
 1：当被@Observed修饰的对象的某个属性发生变化时，并不是所有这个对象的引用出都会相应是的更新，而是只有被@ObjectLink修饰的对象的引用才会响应式的更新
    例如点击第一个‘修改数据’，‘位置1’就没有响应式的修改数据；我们把‘位置1’改造成‘位置2’后，就做到响应式更新了
 2：@ObjectLink不能用到@Entry修饰的组件中，即不能用到page组件中。
 3：@ObjectLink是双向响应式的，即你在父组件通过修改@State修饰的原始数据会触发子组件@ObjectLink修饰的数据的更行，从而触发UI响应式更新
  你在子组件直接修改@ObjectLink修饰的数据又会触发父组件原始数据的更新，以及UI响应式的更新。
 */
@Entry
@Component
struct ObservedAndLink {
  @State studentList: Student[] = [
    new Student({
      id: 1,
      name: '张三',
      age: 18
    }),
    new Student({
      id: 2,
      name: '李四',
      age: 19
    }),
    new Student({
      id: 3,
      name: '王五',
      age: 20
    })
  ]

  build() {
    Column({ space: 20 }) {
      Text('父组件')
        .fontSize(30)
        .onClick(()=>{
          //这里改变age,在MyCom里和ItemCom里的info都会响应式更新，因为他们都用@ObjectLink修饰了。
          //而位置1仍然不会响应式更新
          this.studentList[0].age++
          //下面这样直接给[0]赋值，位置1也会响应式更新，MyCom里和ItemCom里也会响应式更新，因为这正好是@State的特点，[0]是studentList的第一层属性
          // this.studentList[0] = new Student({
          //   id: 4,
          //   name: '刘六',
          //   age: 99
          // })
        })
      // 属性更新的逻辑: 当我们@Observed装饰过的数据, 属性改变时, 就会监听到
      // 遍历依赖它的 @ObjectLink 包装类, 通知数据更新
      // 注意: entry 组件无法直接使用 ObjectLink, 需要包一层
      Text(this.studentList[0].age.toString())//位置1
      MyCom({//位置2
        info: this.studentList[0]
      })

      List({ space: 10 }) {
        ForEach(this.studentList, (item: Student, index: number) => {
          ItemCom({
            info: item,
            addAge: () => {
              AlertDialog.show({
                message: JSON.stringify(this.studentList)
              })
            }
          })
        })
      }

    }
    .backgroundColor('#cbe69b')
    .width('100%')
    .height('100%')
    .padding(20)
  }
}

@Component
struct MyCom {
  @ObjectLink info: Student
  build() {
    Text(this.info.age.toString())
  }
}

@Component
struct ItemCom {
  @ObjectLink info: Student
  addAge = () => {

  }

  build() {
    ListItem() {
      Row({ space: 10 }) {
        Text('姓名:' + this.info.name)
        Text('年龄:' + this.info.age)
        Blank()
        Button('修改数据')
          .onClick(() => {
            this.info.age++
            this.addAge()
          })
      }
      .backgroundColor(Color.Pink)
      .padding(10)
      .width('100%')
    }
  }
}
