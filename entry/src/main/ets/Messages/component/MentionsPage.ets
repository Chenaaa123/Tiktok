import { Mention } from '../view/interfaces';

@Component
export default struct MentionsPage {
  @State mentions: Mention[] = [
    // 示例数据已移除，空状态
  ];

  build() {
    if (this.mentions.length === 0) {
      // 空状态
      Column() {
        Blank().layoutWeight(1)
        Column() {
          Text('@')
            .fontSize(80)
            .fontColor('#fff')
            .margin({ bottom: 16 })
          Text('暂无@提及')
            .fontSize(24)
            .fontColor('#fff')
            .fontWeight(FontWeight.Bold)
            .margin({ bottom: 12 })
          Text('当有人@你时，会显示在这里')
            .fontSize(16)
            .fontColor('#B2B2B2')
        }
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Center)
        Blank().layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Center)
      .backgroundColor('#000000')
    } else {
      // 非空状态
      Column() {
        Text('@提及')
          .fontSize(20)
          .fontColor('#fff')
          .fontWeight(FontWeight.Bold)
          .margin({ left: 16, top: 16, bottom: 16 })
        Scroll() {
          Column() {
            ForEach(this.mentions, (item: Mention) => {
              Row() {
                Image($r("app.media.profilePicture"))
                  .width(48)
                  .height(48)
                  .borderRadius(24)
                  .margin({ left: 12, right: 12 })
                Column() {
                  Text(item.user)
                    .fontSize(16)
                    .fontColor('#FFFFFF')
                  Text(item.content)
                    .fontSize(14)
                    .fontColor('#B2B2B2')
                    .margin({ top: 4 })
                }
                .layoutWeight(1)
                Text(item.time)
                  .fontSize(12)
                  .fontColor('#999999')
              }
              .width('100%')
              .height(72)
              .border({ width: 0.5, color: '#333333' })
              .padding({ top: 8, bottom: 8 })
              .backgroundColor('#000000')
            })
          }
        }
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#000000')
    }
  }
}