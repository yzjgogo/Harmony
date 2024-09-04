/**
 https://developer.huawei.com/consumer/cn/training/course/slightMooc/C101717497122909477
 UIAbility组件间交互（设备内）：
 1：启动应用内的UIAbility
 2：启动应用内的UIAbility并获取返回结果
 3：启动UIAbility的指定页面，涉及到UIContext、router、window.Window

 */
import { common, Want } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';

@Entry
@Component
struct A9_UIAbility_operation {
  build() {
    Column() {
      Text("启动应用内的UIAbility：参考：A6_UIAbility_start_mode")
        .backgroundColor(Color.Orange)
        .padding(10)
        .margin({ top: 10 })


      Text("terminateSelf() -> 停止当前UIAbility实例")
        .backgroundColor(Color.Orange)
        .padding(10)
        .margin({ top: 10 })
        .onClick(() => {
          // 此时的mContext其实就是EntryAbility的Context，可以理解为能访问到EntryAbility的一切
          //即mContext == EntryAbility.this.context == common.UIAbilityContext
          //你在这里调用mContext.terminateSelf 和 在EntryAbility里调用this.context.terminateSelf效果一样，都是杀掉EntryAbility
          //terminateSelf会杀掉当前UIAbility会触发UIAbility的onDestroy，但是在任务列表(手指从下贴边往上滑的后台任务列表)会保留这个死掉的UIAbility的快照，方便再次快捷启动
          //如果希望连这个死掉的快照都不保留，则配置removeMissionAfterTerminate字段配置为true，参考：D:\Harmony\Study\Harmony\entry\src\main\module.json5 -> abilities -> EntryAbility -> removeMissionAfterTerminate
          let mContext: common.UIAbilityContext = getContext(this) as common.UIAbilityContext
          mContext.terminateSelf((err) => {
            console.error("执行停止自己报错：" + err.message)
          })
        })


      Text("启动应用内的UIAbility并获取返回结果，类似Android的startActivityForResult")
        .backgroundColor(Color.Orange)
        .padding(10)
        .margin({ top: 10 })
        .onClick(() => {
          //点击这里，启动ForResultAbility -> ForResultAbility加载的Z4_ForResultPage -> 在Z4_ForResultPage中调用ForResultAbility的terminateSelfWithResult()方法的同时设置返回的数据
          // -> 此处EntryAbility的startAbilityForResult回调函数就能拿到这个数据。
          let context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;
          const RESULT_CODE: number = 1001;
          let want: Want = {
            deviceId: '', // deviceId为空表示本设备
            bundleName: 'com.example.myapplication',
            moduleName: 'entry', // moduleName非必选
            abilityName: 'ForResultAbility',
            parameters: {
              // 自定义信息
              info: '来自EntryAbility的页面'
            }
          };
          context.startAbilityForResult(want).then((data) => {
            if (data?.resultCode === RESULT_CODE) {
              // 解析被调用方UIAbility返回的信息
              let info = data.want?.parameters?.info;
              console.error("执行获取到返回的数据：" + JSON.stringify(info))
            }
          }).catch((err: BusinessError) => {
            console.error("执行获取到返回的数据出错：" + JSON.stringify(err))
          });

        })


      Text("启动UIAbility的指定页面 -> 目标UIAbility冷启动，其实就是走目标UIAbility的onCreate()和onWindowStageCreate（）")
        .backgroundColor(Color.Orange)
        .padding(10)
        .margin({ top: 10 })
        .onClick(() => {
          let context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext; // UIAbilityContext
          let want: Want = {
            deviceId: '', // deviceId为空表示本设备
            bundleName: 'com.example.myapplication',
            moduleName: 'entry', // moduleName非必选
            abilityName: 'TargetAbility',
            parameters: {
              // 自定义参数传递页面信息
              router: 'targetPage2'
            }
          };
          // context为调用方UIAbility的UIAbilityContext
          context.startAbility(want).then(() => {
            console.error("目标UIAbility冷启动成功")
          }).catch((err: BusinessError) => {
            console.error("目标UIAbility冷启动失败")
          });
        })


      Text("启动UIAbility的指定页面 -> 目标UIAbility热启动，说明目标UIAbility已经创建成功，其实就是走目标UIAbility的onNewWant()")
        .backgroundColor(Color.Orange)
        .padding(10)
        .margin({ top: 10 })
        .onClick(() => {
          let context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext; // UIAbilityContext
          let want: Want = {
            deviceId: '', // deviceId为空表示本设备
            bundleName: 'com.example.myapplication',
            moduleName: 'entry', // moduleName非必选
            abilityName: 'TargetAbility',
            parameters: {
              // 自定义参数传递页面信息
              router: 'targetPage1'
            }
          };
          // context为调用方UIAbility的UIAbilityContext
          context.startAbility(want).then(() => {
            console.error("目标UIAbility热启动成功")
          }).catch((err: BusinessError) => {
            console.error("目标UIAbility热启动失败")
          });
        })
    }
  }
}