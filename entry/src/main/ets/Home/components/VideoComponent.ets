import { VideoItem, VideoPreparedEvent, VideoUpdateEvent, FullscreenChangeEvent, VideoErrorEvent, CommentDataUpdate, VideoComponentState, VideoStyles, FontSizes, ColorPalette } from '../model/DataModel';
import { router } from '@kit.ArkUI';

// 字体大小常量
const FONT_SIZES: FontSizes = {
  SMALL: 12,
  MEDIUM: 14,
  LARGE: 16
};

// 颜色常量
const COLORS: ColorPalette = {
  PRIMARY: '#FF2D55',
  WHITE: '#FFFFFF',
  GRAY: '#666666',
  BLACK: '#000000',
  OVERLAY: 'rgba(0, 0, 0, 0.5)'
};

// 样式常量
const STYLES: VideoStyles = {
  CONTROLS_TIMEOUT: 3000,
  PLAY_BUTTON_SIZE: 60,
  CONTROL_ICON_SIZE: 24,
  FULLSCREEN_BUTTON_SIZE: 40,
  SLIDER_HEIGHT: 6,
  FONT_SIZE: FONT_SIZES,
  COLORS: COLORS
};

@Component
export struct VideoComponent {
  @Prop data: VideoItem;
  onCommentClick?: () => void;
  onControllerReady?: (controller: VideoController) => void;
  onPlayStateChange?: (isPlaying: boolean) => void;
  @Prop isDetailMode: boolean = false;
  
  @State private state: VideoComponentState = {
    isFullscreen: false,
    showControls: false,
    currentTime: 0,
    duration: 0,
    isPlaying: true,
    isLiked: false,
    likeCount: 0,
    commentCount: 0
  };
  
  private controlsTimer: number = -1;
  private videoController: VideoController = new VideoController();

  aboutToAppear() {
    this.state.likeCount = this.data.likes || 0;
    this.state.commentCount = this.data.comments || 0;
    this.onControllerReady?.(this.videoController);
  }

  formatTime(seconds: number): string {
    const minutes = Math.floor(seconds / 60);
    const remainingSeconds = Math.floor(seconds % 60);
    return `${minutes}:${remainingSeconds.toString().padStart(2, '0')}`;
  }

  showControlsTemporarily() {
    this.state.showControls = true;
    if (this.controlsTimer !== -1) {
      clearTimeout(this.controlsTimer);
    }
    this.controlsTimer = setTimeout(() => {
      this.state.showControls = false;
    }, STYLES.CONTROLS_TIMEOUT);
  }

  handleProgressChange(value: number) {
    try {
      this.state.currentTime = value;
      this.videoController.setCurrentTime(value);
      if (!this.state.isPlaying) {
        this.videoController.start();
        this.state.isPlaying = true;
      }
    } catch (error) {
      console.error('设置视频时间失败:', error);
    }
  }

  togglePlay() {
    try {
      if (this.state.isPlaying) {
        this.videoController.pause();
        this.state.isPlaying = false;
        this.onPlayStateChange?.(false);
      } else {
        this.videoController.start();
        this.state.isPlaying = true;
        this.onPlayStateChange?.(true);
      }
    } catch (error) {
      console.error('切换播放状态失败:', error);
    }
  }

  toggleFullscreen() {
    if (this.state.isFullscreen) {
      this.videoController.exitFullscreen();
      this.state.isFullscreen = false;
    } else {
      this.videoController.requestFullscreen(true);
      this.state.isFullscreen = true;
    }
  }

  handleLike() {
    this.state.isLiked = !this.state.isLiked;
    this.state.likeCount += this.state.isLiked ? 1 : -1;
  }

  @Builder
  PlayButton() {
    Column() {
      Image($rawfile('Video/Video_Play.png'))
        .width(STYLES.PLAY_BUTTON_SIZE)
        .height(STYLES.PLAY_BUTTON_SIZE)
        .fillColor(STYLES.COLORS.WHITE)
        .onClick(() => {
          this.togglePlay();
          this.showControlsTemporarily();
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .zIndex(1001)
  }

  @Builder
  VideoControls() {
    Column() {
      Row() {
        Text(this.formatTime(this.state.currentTime))
          .fontSize(STYLES.FONT_SIZE.SMALL)
          .fontColor(STYLES.COLORS.WHITE)
          .margin({ right: 8 })
        
        Slider({
          value: this.state.currentTime,
          min: 0,
          max: this.state.duration,
          step: 1
        })
          .width('100%')
          .height(STYLES.SLIDER_HEIGHT)
          .selectedColor(STYLES.COLORS.PRIMARY)
          .onChange((value: number) => {
            this.handleProgressChange(value);
          })
        
        Text(this.formatTime(this.state.duration))
          .fontSize(STYLES.FONT_SIZE.SMALL)
          .fontColor(STYLES.COLORS.WHITE)
          .margin({ left: 8 })
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .backgroundColor(STYLES.COLORS.OVERLAY)
      .margin({ top: '60%' })
    }
  }

  @Builder
  VideoInfo() {
    Column() {
      Text(this.data.title)
        .fontSize(STYLES.FONT_SIZE.LARGE)
        .fontWeight(FontWeight.Medium)
        .fontColor(STYLES.COLORS.WHITE)
        .margin({ bottom: 8 })

      Row() {
        Text(this.formatTime(this.state.duration))
          .fontSize(STYLES.FONT_SIZE.SMALL)
          .fontColor(STYLES.COLORS.WHITE)

        Blank()

        Row() {
          Image($r('app.media.ic_like'))
            .width(STYLES.CONTROL_ICON_SIZE)
            .height(STYLES.CONTROL_ICON_SIZE)
            .fillColor(this.state.isLiked ? STYLES.COLORS.PRIMARY : STYLES.COLORS.WHITE)
          Text(this.state.likeCount.toString())
            .fontSize(STYLES.FONT_SIZE.MEDIUM)
            .fontColor(STYLES.COLORS.WHITE)
            .margin({ left: 4 })
        }
        .onClick(() => {
          this.handleLike();
        })
        .margin({ right: 24 })

        Row() {
          Image($r('app.media.ic_comment'))
            .width(STYLES.CONTROL_ICON_SIZE)
            .height(STYLES.CONTROL_ICON_SIZE)
            .fillColor(STYLES.COLORS.WHITE)
          Text(this.state.commentCount.toString())
            .fontSize(STYLES.FONT_SIZE.MEDIUM)
            .fontColor(STYLES.COLORS.WHITE)
            .margin({ left: 4 })
        }
        .onClick(() => {
          router.pushUrl({
            url: 'Home/pages/CommentsPage',
            params: {
              videoId: this.data.id,
              commentCount: this.state.commentCount,
              onDataChange: (data: CommentDataUpdate) => {
                this.state.commentCount = data.commentCount;
              }
            }
          });
        })
      }
      .width('100%')
    }
    .padding(16)
    .width('100%')
    .position({ x: 0, y: '70%' })
  }

  build() {
    Column() {
      Stack() {
        Video({
          src: this.data.cover,
          controller: this.videoController
        })
          .width('100%')
          .height('100%')
          .objectFit(ImageFit.Contain)
          .autoPlay(true)
          .controls(false)
          .loop(true)
          .onStart(() => {
            this.state.isPlaying = true;
            this.onPlayStateChange?.(true);
          })
          .onPause(() => {
            this.state.isPlaying = false;
            this.onPlayStateChange?.(false);
          })
          .onFinish(() => {
            this.state.isPlaying = false;
            this.onPlayStateChange?.(false);
          })
          .onError(() => {
            console.error('视频播放错误');
            this.videoController.reset();
            this.videoController.start();
            this.state.isPlaying = true;
          })
          .onPrepared((event: VideoPreparedEvent) => {
            this.state.duration = event.duration;
          })
          .onUpdate((event: VideoUpdateEvent) => {
            this.state.currentTime = event.time;
          })
          .onFullscreenChange((event: FullscreenChangeEvent) => {
            this.state.isFullscreen = event.fullscreen;
            this.showControlsTemporarily();
          })

        if (!this.state.isPlaying) {
          this.PlayButton()
        }

        if (this.state.showControls) {
          this.VideoControls()
        }

        if (!this.isDetailMode) {
          Image(this.state.isFullscreen ?
            $r('app.media.ic_fullscreen_exit') :
            $r('app.media.ic_fullscreen'))
            .width(STYLES.FULLSCREEN_BUTTON_SIZE)
            .height(STYLES.FULLSCREEN_BUTTON_SIZE)
            .fillColor(STYLES.COLORS.WHITE)
            .position({ x: '90%', y: '85%' })
            .onClick(() => {
              this.toggleFullscreen();
            })
            .zIndex(999)
        }

        if (this.state.isFullscreen) {
          Image($rawfile('Default/back_white_default.png'))
            .width(STYLES.FULLSCREEN_BUTTON_SIZE)
            .height(STYLES.FULLSCREEN_BUTTON_SIZE)
            .fillColor(STYLES.COLORS.WHITE)
            .position({ x: 20, y: 20 })
            .onClick(() => {
              this.toggleFullscreen();
            })
            .zIndex(1000)
        }
      }
      .width('100%')
      .height('100%')
      .backgroundColor(STYLES.COLORS.BLACK)

      if (!this.isDetailMode) {
        this.VideoInfo()
      }
    }
    .width('100%')
    .height('100%')
  }
}