/**
 *

 */
import { common } from '@kit.AbilityKit';

@Entry
@Component
struct Z4_ForResultPage {
  build() {
    Row() {
      Text("在ForResultAbility停止自身时，需要调用terminateSelfWithResult()方法，把数据返回给EntryAbility")
        .margin({top:40})
        .fontSize(30)
        .onClick(()=>{
          let context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext; // UIAbilityContext
          const RESULT_CODE: number = 1001;
          let abilityResult: common.AbilityResult = {
            resultCode: RESULT_CODE,
            want: {
              bundleName: 'com.example.myapplication',
              moduleName: 'entry', // moduleName非必选
              abilityName: 'FuncAbilityB',
              parameters: {
                info: '来自ForResultAbility页面'
              },
            },
          };
          context.terminateSelfWithResult(abilityResult, (err) => {
            if (err.code) {
              console.error(`执行返回数据出错： ${err.code}, message is ${err.message}`);
              return;
            }
          });
        })
    }
  }
}