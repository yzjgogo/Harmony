/**
  自定义组件：由@Component struct 组件名 {}共同组成
 自定义组件不能有继承关系（怎么理解）？

 @Component:
 @Component装饰器仅能装饰struct关键字声明的数据结构。struct被@Component装饰后具备组件化的能力，需要实现build方法描述UI，一个struct只能被一个@Component装饰。@Component可以接受一个可选的bool类型参数。
 https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/arkts-custom-components-freeze-V5
 @Component({ freezeWhenInactive: true })
 struct MyComponent {
 }

 build()函数：
 build()函数用于定义自定义组件的声明式UI描述，自定义组件必须定义build()函数。

 @Entry:
 @Entry装饰的自定义组件将作为UI页面的入口。在单个UI页面中，最多可以使用@Entry装饰一个自定义组件。@Entry可以接受一个可选的LocalStorage的参数或者一个可选的EntryOptions参数。
 在https://developer.huawei.com/consumer/cn/training/course/slightMooc/C101717496870909384里搜索@Entry了解更多

 @Reusable：
 @Reusable装饰的自定义组件具备可复用能力
 */
import { promptAction } from '@kit.ArkUI';

@Component
struct HelloComponent {
  //用@State定义子组件的变量需要初始化
  // @State message: string = 'Hello, World!';
  //用@Prop定义子组件的变量不需要初始化
  @Prop message: string;
  //成员函数
  doSomething() {

  }
  submitArrow?: () => void
  build() {
    // HelloComponent自定义组件组合系统组件Row和Text
    Column() {
      Text(this.message)
        .onClick(() => {
          // 状态变量message的改变驱动UI刷新，UI从'Hello, World!'刷新为'Hello, ArkUI!'
          this.message = 'Hello, ArkUI!';
        })
      Button('执行父组件传递过来的函数')
        .onClick(()=>{
          if(this.submitArrow){
            this.submitArrow()
          }else {
            promptAction.showToast({message:'父组件没传递过来'})
          }
        })
    }
  }
}
export default  HelloComponent