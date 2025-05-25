import router from '@ohos.router';

interface Comment {
  id: string;
  author: string;
  avatar: string;
  content: string;
  time: string;
  likes: number;
}

interface CommentsPageParams {
  videoId: string;
}

@Entry
@Component
struct CommentsPage {
  @State comments: Comment[] = [
    {
      id: 'c1',
      author: '舞蹈爱好者',
      avatar: 'app.media.avatar_1',
      content: '太精彩了！动作非常到位',
      time: '2分钟前',
      likes: 128
    },
    {
      id: 'c2',
      author: '音乐制作人',
      avatar: 'app.media.avatar_2',
      content: '配乐很棒，节奏感很强',
      time: '5分钟前',
      likes: 56
    }
  ];
  @State newComment: string = '';
  private videoId: string = (router.getParams() as CommentsPageParams)?.videoId || '';

  @Builder
  CommentItem(comment: Comment) {
    Row() {
      Image(comment.avatar)
        .width(40)
        .height(40)
        .borderRadius(20)

      Column() {
        Row() {
          Text(comment.author)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
          Text(comment.time)
            .fontSize(12)
            .fontColor('#999999')
            .margin({ left: 8 })
        }

        Text(comment.content)
          .fontSize(14)
          .margin({ top: 4 })

        Row() {
          Row() {
            Image($r('app.media.ic_like'))
              .width(16)
              .height(16)
            Text(comment.likes.toString())
              .fontSize(12)
              .fontColor('#999999')
              .margin({ left: 4 })
          }
          .onClick(() => {
            comment.likes += 1;
          })

          Row() {
            Image($rawfile('Default/reply_default.png'))
              .width(16)
              .height(16)
            Text('回复')
              .fontSize(12)
              .fontColor('#999999')
              .margin({ left: 4 })
          }
          .margin({ left: 16 })
        }
        .margin({ top: 8 })
      }
      .layoutWeight(1)
      .margin({ left: 12 })
    }
    .width('100%')
    .padding(16)
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
      List() {
        ForEach(this.comments, (comment: Comment) => {
          ListItem() {
            this.CommentItem(comment)
          }
        })
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor('#F5F5F5')

      // 底部评论输入框
      Row() {
        TextInput({ placeholder: '说点什么...', text: this.newComment })
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
            if (this.newComment.trim()) {
              this.comments.unshift({
                id: `c${this.comments.length + 1}`,
                author: '我',
                avatar: 'app.media.avatar_1',
                content: this.newComment,
                time: '刚刚',
                likes: 0
              });
              this.newComment = '';
            }
          })
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFFFFF')
    }
  }
} 