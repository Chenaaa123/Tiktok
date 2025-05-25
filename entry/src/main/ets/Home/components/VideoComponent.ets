import { VideoItem } from '../model/DataModel';

// 定义视频事件的接口
interface VideoPreparedEvent {
  duration: number;
}

interface VideoUpdateEvent {
  time: number;
}

@Component
export struct VideoComponent {
  @Prop data: VideoItem;
  onCommentClick?: () => void;
  @State isFullscreen: boolean = false;
  @State showControls: boolean = false;
  @State currentTime: number = 0;
  @State duration: number = 0;
  private controlsTimer: number = -1;

  // 格式化时间
  formatTime(seconds: number): string {
    const minutes = Math.floor(seconds / 60);
    const remainingSeconds = Math.floor(seconds % 60);
    return `${minutes}:${remainingSeconds.toString().padStart(2, '0')}`;
  }

  // 显示控制栏
  showControlsTemporarily() {
    this.showControls = true;
    if (this.controlsTimer !== -1) {
      clearTimeout(this.controlsTimer);
    }
    this.controlsTimer = setTimeout(() => {
      this.showControls = false;
    }, 3000);
  }

  @Builder
  VideoInfo() {
    Column() {
      Text(this.data.title)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .margin({ bottom: 8 })

      Row() {
        Text(`${Math.floor(this.data.duration / 60)}:${(this.data.duration % 60).toString().padStart(2, '0')}`)
          .fontSize(12)
          .fontColor('#666666')

        Blank()

        Row() {
          Image($r('app.media.ic_like'))
            .width(16)
            .height(16)
            .margin({ right: 4 })
          Text(this.data.likes.toString())
            .fontSize(12)
            .fontColor('#666666')
        }
        .margin({ right: 16 })

        Row() {
          Image($r('app.media.ic_comment'))
            .width(16)
            .height(16)
            .margin({ right: 4 })
          Text(this.data.comments.toString())
            .fontSize(12)
            .fontColor('#666666')
        }
        .onClick(() => {
          this.onCommentClick?.();
        })
      }
      .width('100%')
    }
    .padding(16)
    .backgroundColor('rgba(0, 0, 0, 0.5)')
    .position({ x: 0, y: '70%' })
    .width('100%')
  }

  @Builder
  VideoControls() {
    Column() {
      // 进度条
      Row() {
        Text(this.formatTime(this.currentTime))
          .fontSize(12)
          .fontColor('#FFFFFF')
          .margin({ right: 8 })
        
        Slider({
          value: this.currentTime,
          min: 0,
          max: this.duration,
          step: 1
        })
          .width('60%')
          .selectedColor('#FF2D55')
          .onChange((value: number) => {
            this.currentTime = value;
          })
        
        Text(this.formatTime(this.duration))
          .fontSize(12)
          .fontColor('#FFFFFF')
          .margin({ left: 8 })
      }
      .width('100%')
      .padding({ left: 16, right: 16 })
      .backgroundColor('rgba(0, 0, 0, 0.5)')
      .position({ x: 0, y: '90%' })
    }
  }

  @Builder
  FullscreenButton() {
    Image(this.isFullscreen ? 
      $r('app.media.ic_fullscreen_exit') : 
      $r('app.media.ic_fullscreen'))
      .width(24)
      .height(24)
      .position({ x: '90%', y: '85%' })
      .fillColor('#FFFFFF')
      .onClick(() => {
        this.isFullscreen = !this.isFullscreen;
      })
  }

  build() {
    Stack() {
      // 视频播放器
      Video({
        src: this.data.cover
      })
        .width('100%')
        .height('100%')
        .objectFit(ImageFit.Contain)
        .autoPlay(true)
        .controls(false)
        .loop(true)
        .onStart(() => {
          // 视频开始播放时的处理
        })
        .onPrepared((event: VideoPreparedEvent) => {
          this.duration = event.duration;
        })
        .onUpdate((event: VideoUpdateEvent) => {
          this.currentTime = event.time;
        })
        .onHover((isHover: boolean) => {
          if (isHover) {
            this.showControlsTemporarily();
          }
        })

      if (this.showControls) {
        this.VideoControls()
      }

      this.FullscreenButton()

      // 视频信息
      this.VideoInfo()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#000000')
  }
} 