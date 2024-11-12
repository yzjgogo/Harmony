/**
 https://developer.huawei.com/consumer/cn/training/course/slightMooc/C101717496870909384
 基础语法描述
 声明式UI描述

 <HarmonyOS第一课>ArkTS语法介绍
 参考：ArkUI基本组成.jpg

 Divider()：
 分割线，此处似乎有让整个布局水平剧中的效果，不知道为什么，因为如果不使用这个分割线，整个布局(Hello World和Click me)都靠左展示
 */
import { promptAction } from '@kit.ArkUI'

@Entry
@Component
struct A0_ArkTS_base_zucheng {
  @State myText: string = 'World'

  build() {
    //配置子组件:如果组件支持子组件配置，则需在尾随闭包"{...}"中为组件添加子组件的UI描述。Column、Row、Stack、Grid、List等组件都是容器组件。
    //这里的Column就支持子组件配置，因此在后面的{}里进行子组件的配置
    Column() {
      //创建组件：有参数：如果组件的接口定义包含构造参数，则在组件后面的“()”需要配置相应参数。
      //Ctrl+鼠标左键进入看到 Text -> TextInterface{(content?: string | Resource, value?: TextOptions): TextAttribute;},因此可以有参数
      Text(`Hello ${this.myText}`)
        .fontSize(50)
      // 创建组件：无参数：如果组件的接口定义没有包含必选构造参数，则组件后面的“()”不需要配置任何内容
      //Ctrl+鼠标左键进入看到 Divider -> DividerInterface{(): DividerAttribute;}，因此这里无参数
      Divider()
      Button('Click me')
        .onClick(() => {
          this.myText = 'ArkUI'
        })
        //属性方法以“.”链式调用的方式配置系统组件的样式和其他属性，建议每个属性方法单独写一行
        .height(50)
        .width(100)
        .margin({ top: 20 })
      Text('使用组件的成员函数配置组件的事件方法，需要bind this。但是ArkTS不推荐这种方式')
        .backgroundColor(Color.Orange)
        .onClick(this.myClickHandler.bind(this))
      Text('使用声明的箭头函数，可以直接调用，不需要bind this。')
        .backgroundColor(Color.Green)
        .onClick(this.myArrowFun)
    }
  }
  myClickHandler(){
    promptAction.showToast({message:"使用组件的成员函数配置组件的事件方法，需要bind this。但是ArkTS不推荐这种方式"})
  }

  myArrowFun=()=>{
  //即使不用bind(this),箭头函数里面仍然可以使用this访问组件
    promptAction.showToast({message:"使用声明的箭头函数，可以直接调用，不需要bind this。"+this.myText})
  }
}