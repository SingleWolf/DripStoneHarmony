import { MyNavigationBar } from '../../../../../common/components/MyNavigationBar';
import Logger from '../../../../../common/utils/Logger';
import libHello from 'libhello.so';

/**
 * ArkTs调用C/C++
 */
@Entry
@Component
struct Arl2CppPage {
  private title: string = "ark-c++";
  private myHypotLabel: string = "myHypotLabel"
  private addLabel: string = "addLabel"

  @State result: number = 0; // 最终C++ 返回的结果
  @State numX: number = 0.0; // 输入框1
  @State numY: number = 0.0; // 输入框2

  @State addResult: number = 0; // add最终C++ 返回的结果
  @State addNumX: number = 0.0; // add输入框1
  @State addNumY: number = 0.0; // add输入框2

  private textInputControllerX: TextInputController = new TextInputController();
  private textInputControllerY: TextInputController = new TextInputController();
  private addTextInputControllerX: TextInputController = new TextInputController();
  private addTextInputControllerY: TextInputController = new TextInputController();

  aboutToAppear() {
    this.myHypotLabel = libHello.getMyHypotLabel();
    this.addLabel = libHello.getAddLabel();
  }

  build() {
    Column() {
      MyNavigationBar({
        title: this.title,
        isBack: true,
        isClose: false,
        isMenu: false,
        isSearch: false,
        isMore: false
      }).align(Alignment.Top)

      //myHypot
      Row() {
        Text(`${this.myHypotLabel}`)
          .fontSize('20fp')
          .fontWeight(500)
          .height('21vp')
          .align(Alignment.Center)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
      }
      .height('45vp')
      .width('100%')
      .padding({ left: '24vp', top: '24vp' })

      Column() {
        Row() {
          Text(`C/C++计算后结果 : ${this.result}`)
            .height('19vp')
            .fontColor(Color.Green)
            .fontSize('18fp')
        }
        .height('50vp')
        .width('100%')

        Row() {
          Text('输入X数值')
          TextInput({ controller: this.textInputControllerX })
            .type(InputType.Number)
            .height('100%')
            .width('80%')
            .onChange(value => {
              this.numX = Number.parseFloat(value);
            })
        }
        .height("40vp")
        .width('100%')

        Row() {
          Text('输入Y数值')
          TextInput({ controller: this.textInputControllerY })
            .type(InputType.Number)
            .height('100%')
            .width('80%')
            .onChange(value => {
              this.numY = Number.parseFloat(value);
            })
        }
        .height("40vp")
        .width('100%')
        .margin({ top: 10 })

        Row() {
          Button('计算结果', { type: ButtonType.Normal, stateEffect: true })
            .height("40vp")
            .width('100%')
            .align(Alignment.Center)
            .onClick(() => {
              // 直接调用so的方法  只是表面上 暴露了 中间件而已 ---> so库
              try {
                this.result = libHello.myHypot(this.numX, this.numY);
              } catch (err) {
                Logger.error(`libHello.myHypot , error = ${err}`)
              }
            })
        }
        .margin({ top: 15 })
      }
      .margin(15)
      .padding(15)
      .borderRadius(24)
      .height(230)
      .backgroundColor(Color.Yellow)


      //add
      Row() {
        Text(`${this.addLabel}`)
          .fontSize('20fp')
          .fontWeight(500)
          .height('21vp')
          .align(Alignment.Center)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
      }
      .height('45vp')
      .width('100%')
      .padding({ left: '24vp', top: '24vp' })
      .margin({top:'50vp'})

      Column() {
        Row() {
          Text(`C/C++计算后结果 : ${this.addResult}`)
            .height('19vp')
            .fontColor(Color.Green)
            .fontSize('18fp')
        }
        .height('50vp')
        .width('100%')

        Row() {
          Text('输入X数值')
          TextInput({ controller: this.addTextInputControllerX })
            .type(InputType.Number)
            .height('100%')
            .width('80%')
            .onChange(value => {
              this.numX = Number.parseFloat(value);
            })
        }
        .height("40vp")
        .width('100%')

        Row() {
          Text('输入Y数值')
          TextInput({ controller: this.addTextInputControllerY })
            .type(InputType.Number)
            .height('100%')
            .width('80%')
            .onChange(value => {
              this.numY = Number.parseFloat(value);
            })
        }
        .height("40vp")
        .width('100%')
        .margin({ top: 10 })

        Row() {
          Button('计算结果', { type: ButtonType.Normal, stateEffect: true })
            .height("40vp")
            .width('100%')
            .align(Alignment.Center)
            .onClick(() => {
              // 直接调用so的方法  只是表面上 暴露了 中间件而已 ---> so库
              try {
                this.addResult = libHello.add(this.numX, this.numY);
              } catch (err) {
                Logger.error(`libHello.add , error = ${err}`)
              }
            })
        }
        .margin({ top: 15 })
      }
      .margin(15)
      .padding(15)
      .borderRadius(24)
      .height(230)
      .backgroundColor(Color.Yellow)
    }
    .width('100%')
    .height("100%")
  }
}