/**
 * 首页Tab
 */
import { MyNavigationBar } from '../MyNavigationBar'

@Component
export struct HomeTab {
  title: string = "首页"

  build() {
    Stack({alignContent:Alignment.TopStart}) {

      MyNavigationBar({
        title: this.title,
        isBack: false,
        isClose: false,
        isMenu: false,
        isSearch: false,
        isMore: true
      })

      Text(this.title)
        .width('100%')
        .height('100%')
        .fontColor($r('app.color.black'))
        .textAlign(TextAlign.Center)

    }.width('100%')
    .height('100%')
  }
}