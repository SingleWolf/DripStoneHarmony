import { HomeItem } from './viewmodel/HomeItem'

@Component
export struct HomeTabContentListItem {
  private item: HomeItem = new HomeItem("s_default", "title_default")

  build() {
    Column() { // 显示标题
      Text(this.item.title)
        .fontSize("16fp")
        .fontColor(Color.Orange)
        .padding({
          left: '15vp',
          right: '15vp'
        })
        .height('100%')
        .width('100%')

      // Divider() // 画一条线
      //   .strokeWidth(1)
      //   .color(Color.Gray)
      //   .margin({
      //     left: "40vp",
      //     right: "40vp"
      //   })
    }
    .width('100%')
    .height('12.3%')
    .backgroundColor(Color.White)
    .borderRadius('10vp')
  }
}