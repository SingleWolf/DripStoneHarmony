import { MyBottomTabs } from '../common/components/MyBottomTabs'
import { MyNavigationBar } from '../common/components/MyNavigationBar'
import { CollectTab } from '../common/components/tabcontent/CollectTab'
import { DemoTab } from '../common/components/tabcontent/DemoTab'
import { HomeTab } from '../common/components/tabcontent/HomeTab'
import { MineTab } from '../common/components/tabcontent/MineTab'

@Entry
@Component
struct Main {
  private controller: TabsController = new TabsController()
  @State bottomTabIndex: number = 0

  build() {
    Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.End, justifyContent: FlexAlign.End }) {

      /**
       * 中间的标签页组件
       * 分别为 最近会话/联系人/设置
       */
      Tabs({ barPosition: BarPosition.End, index: 0, controller: this.controller }) {
        TabContent() {
          HomeTab() // 首页
        }

        TabContent() {
          DemoTab() // 演练
        }

        TabContent() {
          CollectTab() // 精选
        }

        TabContent() {
          MineTab() // 我的
        }
      }
      .onChange((index: number) => {
        this.bottomTabIndex = index
      })
      .vertical(false)
      .barHeight(0)
      .width('100%')
      .scrollable(true) // true：左右滑动可以切换Tab，  false是固定不能滑动

      //底部tab标签页
      MyBottomTabs({ controller: this.controller, bottomTabIndex: $bottomTabIndex })
    }
    .backgroundColor($r('app.color.white'))
    .width('100%').height('100%')
  }
}