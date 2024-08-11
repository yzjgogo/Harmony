
/**
 https://developer.huawei.com/consumer/cn/training/course/slightMooc/C101717496870909384
 循环渲染 -> 使用场景 -> 数据源数组项发生变化

 这里的 数据源数组项发生变化，是相对于A4_ForEach_2.ets来说的


 1：当列表滚动到底部时，如果手势向上滑动距离超过指定的80，将触发loadMoreArticle()函数。此函数会在articleList数据源的尾部添加一个新的数据项，从而增加数据源的长度。
 2：数据源被articleList被@State装饰器修饰，ArkUI框架能够感知到数据源长度的变化，并触发ForEach进行重新渲染。
 */

class Article {
  id: string;
  title: string;
  brief: string;

  constructor(id: string, title: string, brief: string) {
    this.id = id;
    this.title = title;
    this.brief = brief;
  }
}

@Entry
@Component
struct A4_ForEach_3 {
  @State isListReachEnd: boolean = false;
  @State articleList: Array<Article> = [
    new Article('001', '第1篇文章', '文章简介内容'),
    new Article('002', '第2篇文章', '文章简介内容'),
    new Article('003', '第3篇文章', '文章简介内容'),
    new Article('004', '第4篇文章', '文章简介内容'),
    new Article('005', '第5篇文章', '文章简介内容'),
    new Article('006', '第6篇文章', '文章简介内容')
  ]

  //让数据源articleList的数组项发生变化
  loadMoreArticles() {
    this.articleList.push(new Article('007', '加载的新文章', '文章简介内容'));
  }

  build() {
    Column({ space: 5 }) {
      //https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-container-list-V5
      List() {
        ForEach(this.articleList, (item: Article) => {
          //ListItem组件要求ForEach的父容器组件必须为List组件
          ListItem() {
            ArticleCard({ article: item })
              .margin({ top: 20 })
          }
        }, (item: Article) => item.id)
      }
      //当List滚动到底触发回调
      .onReachEnd(() => {
        this.isListReachEnd = true;
      })
      .parallelGesture(//手势处理
        PanGesture({ direction: PanDirection.Up, distance: 1 })
          .onActionStart((event) => {
            console.error("执行-onActionStart")
            if (this.isListReachEnd) {
              this.loadMoreArticles();
              this.isListReachEnd = false;
            }
          })
          .onActionUpdate((event)=>{
            console.error("执行-onActionUpdate")
          })
          .onActionEnd((event)=>{
            console.error("执行-onActionEnd")
          })
          .onActionCancel(()=>{
            console.error("执行-onActionCancel")
          })
      )
      .padding(20)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(0xF1F3F5)
  }
}

@Component
struct ArticleCard {
  //用@Prop定义子组件的变量不需要初始化
  @Prop article: Article;
  //用@State定义子组件的变量需要初始化
  // @State article: Article =new Article('009', '第1篇文章9', '文章简介内容9');

  build() {
    Row() {
      Image($r('app.media.startIcon'))
        .width(80)
        .height(80)
        .margin({ right: 20 })

      Column() {
        Text(this.article.title)
          .fontSize(20)
          .margin({ bottom: 8 })
        Text(this.article.brief)
          .fontSize(16)
          .fontColor(Color.Gray)
          .margin({ bottom: 8 })
      }
      .alignItems(HorizontalAlign.Start)
      .width('80%')
      .height('100%')
    }
    .padding(20)
    .borderRadius(12)
    .backgroundColor('#FFECECEC')
    .height(120)
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
  }
}