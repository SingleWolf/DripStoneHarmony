import promptAction from '@ohos.promptAction';
import router from '@ohos.router';
import { GlobalContext } from '../../common/utils/GlobalContext';
import Logger from '../../common/utils/Logger';
import { HomeTabContentListItem } from './HomeTabContentListItem';
import { HomeChannel } from './viewmodel/HomeChannel';
import { HomeItem } from './viewmodel/HomeItem';
import MockData from './viewmodel/MockData';

@Component
export struct HomeTabContent {
  private channel: HomeChannel;
  private dataList: Array<HomeItem> = [];

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
              transactItemClick(item)
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

function transactItemClick(item: HomeItem) {
  try {

    switch (item.sid) {
      case "H01_S01": {
        router.pushUrl({ url: 'mode/home/group/study/native/Ark2CppPage', params: { title: item.title } })
        break;
      }
      default: {
        promptAction.showToast({
          message: "click:" + item.title,
          duration: 2000,
        });
        break;
      }
    }

  } catch (error) {
    Logger.error(`transactItemClick error code is ${error.code}, message is ${error.message}`)
  }
}
