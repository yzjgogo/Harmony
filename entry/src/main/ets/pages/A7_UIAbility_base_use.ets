/**
 *
 https://developer.huawei.com/consumer/cn/training/course/slightMooc/C101717497122909477
 UIAbility组件基本用法
 1：指定UIAbility的启动页面
 2：获取UIAbility的上下文信息
 */
import { common, Want } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';

@Entry
@Component
struct A7_UIAbility_base_use {
  private myContext1 = getContext(this) as common.UIAbilityContext;
  startAbilityTest(): void {
    let myContext2 = getContext(this) as common.UIAbilityContext;
    // let want: Want = {
    //   // Want参数信息
    // };
    // myContext2.startAbility(want);
  }
  build() {
    Column() {
      //1：指定UIAbility的启动页面
      //参考：src/main/ets/entryability/EntryAbility.ets -> onWindowStageCreate -> windowStage.loadContent
      //应用中的UIAbility在启动过程中，需要指定启动页面，否则应用启动后会因为没有默认加载页面而导致白屏。可以在UIAbility的onWindowStageCreate()生命周期回调中，通过WindowStage对象的loadContent()方法设置启动页面。

      //2：获取UIAbility的上下文信息

      //a：在UIAbility中可以通过this.context获取UIAbility实例的上下文信息
      //参考：src/main/ets/entryability/EntryAbility.ets -> onCreate -> let context = this.context;

      //b：在页面中获取UIAbility实例的上下文信息，包括导入依赖资源context模块和在组件中定义一个context变量两个部分。
      // 参考本文件的myContext1 和 myContext2
    }
  }
}