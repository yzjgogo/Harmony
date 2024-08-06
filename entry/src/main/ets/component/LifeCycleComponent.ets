/**
 *
 */

@Component
struct LifeCycleComponent {
  /**
   * 组件即将出现时回调该接口，具体时机为在创建自定义组件的新实例后，在执行其build()函数之前执行。
   */
  aboutToAppear(): void {
    console.error("执行组件的-aboutToAppear")
  }

  build() {
    Column() {
      Text("我是自定义组件，用来演示生命周期")
    }.backgroundColor(Color.Green)
  }

  /**
   * 组件build()函数执行完成之后回调该接口，不建议在onDidBuild函数中更改状态变量、使用animateTo等功能，这可能会导致不稳定的UI表现。
   */
  onDidBuild(): void {
    console.error("执行组件的-onDidBuild")
  }

  /**
   * aboutToDisappear函数在自定义组件析构销毁之前执行。不允许在aboutToDisappear函数中改变状态变量，特别是@Link变量的修改可能会导致应用程序行为不稳定。
   */
  aboutToDisappear(): void {
    console.error("执行组件的-aboutToDisappear")
  }
}

export default LifeCycleComponent