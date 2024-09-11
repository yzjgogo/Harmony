/**
 https://developer.huawei.com/consumer/cn/training/course/slightMooc/C101717497640610394
 看：页面监听和查询 -> 页面状态监听

 使用Navigation时的页面状态监听，其实就是监听监听NavDestination的生命周期变化，与NavDestination的生命周期各个回调函数是一致的，参考：A13_Navigation_lifecycle.ets
 其中的info.state就对应NavDestination的各个声明周期回调函数

 也可以对比router的页面状态监听，参考：A3_component_observer_Page.ets

 */
import { UIObserver } from '@kit.ArkUI'

@Entry
@Component
struct A17_Navigation_lifecycle_observer {
  @Provide('NavPathStack') pageStack: NavPathStack = new NavPathStack()
  //监听位置1：在page中监听如此处；监听位置2：在UIAbility监听，如EntryAbility.ets -> uiObserver.on("navDestinationUpdate"
  //info是NavDestinationInfo
  //info.state是NavDestinationState，其实就是对应NavDestinationInfo各个生命周期状态(A13_Navigation_lifecycle.ets),
  // 具体按住Ctrl+左键进入state，可看到：ON_SHOWN = 0；ON_HIDDEN = 1；ON_APPEAR = 2；ON_DISAPPEAR = 3；ON_WILL_SHOW = 4；ON_WILL_HIDE = 5；ON_WILL_APPEAR = 6；ON_WILL_DISAPPEAR = 7；ON_BACKPRESS = 100
  listener: (info: NavDestinationInfo) => void = (info) => {
    // NavDestinationState.ON_SHOWN = 0, NavDestinationState.ON_HIDE = 1
    if (info.state == 0) {
      // NavDestination组件显示时操作
      console.error("page-执行navDestinationUpdate-ON_SHOWN:" + JSON.stringify(info))
    } else if (info.state == 1) {
      // NavDestination组件隐藏时操作
      console.error("page-执行navDestinationUpdate-ON_HIDE:" + JSON.stringify(info))
    } else {
      // NavDestination组件其他操作，2,3,4,5,6,7,100
      console.error("page-执行navDestinationUpdate-其它:" + info.state + "," + JSON.stringify(info))
    }
  }

  @Builder
  PagesMap(name: string) {
    if (name == 'NavPage') {
      NavPage()
    }
  }

  /**
   * 注册监听
   * 注意这里的uiObserver可以是从@kit.ArkUI导入的uiObserver，也可以是UIContext的getUIObserver() 对比“A18_Navigation_NavDestinationSwitchInfo.ets”里的
   */
  aboutToAppear(): void {
    let uiContext: UIContext = this.getUIContext()
    let uiObserver: UIObserver = uiContext.getUIObserver()
    uiObserver.on("navDestinationUpdate", this.listener)
  }

  /**
   * 取消监听
   * 注意这里的uiObserver可以是从@kit.ArkUI导入的uiObserver，也可以是UIContext的getUIObserver() 对比“A18_Navigation_NavDestinationSwitchInfo.ets”里的
   */
  aboutToDisappear(): void {
    let uiContext: UIContext = this.getUIContext()
    let uiObserver: UIObserver = uiContext.getUIObserver()
    uiObserver.off("navDestinationUpdate", this.listener)
  }

  build() {
    Navigation(this.pageStack) {
      Button('Push NavPage')
        .margin(20)
        .width('80%')
        .onClick(() => {
          this.pageStack.pushPathByName('NavPage', '');
        })
    }
    .mode(NavigationMode.Stack)
    .title('Main')
    .navDestination(this.PagesMap)
  }
}

@Component
export struct NavPage {
  @Consume('NavPathStack') pageStack: NavPathStack;

  aboutToAppear(): void {
  }

  build() {
    NavDestination() {
      Stack({ alignContent: Alignment.Center }) {
        Column() {
          Text("NavDestination Page")
            .fontSize(20)
            .margin(100)
        }
      }.height("100%").width('100%')
    }
    .onWillAppear(() => {
    })
    .onWillShow(() => {
    })
    .onShown(() => {
    })
    .onWillHide(() => {
    })
    .onHidden(() => {
    })
    .onWillDisappear(() => {
    })
  }

  aboutToDisappear(): void {
  }

  // onAppear(event: () => void): CommonAttribute {
  // }

  // onDisAppear(event: () => void): CommonAttribute {
  // }
}
