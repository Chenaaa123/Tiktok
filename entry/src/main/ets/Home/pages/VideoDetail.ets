import router from '@ohos.router';
import { VideoItem, Comment, VideoDetailParams } from '../model/DataModel';
import { VideoComponent } from '../components/VideoComponent';
import { initialV001Comments, initialV002Comments, initialV003Comments, initialV004Comments, 
  initialV005Comments, initialV006Comments, initialV007Comments, initialV008Comments } from '../model/CommentDataInitializer';

@Entry
@Component
struct VideoDetail {
  @State videoData: VideoItem | null = null;
  @State relatedVideos: VideoItem[] = [];
  @State isLiked: boolean = false;
  @State isFollowing: boolean = false;
  private videoController: VideoController | null = null;
  private commentCount: number = 0;
  private likesCount: number = 0;

  @StorageLink('videoCommentsStorage') allVideoComments: Map<string, Comment[]> = new Map();

  aboutToAppear() {
    const params = router.getParams() as VideoDetailParams;
    if (params && params.videoId && params.fullVideoList) {
      const video = params.fullVideoList.find(v => v.id === params.videoId);
      if (video) {
        // 初始化评论数据
        this.initializeComments(params.videoId);
        
        // 更新视频数据，使用真实的评论数
        const comments = this.allVideoComments.get(params.videoId) || [];
        this.videoData = {
          id: video.id,
          title: video.title,
          cover: video.cover,
          thumbnail: video.thumbnail,
          duration: video.duration,
          likes: video.likes,
          comments: comments.length, // 使用真实的评论数
          playCount: video.playCount,
          author: video.author,
          category: video.category,
          description: video.description,
          isLiked: video.isLiked
        };
        this.isLiked = video.isLiked || false;
        this.likesCount = video.likes;
        this.relatedVideos = [];
        for (let i = 0; i < params.fullVideoList.length; i++) {
          const item = params.fullVideoList[i];
          if (item.id !== params.videoId) {
            // 获取相关视频的评论数
            const relatedComments = this.allVideoComments.get(item.id) || [];
            this.relatedVideos.push({
              id: item.id,
              title: item.title,
              cover: item.cover,
              thumbnail: item.thumbnail,
              duration: item.duration,
              likes: item.likes,
              comments: relatedComments.length, // 使用真实的评论数
              playCount: item.playCount,
              author: item.author,
              category: item.category,
              description: item.description,
              isLiked: item.isLiked
            });
          }
        }
        this.updateCommentAndLikeCounts(params.videoId);
      }
    }
  }

  private initializeComments(videoId: string) {
    // 如果还没有评论数据，使用预设的评论
    if (!this.allVideoComments.has(videoId)) {
      let defaultComments: Comment[] = [];
      switch (videoId) {
        case 'v001': defaultComments = initialV001Comments; break;
        case 'v002': defaultComments = initialV002Comments; break;
        case 'v003': defaultComments = initialV003Comments; break;
        case 'v004': defaultComments = initialV004Comments; break;
        case 'v005': defaultComments = initialV005Comments; break;
        case 'v006': defaultComments = initialV006Comments; break;
        case 'v007': defaultComments = initialV007Comments; break;
      }
      const currentAllComments = new Map(this.allVideoComments);
      currentAllComments.set(videoId, defaultComments);
      this.allVideoComments = currentAllComments;
    }
  }

  private formatPlayCount(count: number): string {
    if (count >= 10000) {
      return `${(count / 10000).toFixed(1)}万次播放`;
    }
    return `${count}次播放`;
  }

  private handleLike() {
    this.isLiked = !this.isLiked;
    if (this.videoData) {
      this.videoData.likes = this.isLiked ? this.videoData.likes + 1 : this.videoData.likes - 1;
      this.videoData.isLiked = this.isLiked;
      this.likesCount = this.videoData.likes;

      this.relatedVideos = this.relatedVideos.map(video => {
        if (video.id === this.videoData?.id) {
          return {
            id: video.id,
            title: video.title,
            cover: video.cover,
            thumbnail: video.thumbnail,
            duration: video.duration,
            likes: this.videoData.likes,
            comments: video.comments,
            playCount: video.playCount,
            author: video.author,
            category: video.category,
            description: video.description,
            isLiked: this.videoData.isLiked
          };
        }
        return video;
      });

      const videoId = this.videoData.id;
      const currentAllComments = new Map(this.allVideoComments);
      const videoComments = currentAllComments.get(videoId) || [];

      let myCommentIndex = videoComments.findIndex(c => c.author === '我' && !c.isReply);
      let updatedVideoComments = videoComments.slice();

      if (myCommentIndex === -1) {
        const tempComment: Comment = {
          id: `temp-${videoId}`,
          author: '我',
          avatar: $r('app.media.avatar_1'),
          content: '',
          time: '',
          likes: 0,
          isLiked: true,
          isReply: false
        };
        updatedVideoComments.push(tempComment);
      } else {
        const myComment = updatedVideoComments[myCommentIndex];
        const newIsLiked = !myComment.isLiked;
        
        const updatedComment: Comment = {
          id: myComment.id,
          author: myComment.author,
          avatar: myComment.avatar,
          content: myComment.content,
          time: myComment.time,
          likes: myComment.likes,
          isLiked: newIsLiked,
          parentId: myComment.parentId,
          parentAuthor: myComment.parentAuthor,
          isReply: myComment.isReply
        };
        
        updatedVideoComments[myCommentIndex] = updatedComment;
      }

      currentAllComments.set(videoId, updatedVideoComments);
      this.allVideoComments = currentAllComments;
    }
  }

  private handleFollow() {
    this.isFollowing = !this.isFollowing;
  }

  private handleShare() {
    // TODO: 实现分享功能
    // 1. 支持分享到社交媒体平台
    // 2. 支持生成分享链接
    // 3. 支持保存视频到本地
    console.info('分享功能待实现');
  }

  private updateCommentAndLikeCounts(videoId: string) {
    const comments = this.allVideoComments.get(videoId) || [];
    this.commentCount = comments.length;
    if (this.videoData) {
      this.likesCount = this.videoData.likes;
      this.isLiked = this.videoData.isLiked || false;
    }
  }

  @Builder
  RelatedVideoItem(item: VideoItem) {
    Row() {
      Image(item.thumbnail)
        .width(120)
        .height(68)
        .borderRadius(8)
        .objectFit(ImageFit.Cover)

      Column() {
        Text(item.title)
          .fontSize(14)
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Row() {
          Text(item.author)
            .fontSize(12)
            .fontColor('#999999')
          Text(this.formatPlayCount(item.playCount))
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
      router.pushUrl({
        url: 'Home/pages/VideoDetail',
        params: { videoId: item.id, fullVideoList: this.relatedVideos }
      });
    })
  }

  build() {
    Scroll() {
      Column() {
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

        if (this.videoData) {
          VideoComponent({
            data: this.videoData,
            isDetailMode: true,
            onControllerReady: (controller) => {
              this.videoController = controller;
            }
          })
          .width('100%')
          .height('40%')
          .margin({ top: 16, bottom: 16 })
        }

        Column() {
          Text(this.videoData?.title)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .margin({ top: 0, bottom: 8 })

          Row() {
            Image($r('app.media.avatar_1'))
              .width(32)
              .height(32)
              .borderRadius(16)
            Column() {
              Text(this.videoData?.author)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
              Text(this.formatPlayCount(this.videoData?.playCount || 0))
                .fontSize(12)
                .fontColor('#999999')
            }
            .alignItems(HorizontalAlign.Start)
            .margin({ left: 8 })
            .layoutWeight(1)

            Button(this.isFollowing ? '已关注' : '关注')
              .height(32)
              .backgroundColor(this.isFollowing ? '#999999' : '#FF2D55')
              .borderRadius(16)
              .onClick(() => {
                this.handleFollow();
              })
          }
          .width('100%')
          .padding({ left: 0, right: 0 })

          if (this.videoData?.description) {
            Text(this.videoData.description)
              .fontSize(14)
              .fontColor('#666666')
              .margin({ top: 8, bottom: 16 })
              .maxLines(3)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
          }

          Row() {
            Row() {
              Image($r('app.media.ic_like'))
                .width(24)
                .height(24)
                .fillColor(this.isLiked ? '#FF2D55' : '#000000')
              Text(`点赞(${this.likesCount})`)
                .fontSize(14)
                .fontColor(this.isLiked ? '#FF2D55' : '#000000')
                .margin({ left: 4 })
            }
            .layoutWeight(1)
            .onClick(() => {
              this.handleLike();
            })

            Row() {
              Image($r('app.media.ic_comment'))
                .width(24)
                .height(24)
              Text(`评论(${this.commentCount})`)
                .fontSize(14)
                .margin({ left: 4 })
            }
            .layoutWeight(1)
            .onClick(() => {
              router.pushUrl({
                url: 'Home/pages/CommentsPage',
                params: { 
                  commentCount: this.commentCount,
                  videoId: this.videoData?.id
                }
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
            .onClick(() => {
              this.handleShare();
            })
          }
          .width('100%')
          .padding({ top: 16, bottom: 16, left: 0, right: 0 })
          .borderRadius(8)
          .backgroundColor('#F5F5F5')
          .margin({ top: 16 })
        }
        .width('100%')
        .padding({ left: 16, right: 16 })
        .backgroundColor('#FFFFFF')

        Text('相关推荐')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .margin({ top: 16, left: 16, bottom: 8 })

        List() {
          ForEach(this.relatedVideos, (item: VideoItem) => {
            ListItem() {
              this.RelatedVideoItem(item)
            }
          })
        }
        .width('100%')
        .backgroundColor('#F5F5F5')
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
  }
} 