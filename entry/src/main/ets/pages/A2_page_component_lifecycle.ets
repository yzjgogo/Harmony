/**
 https://developer.huawei.com/consumer/cn/training/course/slightMooc/C101717496870909384
 页面和自定义组件生命周期
 自定义组件：@Component装饰的UI单元，可以组合多个系统组件实现UI的复用，可以调用组件的生命周期。
 页面：即应用的UI页面。可以由一个或者多个自定义组件组成，@Entry装饰的自定义组件为页面的入口组件，即页面的根节点，一个页面有且仅能有一个@Entry。只有被@Entry装饰的组件才可以调用页面的生命周期。
 */
import LifeCycleComponent from '../component/LifeCycleComponent'
import { promptAction } from '@kit.ArkUI'


@Entry
@Component
struct A2_page_component_lifecycle {
  @State
  ifNeedComponent:boolean = true

  /**
   *组件即将出现时回调该接口，具体时机为在创建自定义组件的新实例后，在执行其build()函数之前执行。
   * @Entry修饰的页面，也被@Component，因此页面也是一个组件
   */
  aboutToAppear(): void {
    console.error("执行页面的aboutToAppear")
    promptAction.showToast({message:"执行看看看看"})
  }

  build() {
    Column() {
      Text('我是页面，用于演示生命周期')
        .onClick(()=>{
          //ifNeedComponent值的改变，会触发LifeCycleComponent 生命周期函数的执行，当ifNeedComponent从true变为false时，执行aboutToDisappear，从false变为true时，会触发aboutToAppear，onDidBuild的执行
          //杀死app时也会触发aboutToDisappear的执行
          this.ifNeedComponent = !this.ifNeedComponent
        })
      if(this.ifNeedComponent){
        LifeCycleComponent()
      }
    }
  }

  /**
   *组件build()函数执行完成之后回调该接口，不建议在onDidBuild函数中更改状态变量、使用animateTo等功能，这可能会导致不稳定的UI表现。
   * @Entry修饰的页面，也被@Component，因此页面也是一个组件
   */
  onDidBuild(): void {
    console.error("执行页面的onDidBuild")
  }

  /**
   * 页面每次显示时触发一次，包括路由过程、应用进入前台等场景。
   */
  onPageShow(): void {
    console.error("执行页面的onPageShow")
  }

  /**
   *页面每次隐藏时触发一次，包括路由过程、应用进入后台等场景。
   */
  onPageHide(): void {
    console.error("执行页面的onPageHide")
  }

  /**
   * aboutToDisappear函数在自定义组件析构销毁之前执行。不允许在aboutToDisappear函数中改变状态变量，特别是@Link变量的修改可能会导致应用程序行为不稳定。
   * @Entry修饰的页面，也被@Component，因此页面也是一个组件
   */
  aboutToDisappear(): void {
    console.error("执行页面的aboutToDisappear")
  }

  /**
   *当用户点击返回按钮时触发
   */
  onBackPress(): boolean | void {
    console.error("执行页面的onBackPress")
  }
}