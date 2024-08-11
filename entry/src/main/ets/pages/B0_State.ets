interface Car {
  name: string
}

interface Person {
  name: string
  car: Car
}

const obj: Person = {
  name: 'zs',
  car: {
    name: '小黄车'
  }
}
console.error('执行查看第一层属性', Object.keys(obj))
/**
 @State的用法：监听数据的变化，触发UI响应式的更新

 如果组件的状态变量没有被@State修饰，则组件只有在首次渲染时，使用状态变量的数据渲染UI，当状态变量的数据发生变化时，不会触发UI的自动响应式更新

 总之，通过Object.keys(obj)获取到的属性都能被监听到，发生变化时都会触发UI更新
 例如：Object.keys(person) -> name,car
 则name和car的指向(整体)发生变化都会触发UI更新，但是因为并没有获取到car.name，所有单纯的修改person.car.name = xxx 是无法触发UI更新的
 */
@Entry
@Component
struct B0_State {
  // 状态变量
  // 1. string number boolean 可以直接监视到变化
  @State message: string = 'hello world'
  // 2. 复杂类型 object class, 第一层随便改, 嵌套需要进行整个嵌套对象的替换
  @State person: Person = {
    name: 'jack',
    car: {
      name: '宝马车'
    }
  }

  build() {
    Column() {
      Text(this.message).fontSize(20)
      Text('修改基本数据类型的值，可以直接监听到数据的变化，触发UI更新').onClick(() => {
        this.message = '你好'
      })
      Divider()
        .margin({ top: 20, bottom: 20 })
      Text(JSON.stringify(this.person))
      Text('复杂类型(对象)-直接修改复杂类型的指向，可以直接监听到数据的变化，触发UI更新').onClick(() => {
        this.person = {
          name: 'amy',
          car: {
            name: '保时捷'
          }
        }
      })
        .margin({ bottom: 20 })
      Text('复杂类型(对象)-修改复杂类型的第一层属性，可以直接监听到数据的变化，触发UI更新(第一层属性是基本类型)')
        .onClick(() => {
          this.person.name = 'tony'
        })
        .margin({ bottom: 20 })

      Text('复杂类型(对象)-修改复杂类型的第一层属性，可以直接监听到数据的变化，触发UI更新(第一层属性是复杂类型时，需要修改该属性值的指向)')
        .onClick(() => {
          this.person.car = {
            name: '老爷车'
          }
        })
        .margin({ bottom: 20 })

      Text('复杂类型(对象)-修改复杂类型的第一次属性，当第一层属性是复杂类型时，修改改属性的属性值无法触发UI更新，但是数据实际上是变化了的')
        .onClick(() => {
          this.person.car.name = '老爷车'
        })
        .margin({ bottom: 20 })
    }
  }
}