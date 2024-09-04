import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { Router, window } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';

export default class TargetAbility extends UIAbility {
  targetPageWant:Want|undefined = undefined
  uiContext: UIContext | undefined = undefined;

  /**
   * 热启动：onNewWant
   * @param want
   * @param launchParam
   */
  onNewWant(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    // console.error("执行EntryAbility-onNewWant")
    if (want?.parameters?.router && want.parameters.router === 'targetPage1') {
      let targetUrl = 'pages/Z5_TargetPage1'
      if (this.uiContext) {
        //可以通过UIContext获取router,然后通过router打开页面
        let router: Router = this.uiContext.getRouter();
        console.error("执行热启动TargetAbility的第一个页面")
        router.pushUrl({
          url: targetUrl
        }).catch((err: BusinessError) => {
          console.error("执行热启动TargetAbility的第一个页面："+JSON.stringify(err))
        });
      }


    }
  }
  /**
   * 冷启动：onCreate -> onWindowStageCreate
   * @param want
   * @param launchParam
   */
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    console.error("执行TargetAbility-onCreate-------------")
    //把want存起来，供onWindowStageCreate使用
    this.targetPageWant = want
  }

  onDestroy(): void {
    // console.error("执行EntryAbility-onDestroy")
  }

  /**
   * 可以通过window.WindowStage 获取 window.Window
   * @param windowStage
   */
  onWindowStageCreate(windowStage: window.WindowStage): void {
    // console.error("执行EntryAbility-onWindowStageCreate")

    let url = 'pages/Z5_TargetPage1'
    if (this.targetPageWant?.parameters?.router && this.targetPageWant.parameters.router === 'targetPage2') {
      console.error("执行冷启动TargetAbility的第二个页面")
      url = 'pages/Z5_TargetPage2';
    }
    windowStage.loadContent(url, (err,data) => {
      console.error("执行loadContent的data："+JSON.stringify(data))
      if (err.code) {
        return;
      }
      let windowClass: window.Window;
      //通过getMainWindow获取window.Window
      windowStage.getMainWindow((err, data) => {
        console.error("执行getMainWindow的data："+JSON.stringify(data))
        if (err.code) {
          return;
        }
        windowClass = data;
        //获取UIContext
        this.uiContext = windowClass.getUIContext();
      });
    });
  }

  onWindowStageWillDestroy(windowStage: window.WindowStage): void {
    // console.error("执行EntryAbility-onWindowStageWillDestroy")
  }

  onWindowStageDestroy(): void {
    // console.error("执行EntryAbility-onWindowStageDestroy")
    // Main window is destroyed, release UI related resources
  }

  onForeground(): void {
    // console.error("执行EntryAbility-onForeground")
    // Ability has brought to foreground
  }

  onBackground(): void {
    // console.error("执行EntryAbility-onBackground")
    // Ability has back to background
  }
}
