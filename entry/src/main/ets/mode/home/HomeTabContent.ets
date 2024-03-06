import promptAction from '@ohos.promptAction';
import { GlobalContext } from '../../common/utils/GlobalContext';
import { HomeTabContentListItem } from './HomeTabContentListItem';
import { HomeChannel } from './viewmodel/HomeChannel';
import { HomeItem } from './viewmodel/HomeItem';
import MockData from './viewmodel/MockData';

@Component
export struct HomeTabContent {
  private channel: HomeChannel;
  private dataList: Array<HomeItem> = []

  async aboutToAppear() {
    this.dataList = await MockData.listHomeItem(this.channel.id)
  }

  build() {
    Column() {
      if (this.dataList.length > 0) {
        List({
          space: 10,
          initialIndex: 0
        }) {
          ForEach(this.dataList, (item: HomeItem, index?: number) => {
            ListItem() {
              HomeTabContentListItem({ item: item })
            }.onClick(() => {
              try {
                promptAction.showToast({
                  message: "click:" + item.title,
                  duration: 2000,
                });
              } catch (error) {
                console.error(`showToast args error code is ${error.code}, message is ${error.message}`);
              }
              ;
            })
          }, (item: HomeItem) => JSON.stringify(item))
        }.margin({ top: 5 })
      } else {
        Text(this.channel.name)
          .textAlign(TextAlign.Center)
          .width('100%')
          .height('100%')
      }
    }
    .width('100%')
    .height('100%')
  }
}