import router from '@ohos.router';
import { VideoItem } from '../model/DataModel';
import { VideoComponent } from '../components/VideoComponent';

interface VideoDetailParams {
  videoId: string;
}

@Entry
@Component
struct VideoDetail {
  @State videoData: VideoItem = {
    id: (router.getParams() as VideoDetailParams)?.videoId || '',
    title: '精彩视频',
    cover: 'Video/video.mp4',
    duration: 180,
    likes: 1000,
    comments: 100,
    playCount: 10000,
    author: '视频作者',
    category: '分类'
  };

  @State relatedVideos: VideoItem[] = [
    {
      id: 'rv1',
      title: '相关视频1',
      cover: 'Video/related1.mp4',
      duration: 120,
      likes: 500,
      comments: 50,
      playCount: 5000,
      author: '作者1',
      category: '分类1'
    },
    {
      id: 'rv2',
      title: '相关视频2',
      cover: 'Video/related2.mp4',
      duration: 180,
      likes: 800,
      comments: 80,
      playCount: 8000,
      author: '作者2',
      category: '分类2'
    }
  ];

  @Builder
  RelatedVideoItem(item: VideoItem) {
    Row() {
      Image(item.cover)
        .width(120)
        .height(68)
        .borderRadius(8)

      Column() {
        Text(item.title)
          .fontSize(14)
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Row() {
          Text(item.author)
            .fontSize(12)
            .fontColor('#999999')
          Text(`${item.playCount}次播放`)
            .fontSize(12)
            .fontColor('#999999')
            .margin({ left: 8 })
        }
        .margin({ top: 4 })
      }
      .layoutWeight(1)
      .margin({ left: 12 })
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding(12)
    .backgroundColor('#FFFFFF')
    .onClick(() => {
      // 跳转到新的视频详情页
      router.pushUrl({
        url: 'pages/VideoDetail',
        params: { videoId: item.id }
      });
    })
  }

  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Image($rawfile('Default/back_default.png'))
          .width(24)
          .height(24)
          .onClick(() => {
            router.back();
          })
        Text('视频详情')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .margin({ left: 16 })
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#FFFFFF')

      // 视频播放器
      VideoComponent({ data: this.videoData })
        .width('100%')
        .height('30%')

      // 视频信息
      Column() {
        Text(this.videoData.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .margin({ top: 16, bottom: 8 })

        Row() {
          Image($r('app.media.avatar_1'))
            .width(32)
            .height(32)
            .borderRadius(16)
          Column() {
            Text(this.videoData.author)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
            Text(`${this.videoData.playCount}次播放`)
              .fontSize(12)
              .fontColor('#999999')
          }
          .alignItems(HorizontalAlign.Start)
          .margin({ left: 8 })
          .layoutWeight(1)

          Button('关注')
            .height(32)
            .backgroundColor('#FF2D55')
            .borderRadius(16)
        }
        .width('100%')
        .padding({ left: 16, right: 16 })

        // 操作按钮
        Row() {
          Row() {
            Image($r('app.media.ic_like'))
              .width(24)
              .height(24)
            Text('点赞')
              .fontSize(14)
              .margin({ left: 4 })
          }
          .layoutWeight(1)

          Row() {
            Image($r('app.media.ic_comment'))
              .width(24)
              .height(24)
            Text('评论')
              .fontSize(14)
              .margin({ left: 4 })
          }
          .layoutWeight(1)
          .onClick(() => {
            router.pushUrl({
              url: 'pages/CommentsPage',
              params: { videoId: this.videoData.id }
            });
          })

          Row() {
            Image($r('app.media.ic_share'))
              .width(24)
              .height(24)
            Text('分享')
              .fontSize(14)
              .margin({ left: 4 })
          }
          .layoutWeight(1)
        }
        .width('100%')
        .padding(16)
        .margin({ top: 16 })
        .borderRadius(8)
        .backgroundColor('#F5F5F5')
      }
      .width('100%')
      .padding({ left: 16, right: 16 })
      .backgroundColor('#FFFFFF')

      // 相关推荐
      Text('相关推荐')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .margin({ top: 16, left: 16 })

      List() {
        ForEach(this.relatedVideos, (item: VideoItem) => {
          ListItem() {
            this.RelatedVideoItem(item)
          }
        })
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor('#F5F5F5')
    }
    .width('100%')
    .height('100%')
  }
} 