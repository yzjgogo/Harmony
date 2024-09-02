/**
 *
 UIAbility组件启动模式
 https://developer.huawei.com/consumer/cn/training/course/slightMooc/C101717497122909477
 涉及到如何启动UIAbility 以及 UIAbility启动的同时传参

 UIAbilityContext 的 startAbility(want) 传递的want ,可以通过目标UIAbility的onNewWant和onCreate的方法的want参数接收。
 */
import { common, Want } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';

@Entry
@Component
struct A6_UIAbility_start_mode {
  private KEY_NO_CHANGE = 'aaa';
  private KEY_CHANGE = 'aaa';
  build() {
    Column() {
      Text("EntryAbility")
        .fontSize(30)

      Button("启动Singleton的UIAbility-SingletonAbility")
        .margin({top:30})
        .onClick(()=>{
          let context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;
          // context为调用方UIAbility的UIAbilityContext;
          let want: Want = {
            deviceId: '', // deviceId为空表示本设备
            bundleName: 'com.example.myapplication',
            abilityName: 'SingletonAbility',
            moduleName: 'entry', // moduleName非必选
          };
          context.startAbility(want).then(() => {
            console.error("启动单例的UIAbility成功")
          }).catch((err: BusinessError) => {
            console.error("启动单例的UIAbility失败："+err)
          })
        })

      Button("启动multiton的UIAbility-MultitonAbility")
        .margin({top:30})
        .onClick(()=>{
          let context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;
          // context为调用方UIAbility的UIAbilityContext;
          let want: Want = {
            deviceId: '', // deviceId为空表示本设备
            bundleName: 'com.example.myapplication',
            abilityName: 'MultitonAbility',
            moduleName: 'entry', // moduleName非必选
          };
          context.startAbility(want).then(() => {
            console.error("启动多例的UIAbility成功")
          }).catch((err: BusinessError) => {
            console.error("启动多例的UIAbility失败："+err)
          })
        })
      Column(){
        // 参考：MyAbilityStage
        Button("启动specified的UIAbility-SpecifiedAbility-1")
          .margin({top:30})
          .onClick(()=>{
            let context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;
            // context为调用方UIAbility的UIAbilityContext;
            let want: Want = {
              deviceId: '', // deviceId为空表示本设备
              bundleName: 'com.example.myapplication',
              abilityName: 'SpecifiedAbility',
              moduleName: 'entry', // moduleName非必选
              parameters: {
                // 自定义信息,Want可以通过parameters增加额外的参数
                instanceKey: this.KEY_CHANGE //传递一个可变的参数，这样多次点击这个按钮，在在MyAbilityStage的onAcceptWant中，如果识别到是参数没有存在过，则会创建SpecifiedAbility实例
              }
            };
            context.startAbility(want).then(() => {
              console.error("启动指定实例的UIAbility成功")
            }).catch((err: BusinessError) => {
              console.error("启动指定实例的UIAbility失败："+err)
            })
            this.KEY_CHANGE = this.KEY_CHANGE+'a'
          })

        Button("启动specified的UIAbility-SpecifiedAbility-2")
          .margin({top:30})
          .onClick(()=>{
            let context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;
            // context为调用方UIAbility的UIAbilityContext;
            let want: Want = {
              deviceId: '', // deviceId为空表示本设备
              bundleName: 'com.example.myapplication',
              abilityName: 'SpecifiedAbility',
              moduleName: 'entry', // moduleName非必选
              parameters: {
                // 自定义信息,Want可以通过parameters增加额外的参数
                instanceKey: this.KEY_NO_CHANGE //传递一个不变的参数，这样多次点击这个按钮，在MyAbilityStage的onAcceptWant中，如果识别到是这个参数，且SpecifiedAbility已经启动，则复用SpecifiedAbility走SpecifiedAbility的onNewWant
              }
            };
            context.startAbility(want).then(() => {
              console.error("启动指定实例的UIAbility成功")
            }).catch((err: BusinessError) => {
              console.error("启动指定实例的UIAbility失败："+err)
            })
          })
      }
      .backgroundColor(Color.Green)
      .padding(10)
    }
  }
}