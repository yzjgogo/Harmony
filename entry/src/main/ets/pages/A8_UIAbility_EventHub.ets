/**
 *
 https://developer.huawei.com/consumer/cn/training/course/slightMooc/C101717497122909477
 UIAbility组件与UI的数据同步
 通过EventHub事件的发送让page的UI和UIAbility进行数据交互

 搜索：EventHub步骤

 这个案例涉及到在EntryAbility中接收事件。
 */
import { common, Want } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';

@Entry
@Component
struct A8_UIAbility_EventHub {
  private myContext = getContext(this) as common.UIAbilityContext;
  build() {
    Column() {
      Button("发送无参数事件")
        .onClick(()=>{
          //EventHub步骤1-1：发送事件-无参
          this.myContext.eventHub.emit('event1')
        })
        .margin(10)

      Button("发送1个参数事件")
        .onClick(()=>{
          //EventHub步骤1-2：发送事件-1个参数
          this.myContext.eventHub.emit('event1',1)
        })
        .margin(10)

      Button("发送2个参数事件")
        .onClick(()=>{
          //EventHub步骤1-3：发送事件-2个参数
          this.myContext.eventHub.emit('event1',2,'事件test')
        })
        .margin(10)

      Button("取消UIAbility中的事件订阅")
        .onClick(()=>{
          //EventHub步骤4-2：在合适的位置取消事件的订阅，也可以主动取消事件订阅
          this.myContext.eventHub.off('event1')
        })
        .margin(10)
    }
  }
}