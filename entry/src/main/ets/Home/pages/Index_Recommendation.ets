import { VideoComponent } from '../components/VideoComponent';
import router from '@ohos.router';
import Discover from '../../Discover/pages/Discover';
import hilog from '@ohos.hilog';
import { VideoItem as VideoItemType, Comment, CommentDataUpdate } from '../model/DataModel';
import { initialV001Comments, initialV002Comments, initialV003Comments, initialV004Comments, 
  initialV005Comments, initialV006Comments, initialV007Comments, initialV008Comments } from '../model/CommentDataInitializer';
import MusicPage from '../../Create/page/MusicPage';

@Entry
@Component
export default struct Index_Recommendation {
  @State currentIndex: number = 1;
  private tabsController: TabsController = new TabsController();
  private lastClickTime: number = 0;
  private doubleClickInterval: number = 300; // 双击间隔时间（毫秒）
  private videoControllers: Map<string, VideoController> = new Map();
  private videoPlayingStates: Map<string, boolean> = new Map();
  @State videoList: VideoItemType[] = [];

  // Link to PersistentStorage
  @StorageLink('videoCommentsStorage') allVideoComments: Map<string, Comment[]> = new Map();

  aboutToAppear() {
    // 设置初始标签页为热门
    this.tabsController.changeIndex(1);
    // 初始化视频列表
    this.initializeVideoList();
  }

  // 初始化视频列表
  private initializeVideoList() {
    this.videoList = [
      {
        id: 'v001',
        title: '沉浸式体验夕阳西下',
        cover: $rawfile('Video/the_setting_sun.mp4'),
        thumbnail: $rawfile('Video/the_setting_sun_thumbnail.png'),
        duration: 185,
        likes: 1280,
        comments: this.getCommentCount('v001'),
        playCount: 1052000,
        author: '旅行达人',
        category: '旅行',
        description: '这是一段记录壮丽夕阳美景的视频。金色的阳光洒满天空，染红了云彩，整个世界都沉浸在宁静而温暖的氛围中。跟随镜头，一起感受大自然的鬼斧神工，放慢脚步，享受这难得的宁静时刻。',
        isLiked: false,
      },
      {
        id: 'v002',
        title: '来次美妙的公路骑行',
        cover: $rawfile('Video/Road_Cycling.mp4'),
        thumbnail: $rawfile('Video/Road_Cycling_thumbnail.png'),
        duration: 245,
        likes: 2560,
        comments: this.getCommentCount('v002'),
        playCount: 850000,
        author: '运动达人',
        category: '运动',
        description: '穿梭于风景如画的公路上，感受风的速度与自由。这段视频记录了一次充满活力的公路骑行，沿途的自然风光令人心旷神怡。无论是专业的骑行爱好者还是喜欢户外运动的你，都能从中找到乐趣。',
        isLiked: false,
      },
      {
        id: 'v003',
        title: '城市夜景',
        cover: $rawfile('Video/City_Night_View.mp4'),
        thumbnail: $rawfile('Video/City_Night_View_thumbnail.png'),
        duration: 180,
        likes: 1500,
        comments: this.getCommentCount('v003'),
        playCount: 920000,
        author: '城市探索者',
        category: '城市',
        description: '当夜幕降临，城市亮起点点灯光，展现出与白天截然不同的魅力。这段视频捕捉了城市夜晚的繁华与宁静，高楼大厦的轮廓在夜色中显得格外迷人。一起来感受这座不夜城的独特韵味。',
        isLiked: false,
      },
      {
        id: 'v004',
        title: '雨中漫步',
        cover: $rawfile('Video/Rain_Road.mp4'),
        thumbnail: $rawfile('Video/Rain_Road_thumbnail.png'),
        duration: 160,
        likes: 1800,
        comments: this.getCommentCount('v004'),
        playCount: 880000,
        author: '雨景摄影师',
        category: '自然',
        description: '在雨中漫步，感受雨滴落在伞上的声音，呼吸湿润清新的空气。这段视频带您体验雨天的宁静与浪漫，绿叶被雨水洗刷得更加翠绿，地面湿润反光，构成一幅幅美丽的画面。抛开烦恼，享受雨中的片刻宁静。',
        isLiked: false,
      },
      {
        id: 'v005',
        title: '美食之旅',
        cover: $rawfile('Video/food_video.mp4'),
        thumbnail: $rawfile('Video/food_video_thumbnail.png'),
        duration: 200,
        likes: 2200,
        comments: this.getCommentCount('v005'),
        playCount: 950000,
        author: '美食家',
        category: '美食',
        description: '一场味蕾的探险，带您领略各种诱人的美食。从街头小吃到精致料理，这段视频汇集了令人垂涎的美味瞬间。准备好纸巾，因为您可能会忍不住流口水！发现新的美食灵感，计划您的下一场美食之旅。',
        isLiked: false,
      },
      {
        id: 'v006',
        title: '旅行日记',
        cover: $rawfile('Video/travel_video.mp4'),
        thumbnail: $rawfile('Video/travel_video_thumbnail.png'),
        duration: 220,
        likes: 1900,
        comments: this.getCommentCount('v006'),
        playCount: 890000,
        author: '旅行者',
        category: '旅行',
        description: '用镜头记录旅行中的点点滴滴，与您分享旅途的快乐与感悟。这段视频是一份充满回忆的旅行日记，涵盖了壮丽的自然风光、独特的风土人情和难忘的经历。希望能激发您的旅行热情，开启属于您自己的旅程。',
        isLiked: false,
      },
      {
        id: 'v007',
        title: '音乐现场',
        cover: $rawfile('Video/music_video.mp4'),
        thumbnail: $rawfile('Video/music_video_thumbnail.png'),
        duration: 180,
        likes: 2100,
        comments: this.getCommentCount('v007'),
        playCount: 910000,
        author: '音乐人',
        category: '音乐',
        description: '置身于 pulsating 的音乐节现场，感受音浪的冲击与热情的碰撞。这段视频捕捉了精彩的音乐表演瞬间，台上的艺术家们倾情投入，台下的观众们尽情狂欢。一起来感受音乐带来的无限能量与激情。',
        isLiked: false,
      },
      {
        id: 'v008',
        title: '舞蹈表演',
        cover: $rawfile('Video/dance_video.mp4'),
        thumbnail: $rawfile('Video/dance_video_thumbnail.png'),
        duration: 190,
        likes: 2400,
        comments: this.getCommentCount('v008'),
        playCount: 980000,
        author: '舞者',
        category: '舞蹈',
        description: '一场视觉与节奏的盛宴，展现舞者们精湛的技艺与独特的魅力。这段视频记录了充满力量与美感的舞蹈表演，每一个动作都充满了表现力。感受身体的律动，欣赏舞蹈艺术的魅力。',
        isLiked: false,
      }
    ];
  }

  // Function to get comment count for a video
  private getCommentCount(videoId: string): number {
    const comments = this.allVideoComments.get(videoId);
    if (!comments) {
      // 如果没有评论数据，使用预设评论
      switch (videoId) {
        case 'v001': return initialV001Comments.length;
        case 'v002': return initialV002Comments.length;
        case 'v003': return initialV003Comments.length;
        case 'v004': return initialV004Comments.length;
        case 'v005': return initialV005Comments.length;
        case 'v006': return initialV006Comments.length;
        case 'v007': return initialV007Comments.length;
        case 'v008': return initialV008Comments.length;
        default: return 0;
      }
    }
    return comments.length;
  }

  // 更新视频评论数
  private updateVideoCommentCount(videoId: string) {
    const index = this.videoList.findIndex(video => video.id === videoId);
    if (index !== -1) {
      const currentVideo = this.videoList[index];
      const updatedVideo: VideoItemType = {
        id: currentVideo.id,
        title: currentVideo.title,
        cover: currentVideo.cover,
        thumbnail: currentVideo.thumbnail,
        duration: currentVideo.duration,
        likes: currentVideo.likes,
        comments: this.getCommentCount(videoId),
        playCount: currentVideo.playCount,
        author: currentVideo.author,
        category: currentVideo.category,
        description: currentVideo.description,
        isLiked: currentVideo.isLiked
      };
      this.videoList[index] = updatedVideo;
    }
  }

  // 监听评论数据变化
  onPageShow() {
    // 更新所有视频的评论数
    this.videoList.forEach(video => {
      this.updateVideoCommentCount(video.id);
    });
  }

  // Handle video click (single click for play/pause, double click for detail)
  private handleVideoClick(item: VideoItemType) {
    const currentTime = new Date().getTime();
    if (currentTime - this.lastClickTime < this.doubleClickInterval) {
      // Double click
      hilog.info(0x0000, 'testTag', '%{public}s', `Double clicked on video ${item.id}`);
      router.pushUrl({
        url: 'Home/pages/VideoDetail',
        params: { videoId: item.id, fullVideoList: this.videoList }
      }, router.RouterMode.Single);
      this.lastClickTime = 0; // Reset for next click
    } else {
      // Single click
      hilog.info(0x0000, 'testTag', '%{public}s', `Single clicked on video ${item.id}`);
      const controller = this.videoControllers.get(item.id);
      const isPlaying = this.videoPlayingStates.get(item.id) || false;
      if (controller) {
        if (isPlaying) {
          controller.pause();
        } else {
          controller.start();
        }
      }
      this.lastClickTime = currentTime;
    }
  }

  // Handle like click for a video item
  private handleVideoItemLike(video: VideoItemType) {
    // This is a simplified approach. A more robust solution would involve a dedicated like mechanism.
    // For now, we'll toggle the isLiked state of the first comment by '我' if it exists.
    const videoId = video.id;
    const currentAllComments = new Map(this.allVideoComments);
    const videoComments = currentAllComments.get(videoId) || [];

    // Find a comment by '我' or create a temporary one if none exists to handle like state
    let myCommentIndex = videoComments.findIndex(c => c.author === '我' && !c.isReply);
    let updatedVideoComments = [...videoComments];

    if (myCommentIndex === -1) {
      // No comment by '我', add a temporary one to track like state
      const tempComment: Comment = {
        id: `temp-${videoId}`, // Use a temporary ID
        author: '我',
        avatar: $r('app.media.avatar_1'), // Use default avatar
        content: '', // No content for temporary comment
        time: '', // No time
        likes: 0,
        isLiked: true, // Assume liking it now
        isReply: false
      };
      updatedVideoComments.push(tempComment);
    } else {
      // Found a comment by '我', toggle its isLiked state and update likes count
      const myComment = updatedVideoComments[myCommentIndex];
      const isLiked = !myComment.isLiked;
      const likes = isLiked ? myComment.likes + 1 : myComment.likes - 1;
      updatedVideoComments[myCommentIndex] = {
        id: myComment.id,
        author: myComment.author,
        avatar: myComment.avatar,
        content: myComment.content,
        time: myComment.time,
        likes: likes,
        isLiked: isLiked,
        parentId: myComment.parentId,
        parentAuthor: myComment.parentAuthor,
        isReply: myComment.isReply
      };
    }

    // Update the StorageLink Map
    currentAllComments.set(videoId, updatedVideoComments);
    this.allVideoComments = currentAllComments; // Trigger StorageLink update

    // Note: The like count displayed on the UI will be the sum of likes on all comments for this video.
    // If you need a separate like count for the video itself, you would need a different data structure.
  }

  @Builder
  TabBuilder(title: string, index: number) {
    Column() {
      if (index === 0) {
        // 音乐标签图标
        Image(this.currentIndex === index ? $r('app.media.ic_music_selected') : $r('app.media.ic_music_normal'))
          .width(24)
          .height(24)
          .margin({ bottom: 4 })
      } else if (index === 1) {
        // 热门标签图标
        Image(this.currentIndex === index ? $r('app.media.ic_hot_selected') : $r('app.media.ic_hot_normal'))
          .width(24)
          .height(24)
          .margin({ bottom: 4 })
      } else if (index === 2) {
        // 推荐标签图标
        Image(this.currentIndex === index ? $r('app.media.ic_recommend_selected') : $r('app.media.ic_recommend_normal'))
          .width(24)
          .height(24)
          .margin({ bottom: 4 })
      }
      Text(title)
        .fontColor(this.currentIndex === index ? '#FFFFFF' : '#CCCCCC')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
    }
    .width('100%')
    .height(60)
    .justifyContent(FlexAlign.Center)
  }

  @Builder
  HomeTabs() {
    Tabs({ barPosition: BarPosition.Start, controller: this.tabsController, index: 1 }) {
      // 音乐页
      TabContent() {
        Column() {
          MusicPage()
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#FFFFFF')
      }
      .tabBar(this.TabBuilder('音乐', 0))

      // 热门页 - 视频播放
      TabContent() {
        Swiper() {
          ForEach(this.videoList, (item: VideoItemType) => {
            Stack() {
              VideoComponent({
                data: item,
                onCommentClick: () => {
                  router.pushUrl({
                    url: 'Home/pages/CommentsPage',
                    params: { 
                      commentCount: this.getCommentCount(item.id), 
                      videoId: item.id,
                      onDataChange: (data: CommentDataUpdate) => {
                        // 当评论数据变化时更新视频列表
                        this.updateVideoCommentCount(item.id);
                      }
                    }
                  }, router.RouterMode.Single);
                },
                onControllerReady: (controller: VideoController) => {
                  this.videoControllers.set(item.id, controller);
                  this.videoPlayingStates.set(item.id, true);
                },
                onPlayStateChange: (isPlaying: boolean) => {
                  this.videoPlayingStates.set(item.id, isPlaying);
                }
              })
                .width('100%')
                .height('100%')
                .onClick(() => {
                  this.handleVideoClick(item);
                })
            }
            .width('100%')
            .height('100%')
            .backgroundColor('#000000')
          })
        }
        .vertical(true)
        .autoPlay(false)
        .indicator(false)
        .width('100%')
        .height('100%')
      }
      .tabBar(this.TabBuilder('热门', 1))

      // 推荐页 - 显示发现页面的推荐内容
      TabContent() {
        Column() {
          Discover()
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#FFFFFF')
      }
      .tabBar(this.TabBuilder('推荐', 2))
    }
    .barWidth('100%')
    .barHeight(60)
    .barMode(BarMode.Fixed)
    .onChange((index: number) => {
      this.currentIndex = index;
    })
    .backgroundColor('#000000')
    .layoutWeight(1)
  }

  build() {
    Column() {
      this.HomeTabs()
    }
    .height('100%')
    .width('100%')
  }
}
