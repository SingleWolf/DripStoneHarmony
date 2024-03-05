import { HomeChannel } from './viewmodel/HomeChannel';

@Component
export struct HomeTabContent {
  private item: HomeChannel;

  build() {
    Column() {
      Text(this.item.name)
        .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
  }
}