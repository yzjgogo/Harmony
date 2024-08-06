/**
 https://developer.huawei.com/consumer/cn/training/course/slightMooc/C101717496870909384
 涉及的内容：
 创建自定义组件

 参考：HelloComponent
 其实A1_diy_component也是一个和HelloComponent完全一样的自定义组件，只是A1_diy_component
 被@Entry修饰，成为了页面入口组件，我们完全可以给HelloComponent添加@Entry修饰，让其也是一个页面
 */
import HelloComponent from '../component/HelloComponent'
import { promptAction } from '@kit.ArkUI'

class HelloComponentParam {
  message: string = ""
}

@Entry
@Component
struct A1_diy_component {
  //submit的类型是‘() => void’ 即无参数无返回值的一个函数
  submit: () => void = () => {
    promptAction.showToast({message:'我是父组件的箭头函数'})
  }
  param: HelloComponentParam = {
    message: 'Hello, World!',

    //不能这样传递箭头函数
    // submitArrow:this.submit

    //也不能这样传递箭头函数
    // submitArrow:() => {
    //   promptAction.showToast({message:'我是箭头函数'})
    // }
  }
  build() {
    Column() {
      Text('ArkUI message')
      HelloComponent(this.param)
        //自定义组件通用样式:在自定义组件当作普通组件实际使用处(例如此处)，可以给这个自定义组件整体设置样式
        //ArkUI给自定义组件设置样式时，相当于给MyComponent2套了一个不可见的容器组件，而这些样式是设置在容器组件上的，而非直接设置给MyComponent2的Button组件。通过渲染结果我们可以很清楚的看到，背景颜色红色并没有直接生效在Button上，而是生效在Button所处的开发者不可见的容器组件上。
        .width('100%')
        .backgroundColor(Color.Green);
      Divider()
      //可以这样传递箭头函数
      HelloComponent({message:'hello鸿蒙',submitArrow:this.submit})
        .backgroundColor(Color.Orange);
    }
  }
}