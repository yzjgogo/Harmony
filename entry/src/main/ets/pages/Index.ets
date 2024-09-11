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
      Button("循环渲染ForEach")
        .onClick(()=>{
          router.pushUrl({url:'pages/A4_ForEach'})
        })
      Button("循环渲染ForEach-数据源不变")
        .onClick(()=>{
          router.pushUrl({url:'pages/A4_ForEach_2'})
        })
      Button("循环渲染ForEach-数据源数组项发生变化")
        .onClick(()=>{
          router.pushUrl({url:'pages/A4_ForEach_3'})
        })
      Button("循环渲染ForEach-数据源数组项子属性变化")
        .onClick(()=>{
          router.pushUrl({url:'pages/A4_ForEach_4'})
        })
      Button("循环渲染ForEach-拖拽排序")
        .onClick(()=>{
          router.pushUrl({url:'pages/A4_ForEach_5'})
        })
      Button("UIAbility组件生命周期")
        .onClick(()=>{
          router.pushUrl({url:'pages/A5_UIAbility_lifecycle'})
        })
      Button("UIAbility的启动模式-启动别的UIAbility和传参-在page中获取UIAbilityContext")
        .onClick(()=>{
          router.pushUrl({url:'pages/A6_UIAbility_start_mode'})
        })
      Button("UIAbility组件基本用法-指定UIAbility的启动页面-获取UIAbility的上下文信息")
        .onClick(()=>{
          router.pushUrl({url:'pages/A7_UIAbility_base_use'})
        })
      Button("UIAbility组件与UI的数据通信：EventHub事件的发送与接收")
        .onClick(()=>{
          router.pushUrl({url:'pages/A8_UIAbility_EventHub'})
        })
      Text("UIAbility组件间交互（设备内）:启动应用内的UIAbility、启动应用内的UIAbility并获取返回结果、启动UIAbility的指定页面；UIContext、window.Window、router")
        .backgroundColor(Color.Yellow)
        .padding(10)
        .margin({top:10})
        .onClick(()=>{
          router.pushUrl({url:'pages/A9_UIAbility_operation'})
        })
      Text("路由待学")
        .backgroundColor(Color.Yellow)
        .padding(10)
        .margin({top:10})
        .onClick(()=>{
          router.pushUrl({url:'pages/A10_router'})
        })
      Text("Tabs的用法")
        .backgroundColor(Color.Yellow)
        .padding(10)
        .margin({top:10})
        .onClick(()=>{
          router.pushUrl({url:'pages/A11_tabs'})
        })
      Text("Tabs的用法-自定义")
        .backgroundColor(Color.Yellow)
        .padding(10)
        .margin({top:10})
        .onClick(()=>{
          router.pushUrl({url:'pages/A12_tabs_diy'})
        })

      Text("Navigation的用法")
        .backgroundColor(Color.Yellow)
        .padding(10)
        .margin({top:10})
        .onClick(()=>{
          router.pushUrl({url:'pages/A13_Navigation'})
        })

      Text("Navigation的用法-Dialog")
        .backgroundColor(Color.Yellow)
        .padding(10)
        .margin({top:10})
        .onClick(()=>{
          router.pushUrl({url:'pages/A14_Navigation_Dialog'})
        })

      Text("Navigation的用法-生命周期")
        .backgroundColor(Color.Yellow)
        .padding(10)
        .margin({top:10})
        .onClick(()=>{
          router.pushUrl({url:'pages/A15_Navigation_lifecycle'})
        })

      Text("Navigation的用法-查询当前组件所在NavDestination和Navigation的信息")
        .backgroundColor(Color.Yellow)
        .padding(10)
        .margin({top:10})
        .onClick(()=>{
          router.pushUrl({url:'pages/A16_Navigation_NavDestinationInfo'})
        })

      Text("Navigation的用法-注册NavDestination生命周期变化的监听")
        .backgroundColor(Color.Yellow)
        .padding(10)
        .margin({top:10})
        .onClick(()=>{
          router.pushUrl({url:'pages/A17_Navigation_lifecycle_observer'})
        })

      Text("Navigation的用法-注册页面切换的状态")
        .backgroundColor(Color.Yellow)
        .padding(10)
        .margin({top:10})
        .onClick(()=>{
          router.pushUrl({url:'pages/A18_Navigation_NavDestinationSwitchInfo'})
        })
    }
  }
}