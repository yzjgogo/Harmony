/**
 https://developer.huawei.com/consumer/cn/training/course/slightMooc/C101717496870909384
 循环渲染 -> 使用场景 -> 数据源数组项子属性变化（articleArr是对象类型的数组，当articleArr的item的某个属性发生变化时，默认情况下ArkUI框架无法监听到@State装饰器修饰的数据源数组项的属性变化，从而无法触发ForEach的重新渲染。为实现ForEach重新渲染，需要结合@Observed和@ObjectLink装饰器使用。例如，在文章列表卡片上点击“点赞”按钮，从而修改文章的点赞数量。）

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