/**
 https://developer.huawei.com/consumer/cn/training/course/slightMooc/C101717496870909384
 自定义组件监听页面生命周期

 https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/js-apis-arkui-observer-V5#observeronrouterpageupdate11
 无感监听页面路由,用于监听router中page页面的状态变化(生命周期函数的变化),例如uiObserver.RouterPageState.ON_PAGE_SHOW，uiObserver.RouterPageState.ON_PAGE_HIDE
 这些state对应A2_page_component_lifecycle.ets的各个生命周期函数
 Navigation是不是也适用呢
 * */
import { uiObserver, router, UIObserver } from '@kit.ArkUI';

@Entry
@Component
struct A3_component_observer_Page {
  //1-1可以在page(组件)里创建一个监听器
  listener: (info: uiObserver.RouterPageInfo) => void = (info: uiObserver.RouterPageInfo) => {
    let routerInfo: uiObserver.RouterPageInfo | undefined = this.queryRouterPageInfo();
    //这里之所以用(info.pageId == routerInfo?.pageId)去判断，是因为我们那个button执行了"push self"，则多个page都会收到监听回调，
    //因此用this.queryRouterPageInfo()代表当前这个，来找到info对应的当前这个
    if (info.pageId == routerInfo?.pageId) {
      if (info.state == uiObserver.RouterPageState.ON_PAGE_SHOW) {
        console.error(`执行-A3_component_observer_Page onPageShow:${info.pageId}`);
      } else if (info.state == uiObserver.RouterPageState.ON_PAGE_HIDE) {
        console.error(`执行-A3_component_observer_Page onPageHide:${info.pageId}`);
      }
    }
  }

  aboutToAppear(): void {
  //2-1在page(组件)的aboutToAppear中注册监听器，因为从A2_page_component_lifecycle中可知当前页面的aboutToAppear和所有的子组件的aboutToAppear都执行之后，才会执行页面的onPageShow，所以在这里注册监听是合适的
    //传入的'routerPageUpdate'是固定的，参考官网
    let uiObserver: UIObserver = this.getUIContext().getUIObserver();
    uiObserver.on('routerPageUpdate', this.listener);
  }

  aboutToDisappear(): void {
  //3-1 组件的aboutToDisappear执行最晚，目前已知只有遇到if为false或者杀死app时，才会执行aboutToDisappear,因此这里取消监听合适
    let uiObserver: UIObserver = this.getUIContext().getUIObserver();
    uiObserver.off('routerPageUpdate', this.listener);
  }

  build() {
    Column() {
      Text(`this page is ${this.queryRouterPageInfo()?.pageId}`)
        .fontSize(25)
      Button("push self")
        .onClick(() => {
          router.pushUrl({
            url: 'pages/A3_component_observer_Page'
          })
        })
      Column() {
        SubComponent()
      }
    }
  }
}

@Component
struct SubComponent {
  //1-2也可以在组件里创建一个监听器
  listener: (info: uiObserver.RouterPageInfo) => void = (info: uiObserver.RouterPageInfo) => {
    let routerInfo: uiObserver.RouterPageInfo | undefined = this.queryRouterPageInfo();
    if (info.pageId == routerInfo?.pageId) {
      if (info.state == uiObserver.RouterPageState.ON_PAGE_SHOW) {
        console.error(`执行-SubComponent onPageShow:${info.pageId}`);
      } else if (info.state == uiObserver.RouterPageState.ON_PAGE_HIDE) {
        console.error(`执行-SubComponent onPageHide:${info.pageId}`);
      }
    }
  }

  aboutToAppear(): void {
    //2-2在page(组件)的aboutToAppear中注册监听器，因为从A2_page_component_lifecycle中可知当前页面的aboutToAppear和所有的子组件的aboutToAppear都执行之后，才会执行页面的onPageShow，所以在这里注册监听是合适的
    let uiObserver: UIObserver = this.getUIContext().getUIObserver();
    uiObserver.on('routerPageUpdate', this.listener);
  }

  aboutToDisappear(): void {
    //3-2 组件的aboutToDisappear执行最晚，目前已知只有遇到if为false或者杀死app时，才会执行aboutToDisappear,因此这里取消监听合适
    let uiObserver: UIObserver = this.getUIContext().getUIObserver();
    uiObserver.off('routerPageUpdate', this.listener);
  }

  build() {
    Column() {
      Text(`SubComponent`)
    }
  }
}