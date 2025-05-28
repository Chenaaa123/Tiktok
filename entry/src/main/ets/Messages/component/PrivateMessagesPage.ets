import PrivateMessageItem from '../model/PrivateMessageItem'; // 私信数据模型
import PrivateMessageList from '../viewmodel/PrivateMessageList'; // 私信列表视图模型
import { router } from '@kit.ArkUI';
import { AvatarManager } from '../model/AvatarManager';

/**
 * 私信页面组件 - 展示私信会话列表
 */
@Entry
@Component
export default struct PrivateMessagesPage {
  @Prop messages: PrivateMessageItem[] = PrivateMessageList; // 添加属性接收消息列表

  /**
   * 构建私信页面UI结构
   */
  build() {
    // 可滚动容器 - 包含所有私信会话
    Scroll() {
      // 垂直列布局 - 排列所有会话项
      Column() {
        // 循环渲染组件 - 为每个会话项生成UI
        ForEach(this.messages, (item: PrivateMessageItem) => {
          // 单个会话项容器
          Row() {
            // 头像点击事件只跳转到聊天页面
            Image(AvatarManager.getUserAvatar(item.id))
              .width(48)
              .height(48)
              .borderRadius(24)
              .margin({ left: 12, right: 12 })
              .onClick(() => {
                router.pushUrl({url:"Messages/pages/ChatPage"})
              })

            // 会话内容容器
            Column() {
              // 会话标题行 - 显示用户名和消息时间
              Row() {
                Text(item.name) // 用户名
                  .fontSize(16)
                  .fontColor('#FFFF')
                  .layoutWeight(1)

                Text(item.time) // 消息时间
                  .fontSize(12)
                  .fontColor('#999999')
              }
              .width('100%')
              .onClick(() => {
                router.pushUrl({url:"Messages/pages/ChatPage"})
              })

              // 会话内容行 - 显示最新消息和未读计数
              Row() {
                Text(item.msg) // 最新消息内容
                  .fontSize(14)
                  .fontColor('#B2B2B2')
                  .maxLines(1)
                  .layoutWeight(1)

                // 未读消息计数 - 当有未读消息时显示
                if (item.unread > 0) {
                  Text(item.unread.toString())
                    .fontSize(12)
                    .fontColor('#FFFF')
                    .backgroundColor('#FF0000') // 红色背景
                    .borderRadius(8) // 圆角
                    .padding({ left: 6, right: 6, top: 2, bottom: 2 })
                    .margin({ left: 8 })
                }
              }
              .width('100%')
              .margin({ top: 4 })
              .onClick(() => {
                router.pushUrl({url:"Messages/pages/ChatPage"})
              })
            }
            .layoutWeight(1)

          }
          .width('100%')
          .height(72)
          .border({ width: 0.5, color: '#333333' }) // 底部边框分隔线
          .padding({ top: 8, bottom: 8 })
          .backgroundColor('#00000')
        })
      }
    }
    .width('100%')
  }
}