import { Prompt } from '@kit.ArkUI'; // 引入提示组件（用于Toast提示）
// import NotificationList from '../viewmodel/NotificationList'; // 通知列表视图模型
import NotificationItem from '../model/NotificationItem'; // 通知项数据模型
import { AvatarManager } from '../model/AvatarManager';
import { NotificationList } from '../viewmodel/NotificationList';

/**
 * 通知页面组件 - 展示系统通知列表
 */
@Component
export default struct NotificationsPage {

  /**
   * 构建通知页面UI
   */
  build() {
    Column() {
      // 头部操作栏 - 显示日期和清空功能
      Row() {
        Text('今天')
          .fontSize(16)
          .fontColor('#fff')
          .fontWeight(FontWeight.Bold)
          .margin({ left: 10, right: 10 })

        Blank().layoutWeight(1) // 水平占位空间，使内容右对齐

        Text('清空') // 清空按钮
          .fontSize(14)
          .fontColor('#E6E6E6')
          .onClick(() => {
            Prompt.showToast({ message: '清空成功' })
          })
          .margin({ left: 10, right: 10 })
      }
      .width('100%')
      .margin({ left: 8, right: 8 })

      // 通知列表 - 循环渲染每条通知
      ForEach(NotificationList, (item: NotificationItem) => {
        // 单条通知卡片
        Row() {
          Image(AvatarManager.getUserAvatar(item.id))
            .width(48)
            .height(48)
            .borderRadius(24) // 圆形头像
            .margin({ left: 10, right: 10 })

          // 通知内容区域
          Column() {
            // 通知类型和内容行
            Row() {
              Text(item.type) // 通知类型（如点赞、评论）
                .fontSize(14)
                .fontColor('#E6E6E6')
                .fontWeight(FontWeight.Bold)

              Text(item.content) // 通知具体内容
                .fontSize(14)
                .fontColor('#fff')
                .margin({ left: 4 })
            }
            .width('100%')

            // 通知时间行
            Row() {
              Text(item.time) // 时间戳
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