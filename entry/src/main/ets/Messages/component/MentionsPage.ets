import { Mention } from '../model/interfaces';

/**
 * @提及页面组件 - 展示被@用户的消息列表
 */
@Component
export default struct MentionsPage {
  // 存储@提及消息列表的状态
  @State mentions: Mention[] = [];

  /**
   * 构建@提及页面UI
   */
  build() {
    // 空状态处理 - 当没有@消息时显示
    if (this.mentions.length === 0) {
      Column() {
        Blank().layoutWeight(1) // 顶部占位空间

        // 空状态内容区域
        Column() {
          Text('@') // 大@符号图标
            .fontSize(80)
            .fontColor('#fff')
            .margin({ bottom: 16 })

          Text('暂无@提及')
            .fontSize(24)
            .fontColor('#fff')
            .fontWeight(FontWeight.Bold)
            .margin({ bottom: 12 })

          Text('当有人@你时，会显示在这里')
            .fontSize(16)
            .fontColor('#B2B2B2')
        }
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Center)

        Blank().layoutWeight(1) // 底部占位空间
      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Center)
      .backgroundColor('#000000')

    } else {
      // 显示@消息列表
      Column() {
        // 页面标题
        Text('@提及')
          .fontSize(20)
          .fontColor('#fff')
          .fontWeight(FontWeight.Bold)
          .margin({ left: 16, top: 16, bottom: 16 })

        // 可滚动的消息列表容器
        Scroll() {
          Column() {
            // 循环渲染每条@消息
            ForEach(this.mentions, (item: Mention) => {
              // 单条@消息卡片
              Row() {
                Image($r("app.media.profilePicture")) // 用户头像
                  .width(48)
                  .height(48)
                  .borderRadius(24)
                  .margin({ left: 12, right: 12 })

                // 消息内容区域
                Column() {
                  Text(item.user) // 发送者用户名
                    .fontSize(16)
                    .fontColor('#FFFFFF')

                  Text(item.content) // 消息内容
                    .fontSize(14)
                    .fontColor('#B2B2B2')
                    .margin({ top: 4 })
                }
                .layoutWeight(1)

                Text(item.time) // 消息时间戳
                  .fontSize(12)
                  .fontColor('#999999')
              }
              .width('100%')
              .height(72)
              .border({ width: 0.5, color: '#333333' }) // 分隔线
              .padding({ top: 8, bottom: 8 })
              .backgroundColor('#000000')
            })
          }
        }
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#000000')
    }
  }
}