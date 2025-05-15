
import PrivateMessageItem from '../view/PrivateMessageItem';
import PrivateMessageList from '../viewmodel/PrivateMessageList';

@Component
export default struct PrivateMessagesPage {


  build() {
    Scroll() {
      Column() {
        ForEach(PrivateMessageList, (item: PrivateMessageItem) => {
          Row() {
            Image($r("app.media.profilePicture"))
              .width(48)
              .height(48)
              .borderRadius(24)
              .margin({ left: 12, right: 12 })
            Column() {
              Row() {
                Text(item.name)
                  .fontSize(16)
                  .fontColor('#FFFF')
                  .layoutWeight(1)
                Text(item.time)
                  .fontSize(12)
                  .fontColor('#999999')
              }
              .width('100%')
              Row() {
                Text(item.msg)
                  .fontSize(14)
                  .fontColor('#B2B2B2')
                  .maxLines(1)
                  .layoutWeight(1)
                if (item.unread > 0) {
                  Text(item.unread.toString())
                    .fontSize(12)
                    .fontColor('#FFFF')
                    .backgroundColor('#FF0000')
                    .borderRadius(8)
                    .padding({ left: 6, right: 6, top: 2, bottom: 2 })
                    .margin({ left: 8 })
                }
              }
              .width('100%')
              .margin({ top: 4 })
            }
            .layoutWeight(1)
          }
          .width('100%')
          .height(72)
          .border({ width: 0.5, color: '#333333' })
          .padding({ top: 8, bottom: 8 })
          .backgroundColor('#00000')
        })
      }
    }
    .width('100%')
  }
}