/**
 *
 当时只看了这个文档
 https://developer.huawei.com/consumer/cn/training/course/slightMooc/C101717497122909477


 UIAbility组件生命周期
 去 D:\Harmony\Study\Harmony\entry\src\main\ets\entryability\EntryAbility.ets 看看
 */
@Entry
@Component
struct Z1_SingletonPage {
  build() {
    Row() {
      Text("singleton启动模式的UIAbility的页面")
        .margin({top:40})
        .fontSize(30)
    }
  }
}