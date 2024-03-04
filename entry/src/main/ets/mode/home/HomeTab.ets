/**
 * 首页Tab
 */
import { MyNavigationBar } from '../../common/components/MyNavigationBar'
import { HomeTabContent } from './HomeTabContent';

@Component
export struct HomeTab {
  title: string = "首页"
  @State currentIndex: number = 0;
  private controller: TabsController = new TabsController();
  private channelList: Array<string> = Array.of('学习', 'UI', '优化', '算法', '数据', '排雷', '推荐', '工具');
  private channelIndex: number[] = [0, 1, 2, 3, 4, 5, 6, 7];

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
            HomeTabContent({ currIndex: pos });
          }.tabBar(this.TabBuilder(pos, this.channelList[pos]))
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