import { router } from '@kit.ArkUI'
import { users } from '../model/UserModel'
import User from "../viewmodel/UserItem"
// creators_all.ets
@Entry
@Component
struct CreatorsAll {
  @State currentFilter: string = 'all'
  private getFilterName(filter: string): string {
    const filterMap: Record<string, string> = {
      'all': '全部',
      'music': '音乐',
      'dance': '舞蹈',
      'food': '美食',
      'travel': '旅行',
      'comedy': '搞笑',
      'fitness': '健身'
    }
    return filterMap[filter] || filter
  }

  build() {
    Column() {
      // 头部
      Row() {
        Image($r('app.media.back'))
          .width(30)
          .margin({ left: 10 })
          .onClick(()=>{
            router.back()
          })
        Text('热门创作者')
          .margin({ right: 10 })
          .fontColor(Color.White)
          .fontSize(16)
          .fontWeight(800)
      }
      .width('100%')
      .height(50)
      .justifyContent(FlexAlign.SpaceBetween)

      // 筛选标签
      Scroll() {
        Row() {
          ForEach(['all', 'music', 'dance', 'food', 'travel', 'comedy', 'fitness'], (item:string) => {
            Text(this.getFilterName(item))
              .fontSize(14)
              .fontColor(Color.White)
              .padding({ left: 16, right: 16, top: 8, bottom: 8 })
              .borderRadius(20)
              .backgroundColor(this.currentFilter === item ? '#FF0050' : '#ff5a5a5a')
              .margin({ right: 15 })
              .onClick(() => {
                this.currentFilter = item
              })
          })
        }
        .padding({ left: 15, right: 15, top: 10, bottom: 10 })
      }
      .scrollable(ScrollDirection.Horizontal)
      .width('100%')
      .height(48)
      // .border({ bottom: { width: 1, color: '#333333' } })

      // 创作者网格
      Grid() {
        ForEach(users.filter(creator =>
        this.currentFilter === 'all' || creator.category === this.currentFilter
        ), (creator:User) => {
          GridItem() {
            Column() {
              // 头像
              Image(creator.avatar)
                .width(80)
                .height(80)
                .borderRadius(40)
                .border({ width: 2, color: '#FF0050' })
                .margin({ bottom: 10 })

              // 创作者信息
              Text(creator.name)
                .fontSize(16)
                .fontColor(Color.White)
                .fontWeight(FontWeight.Bold)
                .margin({ bottom: 5 })

              // 统计数据
              Row() {
                Text(creator.fans)
                  .fontSize(12)
                  .fontColor(Color.White)
                  .opacity(0.8)
                Text('·')
                  .fontSize(12)
                  .fontColor(Color.White)
                  .opacity(0.8)
                  .margin({ left: 10, right: 10 })
                Text(creator.videos)
                  .fontSize(12)
                  .fontColor(Color.White)
                  .opacity(0.8)
              }
              .justifyContent(FlexAlign.Center)
              .margin({ bottom: 10 })

              // 描述
              Text(creator.description)
                .fontSize(12)
                .fontColor(Color.White)
                .opacity(0.7)
                .maxLines(2)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
                .margin({ bottom: 10 })

              // 标签
              Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Center }) {
                ForEach(creator.tags, (tag:string) => {
                  Text(tag)
                    .fontSize(10)
                    .fontColor(Color.White)
                    .padding({ left: 8, right: 8, top: 3, bottom: 3 })
                    .backgroundColor('#ff5a5a5a')
                    .borderRadius(10)
                    .margin({ right: 5, bottom: 5 })
                })
              }

              // 关注按钮
              Button(creator.followed ? '已关注' : '关注')
                .width(80)
                .height(30)
                .fontSize(12)
                .fontWeight(FontWeight.Bold)
                .backgroundColor(creator.followed ?  '#ff5a5a5a':'#FF0050')
                .border({
                  width: creator.followed ? 1 : 0,
                  color: '#FF0050'
                })
                .borderRadius(15)
                .margin({ top: 10 })
                .onClick(() => {
                  creator.followed = !creator.followed
                })
            }
            .width('100%')
            .height(280)
            .padding(15)
            .backgroundColor('#1A1A1A')
            .borderRadius(12)
            .onClick(() => {
              router.pushUrl({
                url: 'pages/profile_creator',
                params: { id: creator.id.toString() }
              })
            })
          }
        }
        )}
      .columnsTemplate('1fr 1fr')
      .columnsGap(15)
      .rowsGap(15)
      .width('100%')
      .height('100%')
      .padding(15)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#000000')
  }
}
