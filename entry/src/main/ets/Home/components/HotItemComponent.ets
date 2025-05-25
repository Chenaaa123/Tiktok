import { HotItem } from '../model/DataModel';

@Component
export struct HotItemComponent {
  @Prop data: HotItem;

  @Builder
  PlayCount(count: number) {
    Text(count > 10000 ? 
      `${(count / 10000).toFixed(1)}万` : 
      count.toString())
      .fontSize(12)
      .fontColor('#FFFFFF')
      .backgroundColor('rgba(0,0,0,0.5)')
      .padding(4)
      .borderRadius(12)
  }

  build() {
    Column() {
      // 封面图
      Stack() {
        Image(this.data.cover)
          .width('100%')
          .height(160)
          .borderRadius(8)
          .objectFit(ImageFit.Cover)
        
        // 播放量
        this.PlayCount(this.data.playCount)
      }
      .position({ x: 8, y: 8 })

      // 标题
      Text(this.data.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .margin({ top: 8 })
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
    }
    .width('100%')
  }
} 