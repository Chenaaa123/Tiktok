import router from '@ohos.router';
import { Comment, CommentDataUpdate, CommentsPageParams, CommentStyles, FontSizes, Colors, Spacing, IconSizes } from '../model/DataModel';

// 样式常量定义
const STYLES: CommentStyles = {
  FONT_SIZE: {
    SMALL: 12,    // 小号字体
    MEDIUM: 14,   // 中号字体
    LARGE: 16     // 大号字体
  },
  COLORS: {
    PRIMARY: '#FF2D55',    // 主题色
    SECONDARY: '#007DFF',  // 次要色
    GRAY: '#999999',       // 灰色
    DARK_GRAY: '#666666',  // 深灰色
    WHITE: '#FFFFFF',      // 白色
    BACKGROUND: '#F5F5F5'  // 背景色
  },
  SPACING: {
    SMALL: 8,     // 小间距
    MEDIUM: 16,   // 中间距
    LARGE: 24     // 大间距
  },
  ICON_SIZE: {
    SMALL: 16,    // 小图标
    MEDIUM: 24,   // 中图标
    LARGE: 40     // 大图标
  }
};

// 预设的评论数据 - 视频1的评论
export const v001Comments: Comment[] = [
  {
    id: 'c1',
    author: '旅行爱好者',
    avatar: $r('app.media.avatar_1'),
    content: '夕阳真的太美了，让人心旷神怡！',
    time: '2分钟前',
    likes: 128,
    isLiked: false
  },
  {
    id: 'r1',
    author: '摄影达人',
    avatar: $r('app.media.avatar_2'),
    content: '拍摄角度选得真好，光线也很完美！',
    time: '1分钟前',
    likes: 5,
    isLiked: false,
    parentId: 'c1',
    parentAuthor: '旅行爱好者',
    isReply: true
  },
  {
    id: 'c2',
    author: '自然爱好者',
    avatar: $r('app.media.avatar_3'),
    content: '这个夕阳的颜色太梦幻了，请问是在哪里拍摄的？',
    time: '5分钟前',
    likes: 89,
    isLiked: false
  },
  {
    id: 'r2',
    author: '旅行达人',
    avatar: $r('app.media.avatar_1'),
    content: '在海南三亚的海边拍的，傍晚的景色特别美！',
    time: '4分钟前',
    likes: 12,
    isLiked: false,
    parentId: 'c2',
    parentAuthor: '自然爱好者',
    isReply: true
  }
];

// 预设的评论数据 - 视频2的评论
export const v002Comments: Comment[] = [
  {
    id: 'c1',
    author: '骑行爱好者',
    avatar: $r('app.media.avatar_1'),
    content: '这段路我也骑过，风景确实很棒！',
    time: '3分钟前',
    likes: 98,
    isLiked: false
  },
  {
    id: 'r1',
    author: '运动达人',
    avatar: $r('app.media.avatar_2'),
    content: '下次可以约着一起骑！',
    time: '2分钟前',
    likes: 12,
    isLiked: false,
    parentId: 'c1',
    parentAuthor: '骑行爱好者',
    isReply: true
  },
  {
    id: 'c2',
    author: '户外探险家',
    avatar: $r('app.media.avatar_3'),
    content: '请问这条路线大概多少公里？适合新手吗？',
    time: '6分钟前',
    likes: 45,
    isLiked: false
  },
  {
    id: 'r2',
    author: '运动达人',
    avatar: $r('app.media.avatar_2'),
    content: '全程约30公里，坡度适中，新手也可以尝试！',
    time: '5分钟前',
    likes: 23,
    isLiked: false,
    parentId: 'c2',
    parentAuthor: '户外探险家',
    isReply: true
  }
];

// 预设的评论数据 - 视频3的评论
export const v003Comments: Comment[] = [
  {
    id: 'c1',
    author: '城市探索者',
    avatar: $r('app.media.avatar_1'),
    content: '夜景拍得太美了，城市的另一面！',
    time: '4分钟前',
    likes: 156,
    isLiked: false
  },
  {
    id: 'c2',
    author: '摄影师',
    avatar: $r('app.media.avatar_2'),
    content: '构图很专业，光线处理得也很好！',
    time: '2分钟前',
    likes: 89,
    isLiked: false
  },
  {
    id: 'c3',
    author: '夜生活爱好者',
    avatar: $r('app.media.avatar_3'),
    content: '这个角度拍出来的夜景太震撼了，请问是用什么相机拍的？',
    time: '7分钟前',
    likes: 67,
    isLiked: false
  }
];

// 预设的评论数据 - 视频4的评论
export const v004Comments: Comment[] = [
  {
    id: 'c1',
    author: '雨景爱好者',
    avatar: $r('app.media.avatar_1'),
    content: '雨中的城市别有一番韵味！',
    time: '5分钟前',
    likes: 112,
    isLiked: false
  },
  {
    id: 'r1',
    author: '文艺青年',
    avatar: $r('app.media.avatar_2'),
    content: '让我想起了那首《雨巷》',
    time: '3分钟前',
    likes: 45,
    isLiked: false,
    parentId: 'c1',
    parentAuthor: '雨景爱好者',
    isReply: true
  },
  {
    id: 'c2',
    author: '摄影爱好者',
    avatar: $r('app.media.avatar_3'),
    content: '雨滴的质感拍得真好，请问是用什么镜头拍的？',
    time: '8分钟前',
    likes: 78,
    isLiked: false
  }
];

// 预设的评论数据 - 视频5的评论
export const v005Comments: Comment[] = [
  {
    id: 'c1',
    author: '美食家',
    avatar: $r('app.media.avatar_1'),
    content: '这些美食看起来太诱人了！',
    time: '6分钟前',
    likes: 234,
    isLiked: false
  },
  {
    id: 'c2',
    author: '吃货',
    avatar: $r('app.media.avatar_2'),
    content: '口水都要流出来了，好想去尝尝！',
    time: '4分钟前',
    likes: 167,
    isLiked: false
  },
  {
    id: 'c3',
    author: '美食博主',
    avatar: $r('app.media.avatar_3'),
    content: '请问这些美食是在哪家店拍的？看起来太精致了！',
    time: '9分钟前',
    likes: 145,
    isLiked: false
  }
];

// 预设的评论数据 - 视频6的评论
export const v006Comments: Comment[] = [
  {
    id: 'c1',
    author: '旅行达人',
    avatar: $r('app.media.avatar_1'),
    content: '这些地方我都去过，确实很美！',
    time: '7分钟前',
    likes: 189,
    isLiked: false
  },
  {
    id: 'r1',
    author: '背包客',
    avatar: $r('app.media.avatar_2'),
    content: '能分享一下具体的路线吗？',
    time: '5分钟前',
    likes: 78,
    isLiked: false,
    parentId: 'c1',
    parentAuthor: '旅行达人',
    isReply: true
  },
  {
    id: 'c2',
    author: '摄影爱好者',
    avatar: $r('app.media.avatar_3'),
    content: '风景太美了，请问是用什么相机拍的？',
    time: '10分钟前',
    likes: 123,
    isLiked: false
  }
];

// 预设的评论数据 - 视频7的评论
export const v007Comments: Comment[] = [
  {
    id: 'c1',
    author: '音乐爱好者',
    avatar: $r('app.media.avatar_1'),
    content: '现场氛围太棒了！',
    time: '8分钟前',
    likes: 145,
    isLiked: false
  },
  {
    id: 'c2',
    author: '乐迷',
    avatar: $r('app.media.avatar_2'),
    content: '音质很好，表演也很精彩！',
    time: '6分钟前',
    likes: 98,
    isLiked: false
  },
  {
    id: 'c3',
    author: '音乐制作人',
    avatar: $r('app.media.avatar_3'),
    content: '请问这是什么音乐节？现场效果太震撼了！',
    time: '11分钟前',
    likes: 167,
    isLiked: false
  }
];

// 预设的评论数据 - 视频8的评论
export const v008Comments: Comment[] = [
  {
    id: 'c1',
    author: '舞蹈老师',
    avatar: $r('app.media.avatar_1'),
    content: '动作编排很有创意！',
    time: '9分钟前',
    likes: 167,
    isLiked: false
  },
  {
    id: 'r1',
    author: '舞者',
    avatar: $r('app.media.avatar_2'),
    content: '谢谢老师点评，我们会继续努力！',
    time: '7分钟前',
    likes: 56,
    isLiked: false,
    parentId: 'c1',
    parentAuthor: '舞蹈老师',
    isReply: true
  },
  {
    id: 'c2',
    author: '舞蹈爱好者',
    avatar: $r('app.media.avatar_3'),
    content: '这个舞蹈编排太精彩了，请问是什么舞种？',
    time: '12分钟前',
    likes: 134,
    isLiked: false
  }
];

@Entry
@Component
struct CommentsPage {
  // 链接到持久化存储的评论数据
  @StorageLink('videoCommentsStorage') allVideoComments: Map<string, Comment[]> = new Map<string, Comment[]>();
  // 当前视频的评论列表
  @State comments: Comment[] = [];
  // 新评论内容
  @State newComment: string = '';
  // 正在回复的评论
  @State replyTo: Comment | null = null;
  // 已展开回复的评论ID集合
  @State showReplies: Set<string> = new Set<string>();
  // 评论总数
  private commentCount: number = (router.getParams() as CommentsPageParams)?.commentCount || 0;
  // 当前视频ID
  private videoId: string = (router.getParams() as CommentsPageParams)?.videoId || '';
  // 数据变化回调函数
  private onDataChange: ((data: CommentDataUpdate) => void) | undefined = 
    (router.getParams() as CommentsPageParams)?.onDataChange;
  // 列表滚动控制器
  private listController: Scroller = new Scroller();
  // 初始化标志
  private isInitialized: boolean = false;

  // 页面即将显示时的生命周期函数
  aboutToAppear() {
    if (!this.isInitialized) {
      this.initializeComments();
      this.isInitialized = true;
    }
  }

  // 初始化评论数据
  private initializeComments() {
    // 如果还没有评论数据，使用预设的评论
    if (!this.allVideoComments.has(this.videoId)) {
      let defaultComments: Comment[] = [];
      switch (this.videoId) {
        case 'v001': defaultComments = v001Comments; break;
        case 'v002': defaultComments = v002Comments; break;
        case 'v003': defaultComments = v003Comments; break;
        case 'v004': defaultComments = v004Comments; break;
        case 'v005': defaultComments = v005Comments; break;
        case 'v006': defaultComments = v006Comments; break;
        case 'v007': defaultComments = v007Comments; break;
        case 'v008': defaultComments = v008Comments; break;
      }
      const currentAllComments = new Map(this.allVideoComments);
      currentAllComments.set(this.videoId, defaultComments);
      this.allVideoComments = currentAllComments;
    }
    // 更新本地评论列表
    this.comments = this.allVideoComments.get(this.videoId) || [];
  }

  // 生成唯一ID
  private generateId(): string {
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, (c) => {
      const r = Math.random() * 16 | 0;
      const v = c === 'x' ? r : (r & 0x3 | 0x8);
      return v.toString(16);
    });
  }

  // 获取评论的回复列表
  private getReplies(commentId: string): Comment[] {
    let replies: Comment[] = [];
    
    const getNestedReplies = (parentId: string) => {
      const directReplies = this.comments.filter(c => c.parentId === parentId);
      replies = replies.concat(directReplies);
      directReplies.forEach(reply => {
        getNestedReplies(reply.id);
      });
    };
    
    getNestedReplies(commentId);
    return replies;
  }

  // 更新评论数据
  private updateComments(updatedComments: Comment[]) {
    const currentAllComments = new Map(this.allVideoComments);
    currentAllComments.set(this.videoId, updatedComments);
    this.allVideoComments = currentAllComments;
    this.comments = updatedComments;
  }

  // 处理点赞事件
  handleLike(comment: Comment) {
    const updatedComments = this.comments.map(c => {
      if (c.id === comment.id) {
        const updatedComment: Comment = {
          id: c.id,
          author: c.author,
          avatar: c.avatar,
          content: c.content,
          time: c.time,
          likes: c.isLiked ? c.likes - 1 : c.likes + 1,
          isLiked: !c.isLiked,
          parentId: c.parentId,
          parentAuthor: c.parentAuthor,
          isReply: c.isReply
        };
        return updatedComment;
      }
      return c;
    });

    this.updateComments(updatedComments);
  }

  // 处理回复事件
  handleReply(comment: Comment) {
    this.replyTo = comment;
    // 自动滚动到输入框
    this.listController.scrollTo({
      xOffset: 0,
      yOffset: 500,
      animation: {
        duration: 300,
        curve: Curve.EaseInOut
      }
    });
  }

  // 处理展开/收起回复事件
  handleToggleReplies(commentId: string) {
    if (this.showReplies.has(commentId)) {
      this.showReplies.delete(commentId);
    } else {
      this.showReplies.add(commentId);
    }
  }

  // 发送评论
  sendComment() {
    if (this.newComment.trim()) {
      const newComment: Comment = {
        id: this.generateId(),
        author: '我',
        avatar: $r('app.media.avatar_1'),
        content: this.newComment,
        time: '刚刚',
        likes: 0,
        isLiked: false,
        parentId: this.replyTo?.id,
        parentAuthor: this.replyTo?.author,
        isReply: this.replyTo !== null
      };

      const currentVideoComments = this.allVideoComments.get(this.videoId) || [];
      const updatedVideoComments = [newComment].concat(currentVideoComments);
      this.updateComments(updatedVideoComments);

      if (this.replyTo) {
        const originalCommentId = this.replyTo.isReply ? this.replyTo.parentId : this.replyTo.id;
        if (originalCommentId) {
          this.showReplies.add(originalCommentId);
        }
      }
      
      this.commentCount = this.comments.length;
      this.onDataChange?.({
        commentCount: this.commentCount,
        likeCount: 0,
        isLiked: false
      });
      this.newComment = '';
      this.replyTo = null;
    }
  }

  // 构建评论项UI
  @Builder
  CommentItem(comment: Comment, isLastReply: boolean = false) {
    Column() {
      Row() {
        Image(comment.avatar)
          .width(comment.isReply ? STYLES.ICON_SIZE.MEDIUM : STYLES.ICON_SIZE.LARGE)
          .height(comment.isReply ? STYLES.ICON_SIZE.MEDIUM : STYLES.ICON_SIZE.LARGE)
          .borderRadius(comment.isReply ? STYLES.ICON_SIZE.MEDIUM / 2 : STYLES.ICON_SIZE.LARGE / 2)
          .margin({ right: STYLES.SPACING.MEDIUM, left: comment.isReply ? STYLES.SPACING.LARGE : 0 })

        Column() {
          Row() {
            Text(comment.author)
              .fontSize(comment.isReply ? STYLES.FONT_SIZE.MEDIUM : STYLES.FONT_SIZE.LARGE)
              .fontWeight(FontWeight.Medium)
            
            if (comment.parentAuthor) {
              Text(' 回复 ')
                .fontSize(comment.isReply ? STYLES.FONT_SIZE.MEDIUM : STYLES.FONT_SIZE.LARGE)
                .fontColor(STYLES.COLORS.DARK_GRAY)
              Text(`@${comment.parentAuthor}`)
                .fontSize(comment.isReply ? STYLES.FONT_SIZE.MEDIUM : STYLES.FONT_SIZE.LARGE)
                .fontColor(STYLES.COLORS.SECONDARY)
            }
            
            Text(comment.time)
              .fontSize(STYLES.FONT_SIZE.SMALL)
              .fontColor(STYLES.COLORS.GRAY)
              .margin({ left: STYLES.SPACING.SMALL })
          }
          .alignItems(VerticalAlign.Center)

          Text(comment.content)
            .fontSize(comment.isReply ? STYLES.FONT_SIZE.MEDIUM : STYLES.FONT_SIZE.LARGE)
            .margin({ top: STYLES.SPACING.SMALL })

          Row() {
            Row() {
              Image($r('app.media.ic_like'))
                .width(STYLES.ICON_SIZE.SMALL)
                .height(STYLES.ICON_SIZE.SMALL)
                .fillColor(comment.isLiked ? STYLES.COLORS.PRIMARY : STYLES.COLORS.GRAY)
              Text(comment.likes.toString())
                .fontSize(STYLES.FONT_SIZE.SMALL)
                .fontColor(comment.isLiked ? STYLES.COLORS.PRIMARY : STYLES.COLORS.GRAY)
                .margin({ left: STYLES.SPACING.SMALL })
            }
            .onClick(() => {
              this.handleLike(comment);
            })

            Row() {
              Image($rawfile('Default/reply_default.png'))
                .width(STYLES.ICON_SIZE.SMALL)
                .height(STYLES.ICON_SIZE.SMALL)
              Text('回复')
                .fontSize(STYLES.FONT_SIZE.SMALL)
                .fontColor(STYLES.COLORS.GRAY)
                .margin({ left: STYLES.SPACING.SMALL })
            }
            .margin({ left: STYLES.SPACING.MEDIUM })
            .onClick(() => {
              this.handleReply(comment);
            })
          }
          .margin({ top: STYLES.SPACING.SMALL })
        }
        .layoutWeight(1)
      }
      .width('100%')
      .padding(STYLES.SPACING.MEDIUM)
      .margin({ bottom: comment.isReply ? 0 : STYLES.SPACING.SMALL })
      .borderRadius(STYLES.SPACING.SMALL)
    }
    .width('100%')
    .backgroundColor(STYLES.COLORS.WHITE)
    .padding({ left: comment.isReply ? STYLES.ICON_SIZE.LARGE : 0 })
    .margin({ bottom: isLastReply ? STYLES.SPACING.SMALL : 0 })
  }

  // 页面显示时的生命周期函数
  onPageShow() {
    // 只在需要刷新数据时重新初始化
    if (this.isInitialized) {
      this.initializeComments();
    }
  }

  // 构建页面UI
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
        Text('评论')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .margin({ left: 16 })
        Text(this.comments.length.toString())
          .fontSize(16)
          .fontColor('#999999')
          .margin({ left: 8 })
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#FFFFFF')

      // 评论列表
      List({ scroller: this.listController }) {
        ForEach(this.comments.filter(c => !c.isReply), (comment: Comment) => {
          ListItem() {
            Column() {
              this.CommentItem(comment)
              
              if (this.showReplies.has(comment.id)) {
                Column() {
                  // 收起按钮
                  if (this.getReplies(comment.id).length > 0) {
                    Row() {
                      Text('收起')
                        .fontSize(12)
                        .fontColor('#007DFF')
                        .margin({ left: 16 })
                    }
                    .width('100%')
                    .padding({ left: 56, right: 16, top: 8, bottom: 8 })
                    .backgroundColor('#FFFFFF')
                    .borderRadius({ topLeft: 8, topRight: 8 })
                    .onClick(() => {
                      this.handleToggleReplies(comment.id);
                    })
                  }

                  // 回复列表
                  ForEach(this.getReplies(comment.id), (reply: Comment, index: number) => {
                    Column() {
                      this.CommentItem(reply, index === this.getReplies(comment.id).length - 1)
                      if (index < this.getReplies(comment.id).length - 1) {
                        Divider()
                          .color('#EEEEEE')
                          .height(1)
                          .margin({ left: 56, right: 16 })
                      }
                    }
                  })
                }
                .backgroundColor('#FFFFFF')
                .borderRadius(8)
                .margin({ top: -8, bottom: 8 })
              } else if (this.getReplies(comment.id).length > 0) {
                // 展开按钮
                Row() {
                  Text(`展开${this.getReplies(comment.id).length}条回复`)
                    .fontSize(12)
                    .fontColor('#007DFF')
                    .margin({ left: 16 })
                }
                .width('100%')
                .padding({ left: 56, right: 16, top: 8, bottom: 8 })
                .backgroundColor('#FFFFFF')
                .borderRadius(8)
                .margin({ top: -8, bottom: 8 })
                .onClick(() => {
                  this.handleToggleReplies(comment.id);
                })
              }
            }
          }
        })
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor('#F5F5F5')

      // 底部评论输入框
      Column() {
        if (this.replyTo) {
          Row() {
            Text(`回复 ${this.replyTo.author}:`)
              .fontSize(14)
              .fontColor('#666666')
            Text(this.replyTo.content)
              .fontSize(14)
              .fontColor('#999999')
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
            Image($rawfile('Default/Disable_Comments.png'))
              .width(16)
              .height(16)
              .margin({ left: 8 })
              .onClick(() => {
                this.replyTo = null;
              })
          }
          .width('100%')
          .padding({ left: 16, right: 16, top: 8, bottom: 8 })
          .backgroundColor('#F5F5F5')
        }

        Row() {
          TextInput({ placeholder: this.replyTo ? '回复评论...' : '说点什么...', text: this.newComment })
            .height(40)
            .backgroundColor('#F5F5F5')
            .borderRadius(20)
            .padding({ left: 16, right: 16 })
            .layoutWeight(1)
            .onChange((value: string) => {
              this.newComment = value;
            })

          Button('发送')
            .height(40)
            .width(64)
            .margin({ left: 12 })
            .backgroundColor('#FF2D55')
            .borderRadius(20)
            .onClick(() => {
              this.sendComment();
            })
        }
        .width('100%')
        .padding(16)
      }
      .width('100%')
      .backgroundColor('#FFFFFF')
    }
  }
} 
