// @Extend(组件名)
// function 函数名 (参数, 参数2...) {
//
// }

/**
 * Extend
 * 用于定义某个组件(必须指定组件类型)的公共样式，可以传参动态指定某些样式值
 * 注意：
 * 如果因为这里你@Extend(Text),则必须Text组件可以调用.textFn()
 * @Extend要定义在组件外面(全局定义)，这里定义在L3_Extend_2外面，能不能定义在L3_Extend_2里面呢？
 */
@Extend(Text)
function textFn () {
  .fontSize(20)
  .fontWeight(FontWeight.Bold)
}

@Extend(Text)
function bannerItem (bgColor: ResourceColor, msg: string) {
  .textAlign(TextAlign.Center)
  .backgroundColor(bgColor)
  .fontColor(Color.White)
  .fontSize(30)
  .onClick(() => {
    AlertDialog.show({
      message: msg
    })
  })
}

@Entry
@Component
struct L3_Extend_2 {
  @State message: string = '@Extend-扩展组件(样式,事件)';

  build() {
    Column() {
      Text(this.message)
        .textFn()

      Swiper() {
        Text('1')
          .bannerItem(Color.Orange, '轮播图1号')
        Text('2')
          .bannerItem(Color.Brown, '轮播图2号')
        Text('3')
          .bannerItem(Color.Green, '轮播图3号')
      }
      .width('100%')
      .height(160)
    }
    .width('100%')
    .height('100%')
  }
}