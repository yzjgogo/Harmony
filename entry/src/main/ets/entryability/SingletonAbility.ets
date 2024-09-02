import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';

export default class SingletonAbility extends UIAbility {
  onNewWant(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    // console.error("执行EntryAbility-onNewWant")
  }
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    // console.error("执行EntryAbility-onCreate")
  }

  onDestroy(): void {
    // console.error("执行EntryAbility-onDestroy")
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // console.error("执行EntryAbility-onWindowStageCreate")

    windowStage.loadContent('pages/Z1_SingletonPage', (err) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content.');
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
