/**
 * 我的Tab
 */
@Component
export struct MineTab {
  title:string="我的"

  build() {
    Stack({alignContent:Alignment.TopStart}) {
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