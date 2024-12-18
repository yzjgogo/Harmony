import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { UIObserver, window } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';

/**
 UIAbility声明周期
 https://developer.huawei.com/consumer/cn/training/course/slightMooc/C101717497122909477
 */
export default class EntryAbility extends UIAbility {
  myWindowStage: window.WindowStage|undefined = undefined

  /**
   * 类似android的onNewIntent
   * 当UIAbility为singleton启动模式且UIAbility的实力已经存在时。
   *
   * 每次调用startAbility()方法时，如果应用进程中该类型的UIAbility实例已经存在，则复用系统中的UIAbility实例。系统中只存在唯一一个该UIAbility实例，即在最近任务列表中只存在一个该类型的UIAbility实例。
   *
   * 当UIAbility为singleton启动模式时
   * 如果应用的UIAbility实例已创建，再次调用startAbility()方法启动该UIAbility实例。由于启动的还是原来的UIAbility实例，并未重新创建一个新的UIAbility实例，此时只会进入该UIAbility的onNewWant()回调，不会进入其onCreate()和onWindowStageCreate()生命周期回调
   * @param want
   * @param launchParam
   */
  onNewWant(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    console.error("执行EntryAbility-onNewWant")
  }
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    console.error("执行EntryAbility-onCreate")
    //this.context就是UIAbilityContext
    let context = this.context
    //EventHub步骤2：注册(订阅)事件
    let eventhub = this.context.eventHub;
    //订阅方式1
    eventhub.on('event1', this.eventFunc);
    //订阅方式2
    eventhub.on('event1', (data: string) => {
      // 触发事件，完成相应的业务操作
      console.error(`执行箭头event：${data}`);
    });
  }
  //EventHub步骤3：接收事件参数的类型可以用Context接收，即使咱们在A8_UIAbility_EventHub里传递的参数是number类型的1和string类型的'事件test',也可以用Context接收，当然你也可以用number和string接收
  eventFunc(argOne: Context, argTwo: Context): void {
    console.error(`执行eventFunc：${argOne}, ${argTwo}`);
    return;
  }
  onDestroy(): void {
    console.error("执行EntryAbility-onDestroy")
    //EventHub步骤4-1：在合适的位置取消事件的订阅
    this.context.eventHub.off('event1');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    this.myWindowStage = windowStage
    console.error("执行EntryAbility-onWindowStageCreate")
    // 设置WindowStage的事件订阅（获焦/失焦、可见/不可见）
    try {
      windowStage.on('windowStageEvent', (data) => {
        let stageEventType: window.WindowStageEventType = data;
        switch (stageEventType) {
          case window.WindowStageEventType.SHOWN: // 切到前台
            console.error("执行EntryAbility-切到前台-SHOWN")
            break;
          case window.WindowStageEventType.ACTIVE: // 获焦状态
            console.error("执行EntryAbility-获焦状态-ACTIVE")
            break;
          case window.WindowStageEventType.INACTIVE: // 失焦状态
            console.error("执行EntryAbility-失焦状态-INACTIVE")
            break;
          case window.WindowStageEventType.HIDDEN: // 切到后台
            console.error("执行EntryAbility-切到后台-HIDDEN")
            break;
          case window.WindowStageEventType.RESUMED: // 前台可交互状态
            console.error("执行EntryAbility-前台可交互状态-RESUMED")
            break;
          case window.WindowStageEventType.PAUSED: // 前台不可交互状态
            console.error("执行EntryAbility-前台不可交互状态-PAUSED")
            break;
          default:
            break;
        }
      });
    } catch (exception) {
      console.error("执行EntryAbility-异常："+JSON.stringify(exception))
    }

    windowStage.loadContent('pages/A3_component_observer_Page', (err) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content.');
    });

    windowStage.getMainWindow((err,data)=>{
      let windowClass:window.Window = data
      let uiContext: UIContext = windowClass.getUIContext()
      let uiObserver:UIObserver = uiContext.getUIObserver()
      //在‘A13_Navigation_observer.ets’才用到这里的“navDestinationUpdate”监听，用于注册NavDestination生命周期变化的监听
      //info是NavDestinationInfo
      //info.state是NavDestinationState，其实就是对应NavDestinationInfo各个生命周期状态(A13_Navigation_lifecycle.ets),
      // 具体按住Ctrl+左键进入state，可看到：ON_SHOWN = 0；ON_HIDDEN = 1；ON_APPEAR = 2；ON_DISAPPEAR = 3；ON_WILL_SHOW = 4；ON_WILL_HIDE = 5；ON_WILL_APPEAR = 6；ON_WILL_DISAPPEAR = 7；ON_BACKPRESS = 100
      uiObserver.on("navDestinationUpdate",(info)=>{
        // NavDestinationState.ON_SHOWN = 0, NavDestinationState.ON_HIDE = 1
        if(info.state == 0){
          // NavDestination组件显示时操作
          console.error("执行navDestinationUpdate-ON_SHOWN:"+JSON.stringify(info))
        }else if(info.state == 1){
          // NavDestination组件隐藏时操作
          console.error("执行navDestinationUpdate-ON_HIDE:"+JSON.stringify(info))
        }else {
          // NavDestination组件其他操作，2,3,4,5,6,7,100
          console.error("执行navDestinationUpdate-其它:"+info.state+","+JSON.stringify(info))
        }
      })
    })
  }

  onWindowStageWillDestroy(windowStage: window.WindowStage): void {
    // 释放通过windowStage对象获取的资源
    console.error("执行EntryAbility-onWindowStageWillDestroy")
  }

  onWindowStageDestroy(): void {
    // 释放UI资源
    // 例如在onWindowStageDestroy()中注销WindowStage事件订阅（获焦/失焦、切到前台/切到后台、前台可交互/前台不可交互）
    console.error("执行EntryAbility-onWindowStageDestroy")
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
    try {
      if (this.myWindowStage) {
        this.myWindowStage.off('windowStageEvent');
      }
    } catch (err) {
      let code = (err as BusinessError).code;
      let message = (err as BusinessError).message;
      hilog.error(0x0000, 'testTag', `Failed to disable the listener for windowStageEvent. Code is ${code}, message is ${message}`);
    }
  }

  // 申请系统需要的资源，或者重新申请在onBackground()中释放的资源
  onForeground(): void {
    console.error("执行EntryAbility-onForeground")
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }
  // 释放UI不可见时无用的资源，或者在此回调中执行较为耗时的操作
  // 例如状态保存等
  onBackground(): void {

    console.error("执行EntryAbility-onBackground")
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
