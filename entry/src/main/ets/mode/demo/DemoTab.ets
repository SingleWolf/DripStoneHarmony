/**
 * 演练Tab
 */
import { MyNavigationBar } from '../../common/components/MyNavigationBar'

@Component
export struct DemoTab {
  title: string = "演练"

  build() {
    Stack({alignContent:Alignment.TopStart}) {
      MyNavigationBar({
        title: this.title,
        isBack: false,
        isClose: false,
        isMenu: false,
        isSearch: false,
        isMore: true
      }).align(Alignment.Top)

      Text(this.title)
        .width('100%')
        .height('100%')
        .fontColor($r('app.color.black'))
        .textAlign(TextAlign.Center)
        .align(Alignment.Center)

    }.width('100%')
    .height('100%')
  }
}