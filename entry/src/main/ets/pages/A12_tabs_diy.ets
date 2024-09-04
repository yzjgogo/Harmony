/**
 https://developer.huawei.com/consumer/cn/training/course/slightMooc/C101717497640610394
 自定义tabbar
 知识点：
 通过修改currentIndex触发Tabs的index的改变
 TabsController的用法，这里是改变Tabs的当前index
 onContentWillChange
 */

@Entry
@Component
struct A12_tabs_diy {
  @State currentIndex: number = 2
  private controller: TabsController = new TabsController()

  @Builder
  tabBuilder(title: string, targetIndex: number, selectedImg: Resource, normalImg: Resource) {
    Column() {
      Image(this.currentIndex === targetIndex ? selectedImg : normalImg)
        .size({ width: 25, height: 25 })
      Text(title)
        .fontColor(this.currentIndex === targetIndex ? '#1698CE' : '#6B6B6B')
    }
    .width('100%')
    .height(50)
    .justifyContent(FlexAlign.Center)
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Tabs({ barPosition: BarPosition.End, index: this.currentIndex, controller: this.controller }) {
        TabContent() {
          Text('首页的内容').fontSize(30)
        }
        .tabBar(this.tabBuilder('首页', 0, $r('app.media.shs_brower_check'), $r('app.media.shs_brower_uncheck')))

        TabContent() {
          Text('推荐的内容').fontSize(30)
        }
        .tabBar(this.tabBuilder('推荐', 1, $r('app.media.shs_friend_check'), $r('app.media.shs_friend_uncheck')))

        TabContent() {
          Text('发现的内容').fontSize(30)
        }
        .tabBar(this.tabBuilder('发现', 2, $r('app.media.shs_history_check'), $r('app.media.shs_history_uncheck')))

        TabContent() {
          Text('我的的内容').fontSize(30)
        }
        .tabBar(this.tabBuilder('我的', 3, $r('app.media.shs_me_check'), $r('app.media.shs_me_uncheck')))
      }
      .onChange((index: number) => {
        console.error("执行onChange:" + index)
        this.currentIndex = index
      })
      .onContentWillChange((currentIndex, comingIndex) => {
        //开发者可以通过Tabs组件的onContentWillChange接口，设置自定义拦截回调函数。拦截回调函数在下一个页面即将展示时被调用，如果回调返回true，新页面可以展示；如果回调返回false，新页面不会展示，仍显示原来页面。
        // if (comingIndex == 2) {
        //   return false
        // }
        return true
      })

      Column() {
        Button('修改currentIndex触发tabbar的改变-似乎没有TabContent切换的动画')
          .margin(10)
          .onClick(() => {
            this.currentIndex = (this.currentIndex + 1) % 4
          })

        Button('通过TabsController修改tabbar-跟点击tab一样，有TabContent切换的动画')
          .margin(10)
          .onClick(() => {
            let index = (this.currentIndex + 1) % 4
            this.controller.changeIndex(index)
          })
      }

    }

  }
}