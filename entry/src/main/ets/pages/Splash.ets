import hilog from '@ohos.hilog';
import router from '@ohos.router';
import Logger from '../common/utils/Logger';
import ScreenUtil from '../common/utils/ScreenUtil';

@Entry
@Component
struct Splash {
  aboutToAppear() {
    Logger.info('[Splash] aboutToAppear()');
    ScreenUtil.setScreenSize() // 获取窗口大小的信息合集
    setTimeout(function () {
      hilog.info(0x0000, 'testTag', '%{public}s', 'goto main page after 1s delay');
      router.replaceUrl({ url: 'pages/Main' })
    }, 1000);
  }

  build() {
    Stack({ alignContent: Alignment.BottomStart }) {
      // 背景图片---页面布局采用堆叠布局，背景铺满整个页面
      Image($r('app.media.bg_splash'))
        .width('100%')
        .height('100%')
    }
  }
}