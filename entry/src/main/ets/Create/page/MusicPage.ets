import media from '@ohos.multimedia.media';
import audio from '@ohos.multimedia.audio';
import { BusinessError } from '@kit.BasicServicesKit';
import { common } from '@kit.AbilityKit';
import Music from '../model/musics'
import { router } from '@kit.ArkUI';

@Entry
@Component
export default struct MusicPage {
  @State play: boolean = false
  avPlayer: media.AVPlayer | null = null
  @State currentProgress: number = 0
  @State totalProgress: number = 1 // 避免除以零错误
  @State isDragging: boolean = false
  @State sliderValue: number = 0
  @State touchPosition: number = 0 // 存储触摸位置
  @State progressWidth: number = 0 // 存储进度条宽度
  private timer: number = 0
  @State hasCompleted: boolean = false // 添加标记,跟踪是否播放完成
  @State index: number = 0
  music_list:Array<Music> = [new Music('春娇与志明(片段)','cover0'),
    new Music('勋章','cover1'),
    new Music('shots','cover2'),
    new Music('秋殇别恋','cover3'),
  ]

  async aboutToAppear() {
    this.avPlayer = await media.createAVPlayer()
    this.playMp3()
  }

  aboutToDisappear(): void {
    if (this.avPlayer) {
      if (this.avPlayer?.state === 'playing') {
        this.avPlayer.stop()
        this.avPlayer.release()
      }
      this.avPlayer?.release()
      this.avPlayer = null
    }
    clearInterval(this.timer)
  }

  releaseCallback() {
    this.avPlayer?.off('seekDone')
    this.avPlayer?.off('durationUpdate')
    this.avPlayer?.off('error')
    this.avPlayer?.off('timeUpdate')
    this.avPlayer?.off('stateChange')
  }

  // 注册avplayer回调函数
  setAVPlayerCallback(avPlayer: media.AVPlayer | null) {
    // seek操作结果回调函数
    avPlayer?.on('seekDone', (seekDoneTime: number) => {
      console.info(`AVPlayer seek succeeded, seek time is ${seekDoneTime}`);
    });

    avPlayer?.on('durationUpdate', (duration: number) => {
      console.debug(`durationUpdate ${duration}`);
      this.totalProgress = duration > 0 ? duration : 1
    })

    // error回调监听函数
    avPlayer?.on('error', (err: BusinessError) => {
      console.error(`Invoke avPlayer failed, code is ${err.code}, message is ${err.message}`);
      if (avPlayer) {
        avPlayer.reset(); // 调用reset重置资源，触发idle状态
      }
    });

    avPlayer?.on('timeUpdate', (progress: number) => {
      console.debug(`time update ${progress}`);
      if (!this.isDragging) {
        this.currentProgress = progress
        this.sliderValue = progress
      }
    })

    // 状态机变化回调函数
    avPlayer?.on('stateChange', async (state: string, reason: media.StateChangeReason) => {
      if (state !== 'playing') {
        this.play = false
      } else {
        this.play = true
      }

      switch (state) {
        case 'idle': // 成功调用reset接口后触发该状态机上报
          this.currentProgress = 0
          this.sliderValue = 0
          console.info('AVPlayer state idle called.');
          // avPlayer.release(); // 调用release接口销毁实例对象
          break;
        case 'initialized': // avplayer 设置播放源后触发该状态上报
          console.info('AVPlayer state initialized called.');
          if (avPlayer) {
            avPlayer.audioRendererInfo = {
              usage: audio.StreamUsage.STREAM_USAGE_MUSIC, // 音频流使用类型：音乐
              rendererFlags: 0 // 音频渲染器标志
            };
            avPlayer.prepare(); // 准备方法
            this.totalProgress = avPlayer.duration > 0 ? avPlayer.duration : 1
            console.debug(`totalProgress ${this.totalProgress}`);
          }
          break;
        case 'prepared': // prepare调用成功后上报该状态机
          console.info('AVPlayer state prepared called.');
          avPlayer?.play(); // 调用播放接口开始播放
          break;
        case 'playing': // play成功调用后触发该状态机上报
          console.info('AVPlayer state playing called.');
          this.hasCompleted = false
          break;
        case 'paused': // pause成功调用后触发该状态机上报
          console.info('AVPlayer state paused called.');
          break;
        case 'completed': // 播放结束后触发该状态机上报
          console.info('AVPlayer state completed called.');
          this.play = false
          this.hasCompleted = true
          // 不立即调用stop 而是将状态保持为completed状态
          // avPlayer.stop(); // 调用播放结束接口
          break;
        case 'stopped': // stop接口成功调用后触发该状态机上报
          console.info('AVPlayer state stopped called.');
          // avPlayer.reset(); // 调用reset接口初始化avplayer状态
          break;
        case 'released':
          console.info('AVPlayer state released called.');
          break;
        default:
          console.info('AVPlayer state unknown called.');
          break;
      }
    });
  }

  async playMp3() {
    if (this.avPlayer) {
      this.releaseCallback();
      this.avPlayer.release();
      this.avPlayer = null;
    }
    // 创建新实例并加载新歌曲
    this.avPlayer = await media.createAVPlayer();
    this.setAVPlayerCallback(this.avPlayer);
    // this.releaseCallback()
    // this.setAVPlayerCallback(this.avPlayer)
    let context = getContext(this) as common.UIAbilityContext
    let fd = await context.resourceManager.getRawFd('Music/'+`${this.music_list[this.index].name}`+'.mp3')
    let afd: media.AVFileDescriptor = {
      fd: fd.fd,
      offset: fd.offset,
      length: fd.length
    }
    if (this.avPlayer) {
      this.avPlayer.fdSrc = afd;
      console.debug(`totalProgress ${this.totalProgress}`);
    }
  }

  async changePlayStatus() {
    console.debug(`current play state ${this.avPlayer?.state}`);
    if (!this.avPlayer) {
      this.avPlayer = await media.createAVPlayer()
      this.playMp3()
      return;
    }
    if (this.avPlayer?.state === 'playing') {
      this.avPlayer.pause()
    } else if (this.avPlayer?.state === 'paused') {
      this.avPlayer?.play()
    } else if (this.avPlayer?.state === 'completed' || this.hasCompleted) {
      if (this.avPlayer) {
        this.avPlayer.seek(0)
        setTimeout(() => {
          if (this.avPlayer && this.avPlayer.state !== 'playing') {
            this.avPlayer.play()
            this.hasCompleted = false
          }
        }, 100)
      }
    } else if (this.avPlayer.state === 'stopped') {
      /// 如果已停止，通过重置再准备来重新开始
      if (this.avPlayer) {
        this.avPlayer.reset()
        setTimeout(() => {
          this.playMp3()
        }, 100)
      }
    } else if (this.avPlayer.state === 'released' || !this.avPlayer) {
      if (this.avPlayer) {
        this.avPlayer.release()
      }
      this.hasCompleted = false
      this.avPlayer = await media.createAVPlayer()
      this.playMp3()
    }
  }

  // 格式化时间为 MM:SS
  formatTime(seconds: number): string {
    const mins = Math.floor(seconds / 1000 / 60)
    const secs = Math.floor((seconds / 1000) % 60)
    return `${mins.toString().padStart(2, '0')}:${secs.toString().padStart(2, '0')}`
  }

  // 计算进度百分比
  getProgressPercentage(): number {
    return this.totalProgress > 0 ? (this.sliderValue / this.totalProgress) * 100 : 0
  }

  // 从触摸位置更新进度值
  updateProgressFromTouch(touchX: number) {
    if (this.progressWidth <= 0) {
      return
    }

    // 计算百分比并限制在0-1之间
    const percentage = Math.max(0, Math.min(1, touchX / this.progressWidth))

    // 更新滑块值
    this.sliderValue = percentage * this.totalProgress
    this.touchPosition = touchX
  }

  // 应用进度（seek到新位置）
  applyProgress() {
    if (this.avPlayer &&
      (this.avPlayer.state === 'playing' || this.avPlayer.state === 'paused' || this.avPlayer.state === 'completed' || this.hasCompleted )) {
      console.log(`Seeking to ${this.sliderValue}ms`)
      this.avPlayer.seek(this.sliderValue)
      this.currentProgress = this.sliderValue
      if (this.avPlayer.state==='completed' || this.hasCompleted) {
        setTimeout(()=>{
          if (this.avPlayer&&this.avPlayer.state!=='playing') {
            this.avPlayer.play()
            this.hasCompleted = false
          }
        },100)

      }
    }
  }

  build() {
    Column() {
      Image($r('app.media.back'))
        .width(30)
        .margin({right:350,top:10})
        .onClick(()=>{
          router.back()
        })
        // 顶部标题
      Text('正在播放')
        .fontSize(25)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FFFFFF')
        .margin({ top: 20, bottom: 10 })

      // 专辑旋转组件
      RotatingAlbum({ isPlaying: this.play, cover:this.music_list[this.index].cover})

      // 音乐信息
      Text(`${this.music_list[this.index].name}`)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FFFFFF')
        .margin({ top: 20 })

      Text('轻音乐大师 - 心灵治愈系列')
        .fontSize(14)
        .fontColor('#FFFFFF')
        .opacity(0.8)
        .margin({ top: 5, bottom: 20 })

      // 进度条和时间显示
      Row() {
        Text(this.formatTime(this.currentProgress))
          .fontSize(14)
          .fontColor('#FFFFFF')
          .opacity(0.8)
          .width(50)
          .textAlign(TextAlign.Start)

        // 自定义进度条区域
        Stack({ alignContent: Alignment.Start }) {
          // 背景条
          Progress({ value: 100, total: 100 })
            .width('100%')
            .height(4)
            .color('rgba(255, 255, 255, 0.3)')
            .borderRadius(2)

          // 进度条
          Progress({ value: this.getProgressPercentage(), total: 100 })
            .width('100%')
            .height(4)
            .color('#FFFFFF')
            .borderRadius(2)

          // 拖动手柄
          if (this.isDragging) {
            Circle()
              .width(15)
              .height(15)
              .fill('#FFFFFF')
              .position({ x: `${this.getProgressPercentage()}%`, y: '50%' })
              .translate({ x: -7.5, y: -7.5 })// 居中显示
              .shadow({
                radius: 4,
                color: 'rgba(0, 0, 0, 0.2)',
                offsetX: 0,
                offsetY: 2
              })
          }
        }
        .width('70%')
        .height(30) // 增加高度以便于触摸
        .onAreaChange((oldArea: Area, newArea: Area) => {
          // 获取进度条宽度
          this.progressWidth = newArea.width as number
        })
        // 添加触摸事件处理
        .onTouch((event: TouchEvent) => {
          if (event.type === TouchType.Down) {
            this.isDragging = true
            // 更新进度值
            if (event.touches.length > 0) {
              this.updateProgressFromTouch(event.touches[0].x)
            }
          } else if (event.type === TouchType.Move && this.isDragging) {
            // 拖动时更新进度
            if (event.touches.length > 0) {
              this.updateProgressFromTouch(event.touches[0].x)
            }
          } else if (event.type === TouchType.Up || event.type === TouchType.Cancel) {
            // 应用进度
            this.applyProgress()
            this.isDragging = false
          }
        })

        Text(this.formatTime(this.totalProgress))
          .fontSize(14)
          .fontColor('#FFFFFF')
          .opacity(0.8)
          .width(50)
          .textAlign(TextAlign.End)
      }
      .width('90%')

      // 播放控制按钮
      Row({ space: 40 }) {
        //上一首
        Image($r('app.media.front'))
          .width(30)
          .height(30)
          .fillColor('#FFFFFF')
          .onClick(() => {
            if (this.index === 0){
              this.index = this.music_list.length - 1
            }else{
              this.index= this.index-1
            }
            this.playMp3()
          })
        // 播放/暂停按钮
        Image(this.play ? $r('app.media.pause') : $r("app.media.play"))
          .width(30)
          .height(30)
          .fillColor('#FFFFFF')
          .onClick(() => {
            this.changePlayStatus()
          })
        //下一首
        Image($r('app.media.after'))
          .width(30)
          .height(30)
          .fillColor('#FFFFFF')
          .onClick(() => {
            if (this.index === this.music_list.length-1){
              this.index= 0
            }else{
              this.index = this.index + 1
            }
            this.playMp3()
          })
      }
      .width('90%')
      .justifyContent(FlexAlign.Center)
      .margin({ top: 40 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('black')
    .backgroundImage($r('app.media.music_background'))
    .backgroundImageSize({width:400,})
  }
}

@Component
struct RotatingAlbum {
  private timer: number = 0
  @State private angle: number = 0
  @Prop isPlaying: boolean = false
  @Prop cover:string = 'music_cover'

  aboutToAppear(): void {
    this.startRotation()
  }

  aboutToDisappear(): void {
    clearInterval(this.timer)
  }

  startRotation() {
    this.timer = setInterval(() => {
      // 只有在播放状态才旋转
      if (this.isPlaying) {
        this.angle = (this.angle + 0.3) % 360
      }
    }, 16)
  }

  build() {
    Stack() {
      // 专辑封面背景阴影
      Circle()
        .width(260)
        .height(260)
        .fill('rgba(0, 0, 0, 0.2)')
        .position({ x: '50%', y: '50%' })
        .translate({ x: '-50%', y: '-50%' })

      // 专辑外圈
      Circle()
        .width(254)
        .height(254)
        .fill('#333333')
        .position({ x: '50%', y: '50%' })
        .translate({ x: '-50%', y: '-50%' })

      // 专辑内圈（模拟唱片）
      Circle()
        .width(253)
        .height(253)
        .fill('#111111')
        .position({ x: '50%', y: '50%' })
        .translate({ x: '-50%', y: '-50%' })
        .rotate({ angle: this.angle })

      // 专辑封面图片
      Image($r('app.media.'+`${this.cover}`))
        .width(220)
        .height(220)
        .borderRadius(110)// 圆形专辑封面
        .position({ x: '50%', y: '50%' })
        .translate({ x: '-50%', y: '-50%' })
        .rotate({ angle: this.angle })

      // 中心小圆点
      Circle()
        .width(20)
        .height(20)
        .fill('#FFFFFF')
        .position({ x: '50%', y: '50%' })
        .translate({ x: '-50%', y: '-50%' })
    }
    .width('100%')
    .height(300)
  }
}