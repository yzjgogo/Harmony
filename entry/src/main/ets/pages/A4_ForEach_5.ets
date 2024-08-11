@Entry
@Component
struct A4_ForEach_5 {
  @State arr: Array<string> = [];

  build() {
    Row() {
      List() {
        ForEach(this.arr, (item: string) => {
          ListItem() {
            Text(item.toString())
              .fontSize(16)
              .textAlign(TextAlign.Center)
              .size({height: 100, width: "100%"})
          }.margin(10)
          .borderRadius(10)
          .backgroundColor("#FFFFFFFF")
        }, (item: string) => item)
          .onMove((from:number, to:number) => {
            //onMove会在元素被拖拽到to后，且松开手后触发
            //from:被拖动的item原来来自哪个index
            //to:被拖动的item，现在被拖动到了哪个index
            //如果onMove方法里不做任何操作，其实界面上已经能看到拖拽成功的效果，只是原始数据arr并没有变化。
            //因此我们需要把原始数据按照UI上被拖拽的结果重新排列，保证被拖拽后UI上展示的数据顺序与arr的数据顺序一致
            //需要注意，在onMove对原始数据修改时，要保证修改前后每一个item的键值跟原来一样，此时就一样，都是item的值
            // console.error("执行onMove:"+from+" , "+to)
            let tmp = this.arr.splice(from, 1);//1：把被拖拽的元素从原始数据的原来的index移除
            this.arr.splice(to, 0, tmp[0])//2：把被拖拽的元素插入到拖拽目标index处
          })
      }
      // .width('100%')
      .layoutWeight(1)
      .height('100%')
      .backgroundColor("#FFDCDCDC")
      Column(){
        Button("看看")
          .onClick(()=>{
            // console.error("执行看看数据："+JSON.stringify(this.arr))
            this.arr.push('1000')
          })
      }.width(100)
    }
  }
  aboutToAppear(): void {
    for (let i = 0; i < 100; i++) {
      this.arr.push(i.toString())
    }
  }
}