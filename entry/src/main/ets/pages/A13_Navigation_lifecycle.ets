/**
 https://developer.huawei.com/consumer/cn/training/course/slightMooc/C101717497640610394
 看：页面生命周期

 Navigation作为路由容器，其生命周期承载在NavDestination组件上(即我们只需关注NavDestination的生命周期即可？)，以组件事件的形式开放（即.onWillAppear() .onShown()等等）。

 其生命周期大致可分为三类，自定义组件生命周期、通用组件生命周期和自有生命周期。
 自定义组件生命周期：每一个自定义组件都有的，包括@Entry修饰的自定义组件(page) -> aboutToAppear和aboutToDisappear
 通用组件生命周期：任何组件都有的生命周期，包括自定义组件和系统自带组件等任何组件 -> OnAppear和OnDisappear；
 NavDestination自有生命周期：NavDestination自己的生命周期函数 -> onWillAppear、onWillShow、onShown、onWillHide、onHidden、onWillDisappear


 aboutToAppear：在创建自定义组件后，执行其build()函数之前执行（NavDestination创建之前），允许在该方法中改变状态变量，更改将在后续执行build()函数中生效。
 onWillAppear：NavDestination创建后，挂载到组件树之前执行，在该方法中更改状态变量会在当前帧显示生效。
 onAppear：通用生命周期事件，NavDestination组件挂载到组件树时执行。
 onWillShow：NavDestination组件布局显示之前执行，此时页面不可见（应用切换到前台不会触发）。
 onShown：NavDestination组件布局显示之后执行，此时页面已完成布局。
 onWillHide：NavDestination组件触发隐藏之前执行（应用切换到后台不会触发）。
 onHidden：NavDestination组件触发隐藏后执行（非栈顶页面push进栈，栈顶页面pop出栈或应用切换到后台）。
 onWillDisappear：NavDestination组件即将销毁之前执行，如果有转场动画，会在动画前触发（栈顶页面pop出栈）。
 onDisappear：通用生命周期事件，NavDestination组件从组件树上卸载销毁时执行。
 aboutToDisappear：自定义组件析构销毁之前执行，不允许在该方法中改变状态变量。


参考：Navigation生命周期.png
 */

@Entry
@Component
struct A13_Navigation_lifecycle {
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
    .onWillAppear(()=>{})
    .onWillShow(()=>{})
    .onShown(()=>{})
    .onWillHide(()=>{})
    .onHidden(()=>{})
    .onWillDisappear(()=>{})
  }
  aboutToDisappear(): void {
  }
  // onAppear(event: () => void): CommonAttribute {
  // }

  // onDisAppear(event: () => void): CommonAttribute {
  // }
}
