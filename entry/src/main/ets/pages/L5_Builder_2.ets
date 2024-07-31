
/**
 Builder
 可以说是Extend和Styles的综合，支持抽取整个组件，支持抽取任意组件，支持传递参数
 如果不需要访问组件内(L5_Builder_2里的)的数据，则可以全局定义
 如果需要访问组件内(L5_Builder_2里的)的数据，则可以局部定义，然后听过this访问组件内的数据
 */

// 全局 Builder
@Builder
function navItem(icon: ResourceStr, txt: string) {
  Column({ space: 10 }) {
    Image(icon)
      .width('80%')
    Text(txt)
  }
  .width('25%')
  .onClick(() => {
    AlertDialog.show({
      message: '点了' + txt
    })
  })
}

@Entry
@Component
struct L5_Builder_2 {
  @State message: string = '@Builder';

  @Builder
  navItem(icon: ResourceStr, txt: string) {
    Column({ space: 10 }) {
      Image(icon)
        .width('80%')
      Text(txt)
    }
    .width('25%')
    .onClick(() => {
      AlertDialog.show({
        message: '点了' + txt + this.message
      })
    })
  }

  build() {
    Column({ space: 20 }) {
      Text(this.message)
        .fontSize(30)

      Row() {
        Row() {
          //没有使用this,则访问的是全局的那个navItem
          navItem($r('app.media.ic_reuse_01'), '阿里拍卖')
          navItem($r('app.media.ic_reuse_02'), '菜鸟')
          //使用了this,则访问的是局部的那个navItem
          this.navItem($r('app.media.ic_reuse_03'), '巴巴农场')
          this.navItem($r('app.media.ic_reuse_04'), '阿里药房')
        }
      }
    }
    .width('100%')
    .height('100%')
  }

}