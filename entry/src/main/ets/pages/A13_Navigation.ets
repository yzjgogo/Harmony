/**
 */
import { BusinessError } from '@kit.BasicServicesKit'

@Entry
@Component
struct A13_Navigation {
  @State TooTmp1: ToolbarItem = {
    'value': "客服", 'icon': $r('app.media.shs_brower_check'), 'action': () => {
      this.pageInfos.popToName("NavDestinationTitle1")
    }
  }
  @State TooTmp2: ToolbarItem = {
    'value': "推荐", 'icon': './image/shs_friend_check.png', 'action': () => {
      this.pageInfos.popToIndex(1)
    }
  }
  @State TooTmp3: ToolbarItem = {
    'value': "好评", 'icon': 'resources/base/media/shs_me_check.png', 'action': () => {
      this.pageInfos.clear()
    }
  }

  //NavPathStack页面栈继承示例：https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-navigation-V5#%E7%A4%BA%E4%BE%8B10
  @Provide('pageInfos') pageInfos: NavPathStack = new NavPathStack()

  private arr: number[] = [1, 2, 3,4];

  aboutToAppear(): void {
    /*
    this.pageInfos.setInterception({
      willShow: (from: NavDestinationContext | "navBar", to: NavDestinationContext | "navBar",
        operation: NavigationOperation, animated: boolean) => {
        console.error("执行setInterception:"+(typeof from)+","+(typeof to)+","+operation)
        if (typeof to === "string") {
          console.log("target page is navigation home page.");
          return;
        }
        // 将跳转到PageTwo的路由重定向到PageOne
        let target: NavDestinationContext = to as NavDestinationContext;
        if (target.pathInfo.name === 'NavDestinationTitle2') {
          target.pathStack.pop();//想重定向，也需要pop()一下
          target.pathStack.pushPathByName('NavDestinationTitle1', null);
        }
      }
    })
    */
  }

  @Builder
  PageMap(name: string) {
    if (name === "NavDestinationTitle1") {
      pageOneTmp()
    } else if (name === "NavDestinationTitle2") {
      pageTwoTmp()
    } else if (name === "NavDestinationTitle3") {
      pageThreeTmp()
    } else if (name === "NavDestinationTitle4") {
      pageFourTmp()
    }
  }

  build() {
    Column() {
      Navigation(this.pageInfos) {
        TextInput({ placeholder: 'search...' })
          .width("90%")
          .height(40)
          .backgroundColor('#FFFFFF')

        List({ space: 12 }) {
          ForEach(this.arr, (item: string) => {
            ListItem() {
              Text("NavRouter" + item)
                .width("100%")
                .height(72)
                .backgroundColor('#FFFFFF')
                .borderRadius(24)
                .fontSize(16)
                .fontWeight(500)
                .textAlign(TextAlign.Center)
                .onClick(() => {
                  console.error("执行跳转-=0")
                  this.pageInfos.pushPath({ name: "NavDestinationTitle" + item })

                  // this.pageInfos.pushPathByName("NavDestinationTitle" + item,'')

                  // this.pageInfos.pushPathByName("NavDestinationTitle" + item,'',(popInfo)=>{
                  //   console.error('执行pushPathByName-然后出栈: ' + popInfo.info.name + ', result: ' + JSON.stringify(popInfo.result))
                  // })

                  // this.pageInfos.pushDestinationByName("NavDestinationTitle" + item, '')
                  //   .catch((error: BusinessError) => {
                  //     console.error(`执行跳转出错： error code = ${error.code}, error.message = ${error.message}.`);
                  //   }).then(() => {
                  //   console.error('执行跳转成功.');
                  // });

                })
            }
          }, (item: string): string => item)
        }
        .width("90%")
        .margin({ top: 12 })
      }
      .title("主标题")
      .titleMode(NavigationTitleMode.Full)
      // .titleMode(NavigationTitleMode.Mini)
      .mode(NavigationMode.Split)
      // .mode(NavigationMode.Stack)
      // .mode(NavigationMode.Auto)
      .navDestination(this.PageMap)
      .menus([
        {
          value: "", icon: "resources/base/media/shs_brower_check.webp", action: () => {
            console.error("执行替换栈顶页面")
          // this.pageInfos.replacePath({name:'NavDestinationTitle1',param:''})
          this.pageInfos.replacePathByName('NavDestinationTitle1','我是参数')
        }
        },
        {
          value: "", icon: "./image/shs_friend_check.png", action: () => {
          // console.error("执行-删除栈中name为NavDestinationTitle1的所有页面")
          //   this.pageInfos.removeByName('NavDestinationTitle1')
            console.error("执行-删除指定索引的页面")
            this.pageInfos.removeByIndexes([1,2])
        }
        },
        {
          value: "", icon: "./image/shs_me_check.png", action: () => {
          // 获取栈中所有页面name集合
          this.pageInfos.getAllPathName()
          // 获取索引为1的页面参数
          this.pageInfos.getParamByIndex(1)
          // 获取PageOne页面的参数
          this.pageInfos.getParamByName("NavDestinationTitle1")
          // 获取PageOne页面的索引集合
          this.pageInfos.getIndexByName("NavDestinationTitle1")
        }
        },
        {
          value: "", icon: "./image/shs_history_check.png", action: () => {
        }
        },
        {
          value: "", icon: "./image/shs_brower_check.webp", action: () => {
        }
        },
        {
          value: "", icon: "./image/shs_brower_check.webp", action: () => {
        }
        }
      ])
      .toolbarConfiguration([this.TooTmp1, this.TooTmp2, this.TooTmp3])
    }
    .height('100%')
    .width('100%')
    .backgroundColor('#F1F3F5')
  }
}

// PageOne.ets
@Component
export struct pageOneTmp {
  @Consume('pageInfos') pageInfos: NavPathStack;

  build() {
    NavDestination() {
      Column() {
        Text("NavDestinationContent1")
      }.width('100%').height('100%')
    }.title("NavDestinationTitle1")
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop() // 弹出路由栈栈顶元素
      console.error('执行pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true
    })
  }
}

// PageTwo.ets
@Component
export struct pageTwoTmp {
  @Consume('pageInfos') pageInfos: NavPathStack;

  build() {
    NavDestination() {
      Column() {
        Text("NavDestinationContent2")
      }.width('100%').height('100%')
    }.title("NavDestinationTitle2")
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop() // 弹出路由栈栈顶元素
      console.error('执行pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true
    })
  }
}

// PageThree.ets
@Component
export struct pageThreeTmp {
  @Consume('pageInfos') pageInfos: NavPathStack;

  build() {
    NavDestination() {
      Column() {
        Text("NavDestinationContent3")
      }.width('100%').height('100%')
    }.title("NavDestinationTitle3")
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop() // 弹出路由栈栈顶元素
      console.error('执行pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true
    })
  }
}

// PageThree.ets
@Component
export struct pageFourTmp {
  @Consume('pageInfos') pageInfos: NavPathStack;

  build() {
    NavDestination() {
      Stack() {
        Column() {
          Text("Dialog NavDestination")
            .fontSize(20)
            .margin({ bottom: 100 })
          Button("Close").onClick(() => {
            this.pageInfos.pop()
          }).width('30%')
        }
        .width('50%')
        .height('50%')
        .backgroundColor(Color.White)
        .borderRadius(10)
      }
      .width('100%')
      .height('100%')
    }
    .backgroundColor('rgba(0,0,0,0.5)')
    .hideTitleBar(true)
    .mode(NavDestinationMode.DIALOG)
  }
}