/**
 * 该组件为导航栏，除了特定页面如闪屏页面，都应该有导航栏。
 * 导航栏固定高度60vp，宽度为100%
 */
import router from '@ohos.router';

@Component
export struct MyNavigationBar {
  @State title: string = '';
  @State isTitleLeft: Boolean = true;
  @State isBack: boolean = true;
  @State isMenu: boolean = true;
  @State isSearch: boolean = true;
  @State isMore: boolean = false;
  @State isClose: boolean = false;
  @State bgColor: Resource = $r('app.color.theme');
  @State txColor: Resource = $r('app.color.white')

  build() {
    Row() {
      /**
       * 左侧的 后退/关闭 按钮
       * isBack和isClose变量为互斥关系，不能共存
       */
      if (this.isBack == true) {
        Column() {
          Image($r('app.media.ic_back')) // 返回箭头图标
            .width(26)
            .height(26)
            .onClick(() => {
              router.back()
            })
        }.width(50)
      } else if (this.isClose == true) {
        Column() {
          Image($r('app.media.ic_close')) // X图标
            .width(26)
            .height(26)
            .onClick(() => {
              router.back()
            })
        }.width(50)
      } else if (this.isTitleLeft == false) {
        Column() {
        }.width(50)
      }
      /**
       * 中间标题栏
       */
      Row() {
        Text(this.title)
          .fontSize(22)
          .maxLines(1)
          .fontColor(this.txColor)
          .textAlign(this.isTitleLeft ? TextAlign.Start : TextAlign.Center)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
      }.layoutWeight(1).padding({ left: 15 })

      /**
       * 右侧搜索按钮
       */
      Column() {
        if (this.isSearch == true) {
          Image($r('app.media.ic_search'))
            .width(26)
            .height(26)
        }
      }.width(30)

      /**
       * 右侧菜单按钮
       * isMenu和isMore变量为互斥关系，不能共存
       */
      Column() {
        if (this.isMenu == true) {
          Image($r('app.media.ic_add'))
            .width(26)
            .height(26)
        }
        if (this.isMore == true) {
          Image($r('app.media.ic_more_white'))
            .width(26)
            .height(26)
        }
      }.width(50)
    }
    .height(60)
    .width('100%')
    .backgroundColor(this.bgColor)
  }
}