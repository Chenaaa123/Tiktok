// TrendingContent.ets
import router from '@ohos.router';
import { TrendingContentList } from '../model/TrendingContentList';
import TrendingItem from '../viewmodel/TrendingItem';

@Entry
@Component
struct TrendingContent {
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
      // 顶部导航栏
      Row() {
        Image($r('app.media.back'))
          .width(30)
          .margin({ left: 10 })
          .onClick(()=>{
            router.back()
          })
        Text('热门内容')
          .margin({ right: 10 })
          .fontColor(Color.White)
          .fontSize(16)
          .fontWeight(800)
      }
      .width('100%')
      .height(50)
      .justifyContent(FlexAlign.SpaceBetween)

      // 过滤标签
      Scroll() {
        Row() {
          ForEach(['all', 'music', 'dance', 'food', 'travel', 'comedy', 'fitness'], (filter :string) => {
            Text(this.getFilterName(filter))
              .fontSize(14)
              .fontColor(Color.White)
              .padding({ left: 16, right: 16, top: 8, bottom: 8 })
              .borderRadius(20)
              .backgroundColor(this.currentFilter === filter ? '#FF0050' : '#333333')
              .margin({ right: 15 })
              .onClick(() => {
                this.currentFilter = filter
              })
          })
        }
        .padding({ left: 16, right: 16, top: 10, bottom: 10 })
      }
      .scrollable(ScrollDirection.Horizontal)
      .width('100%')
      .height(48)
      // .border({ bottom: { width: 1, color: '#FFFFFF20' } })

      // 内容网格
      Grid() {
        ForEach(TrendingContentList.filter(item =>
        this.currentFilter === 'all' || item.category === this.currentFilter
        ), (item: TrendingItem) => {
          GridItem() {
            Column() {
              // 缩略图区域
              Stack() {
                Image(item.thumbnail)
                  .width('100%')
                  .aspectRatio(1)
                  .objectFit(ImageFit.Cover)
                  .borderRadius(12)

                // 分类标签
                Text(this.getFilterName(item.category))
                  .fontSize(11)
                  .fontColor(Color.White)
                  .fontWeight(FontWeight.Medium)
                  .padding({
                    left: 8,
                    right: 8,
                    top: 3,
                    bottom: 3
                  })
                  .backgroundColor('#FF0050')
                  .borderRadius(4)
                  .position({ x: 10, y: 10 })

                // 播放按钮
                Column() {
                  Image(item.category === 'music' ? $r('app.media.note'): $r('app.media.play'))
                    .width(30)
                    .height(30)
                    .opacity(8)
                }
                .width(40)
                .height(40)
                .borderRadius(20)
                .backgroundColor('#00000080')
                .justifyContent(FlexAlign.Center)
                .alignItems(HorizontalAlign.Center)
                .position({ x: '50%', y: '50%' })
                .translate({ x: -20, y: -20 })

                // 时长
                Text(item.duration)
                  .fontSize(11)
                  .padding({
                    left: 6,
                    right: 6,
                    top: 3,
                    bottom: 3
                  })
                  .fontColor(Color.White)
                  .backgroundColor('#000000B3')
                  .borderRadius(4)
                  .position({ x: '80%', y: '80%' })
              }
              .width('100%')
              .aspectRatio(1)

              // 视频信息
              Column() {
                Text(item.title)
                  .fontSize(14)
                  .fontColor(Color.White)
                  .maxLines(2)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .margin({ bottom: 5 })

                Row() {
                  Text(item.likes)
                    .fontColor(Color.White)
                    .fontSize(12)
                    .margin({ right: 10 })
                  Text(item.comments)
                    .fontColor(Color.White)
                    .fontSize(12)
                }
                .margin({ bottom: 5 })

                Row() {
                  Image(item.avatar)
                    .width(20)
                    .height(20)
                    .borderRadius(10)
                    .margin({ right: 5 })
                  Text(item.author)
                    .fontColor(Color.White)
                    .fontSize(12)
                }
                .alignItems(VerticalAlign.Center)
              }
              .padding(10)
              .width('100%')
            }
            .width('100%')
            .backgroundColor('#ff1d181d')
            .borderRadius(12)
            .onClick(() => {
              router.pushUrl({
                url: 'pages/VideoPlayer',
                params: { id: item.id.toString() }
              })
            })
          }
          .padding(5)
        }
        )}
      .columnsTemplate('1fr 1fr')
      .columnsGap(5)
      .rowsGap(5)
      .padding(10)
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#000000')
  }
}

