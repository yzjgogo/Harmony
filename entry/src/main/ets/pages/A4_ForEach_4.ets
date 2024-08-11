/**
 https://developer.huawei.com/consumer/cn/training/course/slightMooc/C101717496870909384
 循环渲染 -> 使用场景 -> 数据源数组项子属性变化（articleArr是对象类型的数组，当articleArr的item的某个属性发生变化时，默认情况下ArkUI框架无法监听到@State装饰器修饰的数据源数组项的属性变化，从而无法触发ForEach的重新渲染。为实现ForEach重新渲染，需要结合@Observed和@ObjectLink装饰器使用。例如，在文章列表卡片上点击“点赞”按钮，从而修改文章的点赞数量。）

 本例中，ArticleOBJ类被@Observed装饰器修饰。父组件ArticleListView传入ArticleOBJ对象实例给子组件ArticleCardObj，子组件使用@ObjectLink装饰器接收该实例。

 1，当点击第1个文章卡片上的点赞图标时，会触发ArticleCardObj组件的handleLiked函数。该函数修改第1个卡片对应组件里article实例的isLiked和likesCount属性值。
 2，由于子组件ArticleCardObj中的article使用了@ObjectLink装饰器，父子组件共享同一份article数据。因此，父组件中articleArr的第1个数组项的isLiked和likedCounts数值也会同步修改。
 3，当父组件监听到数据源数组项属性值变化时，会触发ForEach重新渲染。,
 4，在此处，ForEach键值生成规则为数组项的id属性值。当ForEach遍历新数据源时，数组项的id均没有变化，不会新建组件。
 5，渲染第1个数组项对应的ArticleCardObj组件时，读取到的isLiked和likesCount为修改后的新值

 参考：B2_ObjectLink.ets
 */
@Observed
class ArticleOBJ {
  id: string;
  title: string;
  brief: string;
  isLiked: boolean;
  likesCount: number;

  constructor(id: string, title: string, brief: string, isLiked: boolean, likesCount: number) {
    this.id = id;
    this.title = title;
    this.brief = brief;
    this.isLiked = isLiked;
    this.likesCount = likesCount;
  }
}

@Entry
@Component
struct A4_ForEach_4 {
  @State articleArr: Array<ArticleOBJ> = [
    new ArticleOBJ('001', '第0篇文章', '文章简介内容', false, 100),
    new ArticleOBJ('002', '第1篇文章', '文章简介内容', false, 100),
    new ArticleOBJ('003', '第2篇文章', '文章简介内容', false, 100),
    new ArticleOBJ('004', '第4篇文章', '文章简介内容', false, 100),
    new ArticleOBJ('005', '第5篇文章', '文章简介内容', false, 100),
    new ArticleOBJ('006', '第6篇文章', '文章简介内容', false, 100),
  ];

  build() {
    List() {
      // ListItem(){
      //
      //   Button("大富大贵").onClick(()=>{
      //     this.articleArr[0].isLiked =true
      //     this.articleArr[0].likesCount =185
      //   })
      // }
      ForEach(this.articleArr, (item: ArticleOBJ) => {
        ListItem() {
          ArticleCardObj({
            article: item
          })
            .margin({ top: 20 })
        }
      }, (item: ArticleOBJ) => item.id)
    }
    .padding(20)
    .scrollBar(BarState.Off)
    .backgroundColor(0xF1F3F5)
  }
}

@Component
struct ArticleCardObj {
  @ObjectLink  article: ArticleOBJ;

  handleLiked() {
    this.article.isLiked = !this.article.isLiked;
    this.article.likesCount = this.article.isLiked ? this.article.likesCount + 1 : this.article.likesCount - 1;
  }

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

        Row() {
          Image(this.article.isLiked ? $r('app.media.iconLiked') : $r('app.media.iconUnLiked'))
            .width(24)
            .height(24)
            .margin({ right: 8 })
          Text(this.article.likesCount.toString())
            .fontSize(16)
        }
        .onClick(() => this.handleLiked())
        .justifyContent(FlexAlign.Center)
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