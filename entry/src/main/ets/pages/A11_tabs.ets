/**
 * https://developer.huawei.com/consumer/cn/training/course/slightMooc/C101717497640610394
 */

@Entry
@Component
struct A11_tabs {
  build() {
    // BarPosition.Start：顶部  BarPosition.End：底部  BarPosition.Start配合.vertical(true：侧边
    Tabs({barPosition:BarPosition.Start}){
      TabContent(){
        Text('首页的内容').fontSize(30)
      }
      .tabBar('首页')

      TabContent(){
        Text('推荐的内容').fontSize(30)
      }
      .tabBar('推荐')

      TabContent(){
        Text('发现的内容').fontSize(30)
      }
      .tabBar('发现')

      TabContent(){
        Text('我的的内容').fontSize(30)
      }
      .tabBar('我的')

      // TabContent(){
      //   Text('关注的内容').fontSize(30)
      // }
      // .tabBar('关注')
      //
      // TabContent(){
      //   Text('视频的内容').fontSize(30)
      // }
      // .tabBar('视频')
      //
      // TabContent(){
      //   Text('游戏的内容').fontSize(30)
      // }
      // .tabBar('游戏')
      //
      // TabContent(){
      //   Text('数码的内容').fontSize(30)
      // }
      // .tabBar('数码')
      //
      // TabContent(){
      //   Text('数码1的内容').fontSize(30)
      // }
      // .tabBar('数码1')
      //
      // TabContent(){
      //   Text('数码2的内容').fontSize(30)
      // }
      // .tabBar('数码2')
      //
      // TabContent(){
      //   Text('数码3的内容').fontSize(30)
      // }
      // .tabBar('数码3')
      //
      // TabContent(){
      //   Text('数码4的内容').fontSize(30)
      // }
      // .tabBar('数码4')
    }
    .vertical(false)//默认false为顶部或底部；true为侧边
    // .barWidth(100)//顶部或底部时：存放所有tab的容器的总宽度，默认屏幕的宽度；侧边时：存放所有tab的容器的宽度，也可以理解为单个tab的宽度
    // .barHeight(300)//顶部或底部时：存放所有tab的容器的高度，也可以理解为单个tab的高度；侧边时：存放所有tab的容器的总高度，默认是实际容器的高度
    // .scrollable(false)//控制是否可通过手势滑动TabContent区域切换tab，默认为true;
    // .barMode(BarMode.Scrollable)//控制当所有tab的总宽度超过父容器的宽度时，是否可以通过滚动tab查看所有tab，默认值为BarMode.Fixed，注意当tab个数较少时比如3-5个时，设置为Scrollable时是紧挨着居中，设置为Fixed时是分散开来。

  }
}