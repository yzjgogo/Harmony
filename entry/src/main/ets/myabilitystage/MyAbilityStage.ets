import { AbilityConstant, AbilityStage, Configuration, Want } from '@kit.AbilityKit';
/**
 https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/abilitystage-V5
 https://developer.huawei.com/consumer/cn/training/course/slightMooc/C101717497122909477
 当时学AbilityStage时，是因为specified启动模式的UIAbility用到，用于通过onAcceptWant判断，是复用SpecifiedAbility实例，还是创建新的SpecifiedAbility实例
 */
export default class MyAbilityStage extends AbilityStage {
  onCreate(): void {
    console.error("--执行MyAbilityStage-onCreate")
    // 应用的HAP在首次加载的时，为该Module初始化操作
  }

  /**
   仅specified模式下触发

   * @param want
   * @returns 根据返回值是否已经存在过(是否通过该返回值创建过SpecifiedAbility实力，且SpecifiedAbility实力仍然存在)，来决定是复用SpecifiedAbility实例，还是创建新的SpecifiedAbility实例
   * 这个判断是系统来判断的，你只需要按照你的需求决定onAcceptWant怎么返回值就行
   */
  onAcceptWant(want: Want): string {
    // 仅specified模式下触发
    console.error("--执行MyAbilityStage-onAcceptWant")
    if (want.parameters) {
      return `${want.parameters.instanceKey}`;
    }
    return 'MyAbilityStage';
  }
  onConfigurationUpdate(newConfig: Configuration): void {
    //当系统全局配置发生变更时触发的事件，系统语言、深浅色等，配置项目前均定义在Configuration类中。
    console.error("--执行MyAbilityStage-onConfigurationUpdate")
  }
  onMemoryLevel(level: AbilityConstant.MemoryLevel): void {
    // 根据系统可用内存的变化情况，释放不必要的内存
    console.error("--执行MyAbilityStage-onMemoryLevel")
  }
}