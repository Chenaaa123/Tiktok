import { VideoItem } from '../model/DataModel';

@Component
export struct HotVideoCard {
  @Prop rank: number;
  @Prop data: VideoItem;

  build() {
    Stack() {
      // 视频封面
      Image(this.data.cover)
        .width('100%')
        .height('100%')
        .borderRadius(8)
        .objectFit(ImageFit.Cover)

      // 播放按钮
      Image($rawfile('Video/Video_Play.png'))
        .width(40)
        .height(40)
        .position({ x: '50%', y: '50%' })
        .translate({ x: -20, y: -20 })

      // 排名标签
      Text(`TOP ${this.rank}`)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FFFFFF')
        .backgroundColor('#FF2D55')
        .padding({ left: 8, right: 8, top: 4, bottom: 4 })
        .borderRadius({ topLeft: 8, bottomRight: 8 })
        .position({ x: 0, y: 0 })

      // 视频信息
      Column() {
        Text(this.data.title)
          .fontSize(16)
          .fontColor('#FFFFFF')
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Row() {
          Text(this.data.author)
            .fontSize(14)
            .fontColor('#CCCCCC')
          Text(`${(this.data.playCount / 10000).toFixed(1)}万次播放`)
            .fontSize(14)
            .fontColor('#CCCCCC')
            .margin({ left: 8 })
        }
      }
      .width('100%')
      .padding(12)
      .position({ x: 0, y: '100%' })
      .translate({ y: -100 })
      .backgroundImage($r('app.media.gradient_bg'))
      .backgroundImageSize(ImageSize.Cover)
    }
    .width('100%')
    .aspectRatio(0.8)
    .backgroundColor('#000000')
    .borderRadius(8)
  }
} 