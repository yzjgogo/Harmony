import { router } from '@kit.ArkUI'
import { BusinessError } from '@kit.BasicServicesKit'

@Entry
@Component
struct Index {
  build() {
    Column() {
      Button("ArkTS的基本组成")
        .onClick(()=>{
          router.pushUrl({url:'pages/A0_ArkTS_base_zucheng'}).then(()=>{

          }).catch((err:BusinessError)=>{

          })
        })
      Button("创建并使用自定义组件")
        .onClick(()=>{
          router.pushUrl({url:'pages/A1_diy_component'})
        })
      Button("页面和自定义组件的生命周期")
        .onClick(()=>{
          router.pushUrl({url:'pages/A2_page_component_lifecycle'})
        })
      Button("自定义组件监听页面生命周期")
        .onClick(()=>{
          router.pushUrl({url:'pages/A3_component_observer_Page'})
        })
    }
  }
}