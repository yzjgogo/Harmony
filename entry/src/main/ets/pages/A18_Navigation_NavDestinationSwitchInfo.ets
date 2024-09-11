/**
 *
 https://developer.huawei.com/consumer/cn/training/course/slightMooc/C101717497640610394
 看：页面监听和查询 -> 也可以注册页面切换的状态回调

 用于监听使用Navigation时，当NavDestination发生切换时的监听
 https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/js-apis-arkui-observer-V5#navdestinationswitchinfo12

 */
import { BusinessError } from '@kit.BasicServicesKit'
import { UIObserver, uiObserver } from '@kit.ArkUI'
import { common } from '@kit.AbilityKit'

@Entry
@Component
struct A18_Navigation_NavDestinationSwitchInfo {
  listener:(info:uiObserver.NavDestinationSwitchInfo) => void = (info) => {
    console.error("执行NavDestinationSwitchInfo："+JSON.stringify(info))
  }

  @Provide('pageInfos') pageInfos: NavPathStack = new NavPathStack()

  private arr: number[] = [1, 2, 3,4];

  @Builder
  PageMap(name: string) {
    if (name === "NavDestinationTitle1") {
      pageOneTmp()
    } else if (name === "NavDestinationTitle2") {
      pageTwoTmp()
    } else if (name === "NavDestinationTitle3") {
      pageThreeTmp()
    } else if (name === "NavDestinationTitle4") {
      pageFourTmp()
    }
  }

  /**
   * 注册监听，on的第二个参数可以是UIContext 也可以是 UIAbilityContext
   * 注意这里的uiObserver是从@kit.ArkUI导入的uiObserver，不是UIContext的getUIObserver()，对比“A17_Navigation_lifecycle_observer.ets”里的
   */
  aboutToAppear(): void {
    let context: UIContext = this.getUIContext()
    // let context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;
    uiObserver.on("navDestinationSwitch",context, this.listener)
  }

  /**
   * 取消监听，on的第二个参数可以是UIContext 也可以是 UIAbilityContext
   * 注意这里的uiObserver是从@kit.ArkUI导入的uiObserver，不是UIContext的getUIObserver()，对比“A17_Navigation_lifecycle_observer.ets”里的
   */
  aboutToDisappear(): void {
    let context: UIContext = this.getUIContext()
    // let context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;
    uiObserver.off("navDestinationSwitch",context,this.listener)
  }

  build() {
    Column() {
      Navigation(this.pageInfos) {
        List({ space: 12 }) {
          ForEach(this.arr, (item: string) => {
            ListItem() {
              Text("NavRouter" + item)
                .width("100%")
                .height(72)
                .backgroundColor('#FFFFFF')
                .borderRadius(24)
                .fontSize(16)
                .fontWeight(500)
                .textAlign(TextAlign.Center)
                .onClick(() => {
                  console.error("执行跳转-=0")
                  this.pageInfos.pushPath({ name: "NavDestinationTitle" + item })

                })
            }
          }, (item: string): string => item)
        }
        .width("90%")
        .margin({ top: 12 })
      }
      .mode(NavigationMode.Split)
      .navDestination(this.PageMap)
    }
    .height('100%')
    .width('100%')
    .backgroundColor('#F1F3F5')
  }
}

// PageOne.ets
@Component
export struct pageOneTmp {
  @Consume('pageInfos') pageInfos: NavPathStack;

  build() {
    NavDestination() {
      Column() {
        Text("NavDestinationContent1")
      }.width('100%').height('100%')
    }.title("NavDestinationTitle1")
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop() // 弹出路由栈栈顶元素
      console.error('执行pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true
    })
  }
}

// PageTwo.ets
@Component
export struct pageTwoTmp {
  @Consume('pageInfos') pageInfos: NavPathStack;

  build() {
    NavDestination() {
      Column() {
        Text("NavDestinationContent2")
      }.width('100%').height('100%')
    }.title("NavDestinationTitle2")
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop() // 弹出路由栈栈顶元素
      console.error('执行pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true
    })
  }
}

// PageThree.ets
@Component
export struct pageThreeTmp {
  @Consume('pageInfos') pageInfos: NavPathStack;

  build() {
    NavDestination() {
      Column() {
        Text("NavDestinationContent3")
      }.width('100%').height('100%')
    }.title("NavDestinationTitle3")
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop() // 弹出路由栈栈顶元素
      console.error('执行pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true
    })
  }
}

// PageThree.ets
@Component
export struct pageFourTmp {
  @Consume('pageInfos') pageInfos: NavPathStack;

  build() {
    NavDestination() {
      Stack() {
        Column() {
          Text("Dialog NavDestination")
            .fontSize(20)
            .margin({ bottom: 100 })
          Button("Close").onClick(() => {
            this.pageInfos.pop()
          }).width('30%')
        }
        .width('50%')
        .height('50%')
        .backgroundColor(Color.White)
        .borderRadius(10)
      }
      .width('100%')
      .height('100%')
    }
    .backgroundColor('rgba(0,0,0,0.5)')
    .hideTitleBar(true)
    .mode(NavDestinationMode.DIALOG)
  }
}