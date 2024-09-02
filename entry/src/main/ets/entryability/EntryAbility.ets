import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
/**
 UIAbility声明周期
 https://developer.huawei.com/consumer/cn/training/course/slightMooc/C101717497122909477
 */
export default class EntryAbility extends UIAbility {

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
  }

  onDestroy(): void {
    console.error("执行EntryAbility-onDestroy")
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
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
          default:
            break;
        }
      });
    } catch (exception) {
      console.error("执行EntryAbility-异常："+JSON.stringify(exception))
    }

    windowStage.loadContent('pages/A6_UIAbility_start_mode', (err) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content.');
    });
  }

  onWindowStageWillDestroy(windowStage: window.WindowStage): void {
    console.error("执行EntryAbility-onWindowStageWillDestroy")
  }

  onWindowStageDestroy(): void {
    console.error("执行EntryAbility-onWindowStageDestroy")
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    console.error("执行EntryAbility-onForeground")
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    console.error("执行EntryAbility-onBackground")
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
