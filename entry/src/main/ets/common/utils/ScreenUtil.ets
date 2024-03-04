import Window from '@ohos.window';
import { GlobalContext } from './GlobalContext';
import Logger from './Logger';

// 屏幕工具类
class ScreenUtil {
  setScreenSize(): void {
    Window.getLastWindow(getContext(this))
      .then((windowClass: Window.Window) => {
        let screenWidth = px2fp(windowClass.getWindowProperties().windowRect.width);
        let screenHeight = px2fp(windowClass.getWindowProperties().windowRect.height);
        GlobalContext.getContext().setObject('screenWidth', screenWidth);
        GlobalContext.getContext().setObject('screenHeight', screenHeight);
        GlobalContext.getContext().setObject('windowClass', windowClass);
      })
      .catch((error: Error) => {
        Logger.error('[ScreenUtil] 获取窗口大小失败。处理步骤导致: ' + JSON.stringify(error));
      })
  }
}

export default new ScreenUtil();
