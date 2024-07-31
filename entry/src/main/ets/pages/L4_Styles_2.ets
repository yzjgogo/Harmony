
/**
 @Styles
 用于抽取某些组件的公共样式，存粹是某些组件所有相同样式的抽取，
 无需像Extend那样指定组件类型，即任何组件都可以
 无需传参，不能传参

 如果不需要访问组件内部的数据，可以定义在组件外(全局定义)，例如：commonStyles()
 如果需要访问组件内部的数据，可以定义在组件内，例如：setBg()，其内部可以通过this访问组件内的数据
 */


// 1. 全局定义
@Styles
function commonStyles() {
  .width(100)
  .height(100)
}

@Entry
@Component
struct L4_Styles_2 {
  @State message: string = '@styles';
  @State bgColor: ResourceColor = Color.Gray

  // 2. 组件内定义(才能通过this访问到自己的状态)
  @Styles
  setBg() {
    .backgroundColor(this.bgColor)
    .onClick(() => {
      this.bgColor = Color.Green
    })
  }

  build() {
    Column({ space: 10 }) {
      Text(this.message)
        .fontColor(Color.White)
        .commonStyles()
        .setBg()

      Column() {
      }
      .commonStyles()
      .setBg()

      Button('按钮')
        .commonStyles()
        .setBg()
    }
    .width('100%')
    .height('100%')
  }
}