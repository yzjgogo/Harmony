@Component
struct SonCom {
  // 保证父组件的数据变化了, 能够往下响应式的更新
  @Prop sCar: string = ''
  changeCar = (newCar: string) => {}

  build() {
    Column() {
      Text(`子组件 ${this.sCar}`)
      Button('换车').onClick((event: ClickEvent) => {
        // 1. prop传值 → 单向传递
        // 子组件, 可以修改到 prop 传值, 但是修改的更新不会同步到父组件
        // 通常不太会直接修改 prop 传值, 父组件的状态一旦变化, 会自动向下同步
        // 修改就被覆盖了
        // this.sCar = '小黄车'

        // 2. 如果实在想更新, 希望保证父子同步 => 调用父组件传递过来的方法，通知父组件去更新，这样父组件更新fCar后，又会响应式的更新子组件的sCar
        // 如果没有写箭头函数, 意味着, this 指向 调用者, 而此处执行环境 this → 子组件
        this.changeCar('蹦蹦车')
      })
    }
    .padding(20)
    .backgroundColor(Color.Orange)
  }
}

/**
  @Prop

  父组件的状态变量fCar使用@State修饰，子组件使用父组件传递过来的状态变量sCar用@Prop修饰。
 这样，当父组件的fCar发生变化时，会单向的同步通知子组件的sCar发生变化，也就同步触发父组件和子组件的UI更新。
 但是@Prop是单向的，子组件内部被@Porp修饰的sCar,在子组件内部被修改时，只会在子组件内部生效，触发子组件内部的UI更新，不会触发父组件UI更新(父组件的fCar的值实际改了吗？)
 如果确实需要在组件内部更新父组件的fCar，则可以通过回调的方式，通知父组件去修改fCar的值，这样父组件的fCar的修改又会同步通知子组件sCar的更新。
 */
@Entry
@Component
struct B1_Prop {
  @State fCar:string = '劳斯莱斯'
  build() {
    Column() {
      Text(`父组件 - ${this.fCar}`)
      Button('换车').onClick(() => {
        //因为fCar被@State修饰，所以B1_Prop可以响应式更新UI，又因为SonCom.sCar被@Prop修饰，所以父组件的状态变量fCar发生变化时，会响应式的同步告知
        //自组件的sCar发生变化
        this.fCar = '三轮车'
      })

      SonCom({
        sCar: this.fCar,
        // 这里必须要用箭头函数, 否则会有 this 指向的问题
        // 使用箭头函数的好处, 可以使用外部环境的 this, 不受传递过去后的执行环境影响
        // 希望此处 this 指向 父组件
        changeCar: (newCar: string) => {
          this.fCar = newCar
        }
      })
    }
    .padding(50)
    .backgroundColor(Color.Pink)
  }
}