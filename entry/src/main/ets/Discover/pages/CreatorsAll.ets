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
  @StorageLink("persistedMapString") persistedMapString: Map<number, string> = new Map<number, string>([]);

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
      .height('auto')


      // 创作者网格
      Grid() {
        ForEach(CreatorList.filter(creator =>
        this.currentFilter === 'all' || creator.category === this.currentFilter), (creator:CreatorItem) => {
          GridItem() {
            Column() {
              // 头像
              Image(creator.avatar)
                .width(80)
                .height(80)
                .borderRadius(40)
                .border({ width: 2, color: '#FF0050' })
                .margin({ bottom: 10 })
                .onClick(()=>{
                  let paramsInfo: CreatorItem = creator
                  router.pushUrl({
                    url: 'Discover/pages/text1', // 目标url
                    params: paramsInfo // 添加params属性，传递自定义参数
                  }, (err) => {
                    if (err) {
                      console.error(`Invoke pushUrl failed, code is ${err.code}, message is ${err.message}`);
                      return;
                    }
                    console.info('Invoke pushUrl succeeded.');
                  })
                })

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
                //
                // });
                // this.list1 = templList

                // this.attentionList = this.attentionList.concat(creator)
                // for (let attentionListElement of this.attentionList) {
                //   console.log("collectWordDataList Element " + attentionListElement.name);
                //   if (!this.persistedMapString.has(attentionListElement.id as number)) {
                //     this.persistedMapString.set(attentionListElement.id as number,
                //       attentionListElement.name as string)
                //   } else {
                //     this.persistedMapString.delete(attentionListElement.id as number)
                //   }
                // }

                // this.attentionList = this.attentionList.concat(creator)
                // for (let attentionListElement of this.attentionList) {
                //   console.log("attentionListElement Element " + attentionListElement.name);
                //   if (!this.persistedMapString.has(attentionListElement.id as number)) {
                //     this.persistedMapString.set(attentionListElement.id as number,
                //       attentionListElement.name as string)
                //   } else {
                //     this.persistedMapString.delete(attentionListElement.id as number)
                //     const index = this.attentionList.findIndex(item => item.id === creator.id);
                //     if (index !== -1) {
                //       this.attentionList.splice(index, 1);
                //     }
                //   }
                // }

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


                // 触发动画
                this.animationStates.set(creator.id.toString(), true)
                // 1秒后重置动画状态
                setTimeout(() => {
                  this.animationStates.set(creator.id.toString(), false)
                }, 1000)
              })
            }
            .width('100%')
            .height(280)
            .padding(15)
            .backgroundColor('#1A1A1A')
            .borderRadius(12)
            .scale({
              scale: this.animationStates.get(creator.id.toString()) ? 1.1 : 1.0
            } as ScaleOptions)
            .animation({
              duration: 1000,
              curve: Curve.EaseInOut,
              iterations: 1,
              playMode: PlayMode.Alternate
            })
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
      .height('85%')
      .padding(15)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.Black)
  }
}
