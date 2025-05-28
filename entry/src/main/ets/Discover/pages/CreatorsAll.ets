import { router } from '@kit.ArkUI'
import { CreatorList } from '../viewmodel/CreatorList'
import CreatorItem from "../model/CreatorItem"


// creators_all.ets
PersistentStorage.persistProp("persistedMapString", new Map<number, string>([]));

@Entry
@Component
struct CreatorsAll {
  @State currentFilter: string = 'all'
  @State animationStates: Map<string, boolean> = new Map()
  @State attentionList: Array<CreatorItem> = []
  @StorageLink("persistedMapString") persistedMapString: Map<number, string> = new Map<number, string>([]); // 持久化关注粉丝列表

  private getFilterName(filter: string): string { // 获取筛选标签名称
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
          .onClick(() => {
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
      Scroll() { // 除除顶部标签，其余部分为滚动区域
        Row() {
          ForEach(['all', 'music', 'dance', 'food', 'travel', 'comedy', 'fitness'], (item: string) => {
            Text(this.getFilterName(item))
              .fontSize(14)
              .fontColor(Color.White)
              .padding({
                left: 16,
                right: 16,
                top: 8,
                bottom: 8
              })
              .borderRadius(20)
              .backgroundColor(this.currentFilter === item ? '#FF0050' : '#ff5a5a5a')
              .margin({ right: 15 })
              .onClick(() => {
                this.currentFilter = item
              })
          })
        }
        .padding({
          left: 15,
          right: 15,
          top: 10,
          bottom: 10
        })
      }
      .scrollable(ScrollDirection.Horizontal)
      .width('100%')
      .height('auto')


      // 网格布局-创作者网格
      Grid() {
        ForEach(CreatorList.filter(creator =>   // 过滤创作者列表，ps:应该在viewModel中过滤会更好一下（通过船底分类名返回该分类列表数据）
        this.currentFilter === 'all' || creator.category === this.currentFilter),
          (creator: CreatorItem) => {
            GridItem() {
              Column() {
                // 头像
                Image(creator.avatar)
                  .sharedTransition(`sharedImage_${creator.id}`, {
                    // 绑定用户ID使得动画唯一标识
                    duration: 300,
                    curve: Curve.EaseInOut, // 缓慢开始和结束，中间加速
                    delay: 100
                  })// .sharedTransition('sharedImage', { duration: 300, curve: Curve.EaseInOut, delay: 100 })
                  .width(80)
                  .height(80)
                  .borderRadius(40)
                  .border({ width: 2, color: '#FF0050' })
                  .margin({ bottom: 10 })
                  .onClick(() => {
                    let paramsInfo: CreatorItem = creator
                    router.pushUrl({
                      url: 'Mine/pages/ProfileCreator', // 目标url
                      params: paramsInfo // 添加params属性，传递自定义参数
                    }, (err) => {
                      if (err) {
                        console.error(`Invoke pushUrl failed, code is ${err.code}, message is ${err.message}`);
                        return;
                      }
                      console.info('Invoke pushUrl succeeded.');
                    })
                  })

                // 创作者姓名
                Text(creator.name)
                  .fontSize(16)
                  .fontColor(Color.White)
                  .fontWeight(FontWeight.Bold)
                  .margin({ bottom: 5 })

                // 统计数据
                Row() {
                  Text(`${creator.fans}粉丝`)
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
                  ForEach(creator.tags, (tag: string) => {
                    Text(tag)
                      .fontSize(10)
                      .fontColor(Color.White)
                      .padding({
                        left: 8,
                        right: 8,
                        top: 3,
                        bottom: 3
                      })
                      .backgroundColor('#ff5a5a5a')
                      .borderRadius(10)
                      .margin({ right: 5, bottom: 5 })
                  })
                }

                // 关注按钮
                Button() {
                  // Text(creator.followed ? '已关注' : '关注')
                  Text(!this.persistedMapString.has(creator.id as number) ? '关注' : '已关注')
                    .fontSize(12)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(Color.White)
                }
                .width(80)
                .height(30)
                .backgroundColor(creator.followed ? '#ff5a5a5a' : '#FF0050')
                .border({
                  width: creator.followed ? 1 : 0,
                  color: '#FF0050'
                })
                .borderRadius(15)
                .margin({ top: 10 })
                .stateEffect(true)
                .onClick(() => {
                  // creator.followed = !creator.followed;
                  // const list = this.list1.filter(item=>item.id===creator.id)
                  // let templList:creator[] =[]
                  // console.log(`${JSON.stringify(list)}`);
                  // this.list1.forEach(element => {
                  //   if (element.id === creator.id) {
                  //     templList.
                  //   }
                  // });
                  // this.list1 = templList


                  // 检查是否已关注（persistedMapString 是否已有该用户 id）
                  const isAlreadyFollowing = this.persistedMapString.has(creator.id as number);
                  if (!isAlreadyFollowing) {
                    // 1. 未关注 → 添加
                    this.attentionList = this.attentionList.concat(creator);
                    this.persistedMapString.set(creator.id as number, creator.name as string);
                  } else {
                    // 2. 已关注 → 移除
                    this.attentionList = this.attentionList.filter(item => item.id !== creator.id);
                    this.persistedMapString.delete(creator.id as number);
                  }
                  // 打印当前关注列表
                  console.log("Current attentionList:", this.attentionList.map(user => user.name));

                })
              }
              .width('100%')
              .height(280)
              .padding(15)
              .backgroundColor('#1A1A1A')
              .borderRadius(12)
            }
          }
        )
      }
      .columnsTemplate('1fr 1fr')  // 将网格划分为 2 列，每列的宽度比例为 1:1（即两列等宽）
      .columnsGap(15)
      .rowsGap(15)
      .width('100%')
      .height('85%')
      .padding(15)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.Black)
  }
}
