
import LikeItem from '../model/LikeItem';
import LikeList from '../modelview/LikeList';

@Component
export default struct CommentsPage {


  build() {
    Scroll() {
      Column() {
        ForEach(LikeList, (item: LikeItem) => {
          Row() {
            Image($r('app.media.profilePicture'))
              .width(48)
              .height(48)
              .borderRadius(24)
              .margin({ left: 12, right: 12 })
            Column() {
              Row() {
                Text(item.user)
                  .fontSize(14)
                  .fontColor('#E6E6E6')
                  .fontWeight(FontWeight.Bold)
                Text(item.content)
                  .fontSize(14)
                  .fontColor('#fff')
                  .margin({ left: 4 })
              }
              .width('100%')
              Row() {
                Text(item.time)
                  .fontSize(12)
                  .fontColor('#999999')
              }
              .width('100%')
              // 评论内容气泡
              if (item.id === 1) {
                Row() {
                  Text('这个动作编排真不错，我很喜欢！')
                    .fontSize(14)
                    .fontColor('#fff')
                    .backgroundColor('#232323')
                    .borderRadius(8)
                    .padding({ left: 12, right: 12, top: 8, bottom: 8 })
                }
                .width('100%')
                .margin({ top: 8 })
              } else if (item.id === 2) {
                Row() {
                  Text('真漂亮，是在哪里拍的?')
                    .fontSize(14)
                    .fontColor('#fff')
                    .backgroundColor('#232323')
                    .borderRadius(8)
                    .padding({ left: 12, right: 12, top: 8, bottom: 8 })
                }
                .width('100%')
                .margin({ top: 8 })
              }
            }
            .layoutWeight(1)
          }
          .width('100%')
          .margin({ top: 8, bottom: 8 })
        })
      }
    }
    .width('100%')
  }
}