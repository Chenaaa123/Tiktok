import LikeItem from '../model/LikeItem';
import { AvatarManager } from '../model/AvatarManager';
import { router } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';
import { LikeList } from '../viewmodel/LikeList';

/**
 * 评论页面组件 - 展示用户评论列表
 */
@Component
export default struct CommentsPage {

  /**
   * 构建评论页面UI结构
   */
  build() {
    // 可滚动容器 - 包含所有评论内容
    Scroll() {
      // 垂直列布局 - 排列所有评论项
      Column() {
        // 为每个评论项生成UI
        ForEach(LikeList, (item: LikeItem) => {
          // 单个评论项容器
          Row() {
            // 添加头像点击事件
            Image(AvatarManager.getUserAvatar(item.id))
              .width(48)
              .height(48)
              .borderRadius(24)
              .margin({ left: 12, right: 12 })
              .onClick(() => {
                router.pushUrl({
                  url: 'Messages/pages/UserProfile',
                  params: {
                    id: item.id,
                    name: item.user
                  }
                }).then(() => {
                  console.info('跳转到用户主页成功');
                }).catch((err: BusinessError) => {
                  console.error(`跳转失败: ${err.code}, ${err.message}`);
                });
              })

            // 评论内容容器
            Column() {
              // 显示用户名和评论类型
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

              // 评论时间
              Row() {
                Text(item.time)
                  .fontSize(12)
                  .fontColor('#999999')
              }
              .width('100%')

              // 评论内容气泡组件
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