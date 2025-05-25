import { router } from '@kit.ArkUI';

@Entry
@Component
struct Test1 {
  @State message: string = 'Hello World';

  build() {
    RelativeContainer() {
      Button('返回')
        .width('100')
        .onClick(() => {
          router.pushUrl({
            url: "Create/page/Create",
          })
        })
    }
    .height('100%')
    .width('100%')
  }
}