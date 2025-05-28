// TrendingContent.ets
import router from '@ohos.router';
import { TrendingContentList } from '../viewmodel/TrendingContentList';
import TrendingItem from '../model/TrendingItem';
import defaultFilter from '../model/defaultFilter';

@Entry
@Component
export default struct TrendingContent {
  @State currentFilter: string = 'all'

  aboutToAppear() {
    const params = JSON.stringify(router.getParams()) ;
    const paramsObject = JSON.parse(params) as defaultFilter;
    this.currentFilter = paramsObject.defaultFilter as string;   // 获取传递过来的默认分类
    console.log('TrendingContent aboutToAppear', paramsObject);
  }


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
            Text(this.getFilterName(filter))  // 标签
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


      // 内容网格
      Grid() {
        ForEach(TrendingContentList.filter(item =>    // 应该从viewModel过滤获取数据
          item.category === this.currentFilter || this.currentFilter === 'all'
        ), (item: TrendingItem) => {
          GridItem() {
            Column() {
              // 缩略图区域
              Stack() {
                Image(item.thumbnail)   // 音视频缩放图
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
                Column() {      // 如果是音乐则显示音乐播放图标，如果是视频则显示视频播放图标
                  Image(item.category === 'music' ? $r('app.media.note'): $r('app.media.play')) // 只有音乐和视频，通过三目判断
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
                .onClick(() => {
                  if(item.category === 'music')    // 如果是音乐则跳转到音乐播放页面，如果是视频则跳转到视频播放页面
                  router.pushUrl({
                    url: 'Discover/pages/Music',
                    params: item  // 传递音乐信息
                  })
                })

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
                Text(item.title)    // 视频标题
                  .fontSize(14)
                  .fontColor(Color.White)
                  .maxLines(2)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .margin({ bottom: 5 })

                Row() {
                  Text(item.likes)  // 点赞数
                    .fontColor(Color.White)
                    .fontSize(12)
                    .margin({ right: 10 })
                  Text(item.comments)
                    .fontColor(Color.White)
                    .fontSize(12)
                }
                .margin({ bottom: 5 })

                Row() {
                  Image(item.avatar)  // 作者头像
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
          }
          .padding(5)
        }
        )}
      .columnsTemplate('1fr 1fr')   // 两列等宽
      .columnsGap(5)    // 列与列之间的间距
      .rowsGap(5)      // 行与行之间的间距
      .padding(10)
      .width('100%')
      .layoutWeight(1)    // 占满剩余空间
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.Black)
  }
}

