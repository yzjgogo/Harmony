/**
 https://developer.huawei.com/consumer/cn/training/course/slightMooc/C101717497640610394
 https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-custom-component-api-V5#querynavdestinationinfo
 看：页面监听和查询 -> 页面信息查询
  查询组件当前所在的Navigation的路由信息：
 queryNavigationInfo() ： 查询当前组件所属Navigation的信息，查询不到就返回undefined
 queryNavDestinationInfo() : 查询当前组件所属NavDestination的信息，查询不到就返回undefined
 */
import { uiObserver } from '@kit.ArkUI'

@Entry
@Component
struct A16_Navigation_NavDestinationInfo {
  @Provide('NavPathStack') pageStack: NavPathStack = new NavPathStack()

  @Builder
  PagesMap(name: string) {
    if (name == 'NavPage') {
      NavPage()
    }
  }

  build() {
    Navigation(this.pageStack) {
      Button('Push NavPage')
        .margin(20)
        .width('80%')
        .onClick(() => {
          this.pageStack.pushPathByName('NavPage', '');
        })
      Button('DoSomething')
        .margin(20)
        .width('80%')
        .onClick(() => {
          //在Navigation下即获取不到NavigationInfo又获取不到NavDestinationInfo
          let navDestinaionInfo:uiObserver.NavDestinationInfo | undefined = this.queryNavDestinationInfo()
          let navigationInfo:uiObserver.NavigationInfo | undefined = this.queryNavigationInfo()
          console.error(`执行获取导航信息5：${JSON.stringify(navDestinaionInfo)}`)
          console.error(`执行获取导航信息6：${JSON.stringify(navigationInfo)}`)
        })
      MyNavComp()
    }
    .mode(NavigationMode.Split)
    .title('Main')
    .navDestination(this.PagesMap)
  }
}
@Component
export struct NavPage {
  @Consume('NavPathStack') pageStack: NavPathStack;

  build() {
    NavDestination() {
      Stack({ alignContent: Alignment.Center }) {
        Column() {
          Text("NavDestination Page")
            .fontSize(20)
            .margin(100)
            .onClick(()=>{
              //在NavDestination下，可以获取到NavigationInfo，但获取不到NavDestinationInfo
              let navDestinaionInfo:uiObserver.NavDestinationInfo | undefined = this.queryNavDestinationInfo()
              let navigationInfo:uiObserver.NavigationInfo | undefined = this.queryNavigationInfo()
              console.error(`执行获取导航信息3：${JSON.stringify(navDestinaionInfo)}`)
              console.error(`执行获取导航信息4：${JSON.stringify(navigationInfo)}`)
            })
          MyComp()
        }
      }.height("100%").width('100%')
    }
  }
}

/**
 * 这个组件用到NavDestination里，既可以获取到NavigationInfo又能获取到NavDestinationInfo
 */
@Component
struct MyComp {

  build() {
    Text('我是一个组件')
      .padding(20)
      .backgroundColor(Color.Green)
      .onClick(()=>{
        let navDestinaionInfo:uiObserver.NavDestinationInfo | undefined = this.queryNavDestinationInfo()
        let navigationInfo:uiObserver.NavigationInfo | undefined = this.queryNavigationInfo()
        console.error(`执行获取导航信息1：${JSON.stringify(navDestinaionInfo)}`)
        console.error(`执行获取导航信息2：${JSON.stringify(navigationInfo)}`)
      })
  }
}


/**
  这个组件用到Navigation里，可以获取到NavigationInfo，但获取不到NavDestinationInfo
 */
@Component
struct MyNavComp {

  build() {
    Text('我是一个Nav组件')
      .padding(20)
      .backgroundColor(Color.Green)
      .onClick(()=>{
        let navDestinaionInfo:uiObserver.NavDestinationInfo | undefined = this.queryNavDestinationInfo()
        let navigationInfo:uiObserver.NavigationInfo | undefined = this.queryNavigationInfo()
        console.error(`执行获取导航信息7：${JSON.stringify(navDestinaionInfo)}`)
        console.error(`执行获取导航信息8：${JSON.stringify(navigationInfo)}`)
      })
  }
}
