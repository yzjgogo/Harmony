/**
 https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/arkts-routing-V5
  路由
 */
import { common, Want } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';

@Entry
@Component
struct A10_router {
  build() {
    Column() {
      Text("路由-待学习")
        .backgroundColor(Color.Orange)
        .padding(10)
        .margin({ top: 10 })
    }
  }
}