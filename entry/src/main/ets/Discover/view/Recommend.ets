import DividerTmp from "../model/DividerTmpModel"
import { recommendList } from "../model/RecommendList"
import { users } from "../model/UserModel"
import RecommendItem from "../viewmodel/RecommendListItem"
import User from "../viewmodel/UserItem"

// 推荐
@Component
export default struct Recommend {
  @State egDivider: DividerTmp = new DividerTmp(0.5, 10, 10, '#ff373737')
  build() {
    Column(){
      // 正在流行
      Row() {
        Text('正在流行')
          .margin({ left: 10 })
          .fontColor(Color.White)
          .fontSize(16)
          .fontWeight(800)
        Text('查看全部')
          .margin({ right: 10 })
          .fontColor(Color.White)
          .fontSize(12)
          .fontWeight(400)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Row() {
        Stack({ alignContent: Alignment.BottomStart }) {
          Image($r('app.media.pexels'))
            .width(170)
            .height(170)
            .margin({ left: 5 })
            .objectFit(ImageFit.Cover)
            .borderRadius(20)
          Column() {
            Text('热门街舞视频')
              .fontSize(16)
              .fontColor(Color.White)
              .margin({ left: 10, bottom: 5 })
              .fontWeight(800)
            Text('10.2万次播放')
              .fontSize(12)
              .fontColor(Color.White)
              .margin({ bottom: 10 ,left: 10})
          }.alignItems(HorizontalAlign.Start)
        }

        Stack({ alignContent: Alignment.BottomStart }) {
          Image($r('app.media.rock'))
            .width(170)
            .height(170)
            .margin({ right: 5 })
            .objectFit(ImageFit.Cover)
            .borderRadius(20)
          Column() {
            Text('热门音乐榜单')
              .fontSize(16)
              .fontWeight(800)
              .fontColor(Color.White)
              .margin({ left: 10, bottom: 5 })
            Text('10.2万次播放')
              .fontSize(12)
              .fontColor(Color.White)
              .margin({ bottom: 10 ,left: 10})
          }.alignItems(HorizontalAlign.Start)
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ bottom: 20, top: 15 })

      // 热门创作者
      Row() {
        Text('热门创作者')
          .margin({ left: 10 })
          .fontColor(Color.White)
          .fontSize(16)
          .fontWeight(800)
        Text('查看全部')
          .margin({ right: 10 })
          .fontColor(Color.White)
          .fontSize(12)
          .fontWeight(400)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Row() {
        ForEach(users, (user: User) => {
          Column() {
            Image(user.avatar)
              .width(60)
              .height(60)
              .borderRadius(30)
              .margin({ bottom: 8 })

            Text(user.username)
              .fontSize(12)
              .fontWeight(500)
              .fontColor('#333333')
              .fontColor(Color.White)
          }
          .margin({ right: 20 })
        })
      }
      .width('100%')
      .padding({ left: 10 })
      .margin({ bottom: 20, top: 10 })

      // 为你推荐
      Row() {
        Text('为你推荐')
          .margin({ left: 10 })
          .fontColor(Color.White)
          .fontSize(16)
          .fontWeight(800)
        Text('刷新')
          .margin({ right: 10 })
          .fontColor(Color.White)
          .fontSize(12)
          .fontWeight(400)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      // 推荐列表
      List() {
        ForEach(recommendList, (item: RecommendItem, index?: number) => {
          ListItem() {
            Row() {
              Image(item.coverImage)
                .width(120)
                .height(80)
                .borderRadius(8)
                .margin({ right: 12 })
                .objectFit(ImageFit.Cover) // 添加图片填充模式

              Column({space:20}) {
                Text(item.title)
                  .fontSize(14)
                  .fontWeight(800)
                  .margin({ bottom: 6 })
                  .maxLines(2)// 限制标题行数
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .fontColor(Color.White)
                Row(){
                  Text(item.author.username)
                    .fontSize(12)
                    .opacity(0.8)
                    .fontColor(Color.White)
                  Text(`·${item.viewCount}次播放`)
                    .fontSize(12)
                    .opacity(0.8)
                    .fontColor(Color.White)
                }

              }
              .alignItems(HorizontalAlign.Start)
              .justifyContent(FlexAlign.Center) // 垂直居中
              .layoutWeight(1)
            }
            .width('100%')
            .padding(12)
          }
          .borderRadius(12) // 列表项圆角
          .margin({ top: index === 0 ? 0 : 8 }) // 第一个项不加顶部边距
        }, (item: RecommendItem) => item.id.toString()) // 添加key生成器
        /*通过唯一id（如item.id）生成key，能保证即使有相同内容的项，key也不会重复。
         直接使用索引（index）作为key在数据变化时可能产生冲突*/
      }
      .divider(this.egDivider)
      .width('100%')
      .height(250)
      .scrollBar(BarState.Auto)
    }
    .height('100%')
  }
}
