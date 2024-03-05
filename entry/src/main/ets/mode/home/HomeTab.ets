/**
 * 首页Tab
 */
import { MyNavigationBar } from '../../common/components/MyNavigationBar'
import { HomeTabContent } from './HomeTabContent';
import { HomeChannel } from './viewmodel/HomeChannel';
import MockData from './viewmodel/MockData';

@Component
export struct HomeTab {
  title: string = "首页"
  @State currentIndex: number = 0;
  private controller: TabsController = new TabsController();
  private channelIndex:Array<number>=MockData.listHomeChannelIndex();
  private channelList:HomeChannel[]=MockData.listHomeChanel();

  // 顶部的Tab选项的细节部分
  @Builder
  TabBuilder(index: number, name: Resource | string) {
    Column() {
      Text(name)
        .fontColor(this.currentIndex === index ? Color.White : Color.Gray)
        .fontSize(this.currentIndex === index ? '18fp' : '14fp')
        .fontWeight(this.currentIndex === index ? 600 : 400)
        .lineHeight(22)
        .margin({
          top: 13,
          bottom: 12
        })

      Divider()
        .strokeWidth(3) // 一条线的粗细
        .opacity(this.currentIndex === index ? 1 : 0) // 1显示   0不显示 透明掉
        .color(Color.White)
    }
    .width('100%')
    .backgroundColor($r('app.color.theme'))
  }

  build() {
    Column() {
      MyNavigationBar({
        title: this.title,
        isBack: false,
        isClose: false,
        isMenu: false,
        isSearch: false,
        isMore: true
      })

      Tabs({ barPosition: BarPosition.Start, controller: this.controller }) {
        ForEach(this.channelIndex, pos => {
          TabContent() {
            HomeTabContent({ item: this.channelList[pos] });
          }.tabBar(this.TabBuilder(pos, this.channelList[pos].name))
        })
      }
      .vertical(false)
      .barMode(BarMode.Fixed)
      .barHeight(50)
      .onChange((index: number) => {
        this.currentIndex = index; // 0 or 1
      })
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.Pink) //背景颜色
  }
}