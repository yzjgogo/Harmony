/**

 1：开启手机的无线调试：
 https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/ide-run-device-V5#section9315596477
参考图片：无线调试.jpg

 2：不会用hdc命令，可以参考这里：
 https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V2/ide-command-line-hdc-0000001237908229-V2
 参考图片：hdc用法.jpg


 具体使用：
 进入：F:\Program Files\Huawei\DevEco Studio\sdk\HarmonyOS-NEXT-DB6\openharmony\toolchains
        或者 F:\Program Files\Huawei\DevEco Studio\sdk\default\openharmony\toolchains
 在地址栏：cmd
  执行：hdc tconn 192.168.6.46:33835
 */
@Entry
@Component
struct L0_wlan_debug {

  build() {
    Column() {
      Text('无线调试')
    }
  }
}