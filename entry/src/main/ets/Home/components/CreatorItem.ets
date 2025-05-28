import { Creator } from '../model/DataModel';

@Component
export struct CreatorItem {
  @Prop data: Creator;

  build() {
    Row() {
      // 头像
      Stack() {
        Image(this.data.avatar)
          .width(48)
          .height(48)
          .borderRadius(24)
        // 创作者信息
        Column() {
          Text(this.data.name)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 4 })

          Text(this.data.latestVideo)
            .fontSize(14)
            .fontColor('#666666')
        }
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .height(72)
      .padding(12)
    }
  }
}