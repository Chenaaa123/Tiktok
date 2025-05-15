import { Prompt } from '@kit.ArkUI';
import NotificationList from '../viewmodel/NotificationList';
import NotificationItem from '../view/NotificationItem';

@Component
export default struct NotificationsPage {

  build() {
    Column() {
      // 今天
      Row() {
        Text('今天')
          .fontSize(16)
          .fontColor('#fff')
          .fontWeight(FontWeight.Bold)
          .margin({left: 10, right: 10 })
        Blank().layoutWeight(1)
        Text('清空')
          .fontSize(14)
          .fontColor('#E6E6E6')
          .onClick(() => {
            Prompt.showToast({ message: '清空成功' })
          })
          .margin({left: 10, right: 10 })
      }
      .width('100%')
      .margin({left: 8, right: 8 })
      // 通知项
      ForEach(NotificationList, (item: NotificationItem) => {
        Row() {
          Image($r("app.media.profilePicture"))
            .width(48)
            .height(48)
            .borderRadius(24)
            .margin({ left: 10, right: 10 })
          Column() {
            Row() {
              Text(item.type)
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
          }
          .layoutWeight(1)
        }
        .width('100%')
        .margin({ top: 8, bottom: 8, left: 8, right: 8 })
      })
    }
    .width('100%')
  }
}