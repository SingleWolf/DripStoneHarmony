/**
 * 该组件为底部标签栏，主界面使用。
 * 导航栏固定高度78vp，宽度为100%
 */

/**
 * 底部标签页每个项数据
 * 这段数据是固定不变的，无需暴露model接口，就放在该文件中
 * @param imgSrcNormal 按钮图片   未选中的图标
 * @param imgSrcPress 按下后图片  选中的图标
 * @param tabText 按钮文字
 */
class TabItem{
  imgSrcNormal: Resource
  imgSrcPress: Resource
  tabText: Resource | string
  constructor(imgSrcNormal: Resource, imgSrcPress: Resource , tabText: Resource | string) {
    this.imgSrcNormal = imgSrcNormal
    this.imgSrcPress = imgSrcPress
    this.tabText = tabText
  }
}


/**
 * 用于初始化TabItem的数组
 */
function getTabItems(): Array<TabItem> {
  let itemsArray: Array<TabItem> = []
  itemsArray.push(new TabItem($r("app.media.tab_home_normal") , $r("app.media.tab_home_press") ,"首页"))
  itemsArray.push(new TabItem($r("app.media.tab_demo_normal") , $r("app.media.tab_demo_press"),"演练"))
  itemsArray.push(new TabItem($r("app.media.tab_collect_normal") , $r("app.media.tab_collect_press"),"精选"))
  itemsArray.push(new TabItem($r("app.media.tab_mine_normal") ,  $r("app.media.tab_mine_press"), "我的"))
  return itemsArray;
}


@Component
export struct MyBottomTabs {
  private tabSrc: number[] = [0, 1, 2 ,3]
  private controller: TabsController = new TabsController() // Main.ets传递过来的控制器
  @Link bottomTabIndex: number // Main.ets传递过来的下标值

  private tabItemArray: Array<TabItem> =  getTabItems()

  build() {
    Flex({ direction: FlexDirection.Row, alignItems: ItemAlign.Center, justifyContent: FlexAlign.SpaceEvenly }) {
      ForEach(this.tabSrc, item => { // For循环四次
        Column() {
          Image((this.bottomTabIndex == item) ? this.tabItemArray[item].imgSrcPress : this.tabItemArray[item].imgSrcNormal)
            .objectFit(ImageFit.Contain)
            .width(30).height(30)
          Text(this.tabItemArray[item].tabText)
            .fontWeight((this.bottomTabIndex == item) ? FontWeight.Bold : FontWeight.Normal) // 文字选中是加粗
            .fontSize((this.bottomTabIndex == item) ? 16 : 14) // 选中文字变大
            .margin({ top: 3 })
            .fontColor((this.bottomTabIndex == item) ? $r("app.color.green0") : Color.Gray) // 选中为 微信绿色文字
        }
        .onClick(() => {
          this.controller.changeIndex(item)
        })
      }, item => {return item.toString() })
    }
    .width('100%').height(84)
    .backgroundColor($r('app.color.grey0')) // 微信的灰色
  }
}