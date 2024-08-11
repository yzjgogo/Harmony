
/**
 https://developer.huawei.com/consumer/cn/training/course/slightMooc/C101717496870909384
 看循环渲染部分

 1：演示首次渲染，当simpleList=['one', 'two', 'three'] 直接运行该page，就是首次渲染，
 在ForEach首次渲染时，会根据前述键值生成规则为数据源的每个数组项生成唯一键值`(item: string) => item`，并创建相应的组件`ChildItem({ item: item }`。

 2：演示键值相同：让simpleList=['one', 'two', 'two', 'three']，因为此时的键值生成规则是看，最终生成的键值就是item，就是'one', 'two', 'two', 'three',当打算渲染第二个'two'时，发现键值'two'已经存在
  因此不会重复创建组件，而是跳过第二个'two'时的组件的创建，因此组件创建的结果和['one', 'two', 'three']一样

 3：演示非首次渲染：点击"点击修改第3个数组项的值"
 在ForEach组件进行非首次渲染时，它会检查新生成的键值是否在上次渲染中已经存在。如果键值不存在，则会创建一个新的组件；如果键值存在，则不会创建新的组件，而是直接渲染该键值所对应的组件。
 例如，这里通过点击事件修改了数组的第三项值为"new three"，根据此时的键值生成规则，产生了新的键值"new three"，原来并不存在，因此会创建一个新的组件。ChildItem({ item: 'new three' }
 顺便提一下，因为根据键值生成规则，原来的兼职‘three’不存在了，则再次渲染时也不会渲染ChildItem({ item: 'three' }
 过程大概是这样：
 a:当 simpleList 数组项发生变化时，会触发 ForEach 进行重新渲染。
 b:ForEach 遍历新的数据源 ['one', 'two', 'new three']，并生成对应的键值one、two和new three。
 c:其中，键值one和two在上次渲染中已经存在，所以 ForEach 复用了对应的组件并进行了渲染。对于第三个数组项 "new three"，由于其通过键值生成规则 item 生成的键值new three在上次渲染中不存在，因此 ForEach 为该数组项创建了一个新的组件。

 注意：在生成键值时，尽量不要让index参与键值的生成
 参考：https://developer.huawei.com/consumer/cn/training/course/slightMooc/C101717496870909384
 循环渲染 -> 渲染结果非预期 和 渲染性能降低
 */
@Entry
@Component
struct A4_ForEach {
  //因为使用了@State修饰，当simpleList 数组项发生变化时，会触发 ForEach 进行重新渲染。
  @State simpleList: Array<string> = ['one', 'two', 'three'];
  // @State simpleList: Array<string> = ['one', 'two', 'two', 'three']; //演示键值相同

  build() {
    Row() {
      Column() {
        //点击时演示非首次渲染
        Text('点击修改第3个数组项的值')
          .fontSize(24)
          .fontColor(Color.Red)
          .onClick(() => {
            this.simpleList[2] = 'new three';
          })

        //Ctrl+鼠标左键 -> ForEachInterface -> 可见ForEach的参数(arr: Array<any>, itemGenerator: (item: any, index: number) => void, keyGenerator?: (item: any, index: number) => string)
        //arr：用于变量的数据源；
        //itemGenerator:是一个函数，会根据键值生成规则为arr的每个数组项创建组件(这里时ChildItem)
        //keyGenerator:是一个函数，用于生产键值，类似vue中v-for的key，开发者可以通过它自定义键值的生成规则。如果开发者没有定义keyGenerator函数，则ArkUI框架会使用默认的键值生成函数，即(item: Object, index: number) => { return index + '__' + JSON.stringify(item); }。
        //ArkUI框架对于ForEach的键值生成有一套特定的判断规则，这主要与itemGenerator函数的第二个参数index以及keyGenerator函数的第二个参数index有关，具体的键值生成规则判断逻辑参考：ForEach键值生成规则.png
        //以后开发过程中，想知道键值时怎么生产的，会不会存在重复等问题，就看一看：ForEach键值生成规则.png

        //注意：ArkUI框架会对重复的键值发出警告。在UI更新的场景下，如果出现重复的键值，框架可能无法正常工作，具体请参见渲染结果非预期。

        //在ForEach首次渲染时，会根据前述键值生成规则为数据源的每个数组项生成唯一键值`(item: string) => item`，并创建相应的组件`ChildItem({ item: item }`。
        ForEach(this.simpleList, (item: string) => {
          ChildItem({ item: item })
        }, (item: string) => item)
      }
      .width('100%')
      .height('100%')
    }
    .height('100%')
    .backgroundColor(0xF1F3F5)
  }
}

@Component
struct ChildItem {
  @Prop item: string;

  build() {
    Text(this.item)
      .fontSize(50)
  }
}