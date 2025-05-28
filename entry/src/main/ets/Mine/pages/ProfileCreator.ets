import { router } from '@kit.ArkUI'
import CreatorItem from '../../Discover/model/CreatorItem'
import { likes, work,collections} from '../../Discover/viewmodel/ThreeContentList'

import ThreeContentItem from '../../Discover/model/ThreeContentItem'


@Entry
@Component
export default struct ProfileCreator {
  @State isProfileCollapsed: boolean = false
  @State currentTab: number = 0
  @State isFollowing: boolean = false
  @State item: string = ''
  private tabsController: TabsController = new TabsController()
  @State needLoad: boolean = false


  @State creator: CreatorItem | null = null; // 修改为单个创作者对象
  aboutToAppear(): void {
    let params = router.getParams() as CreatorItem; // 直接获取创作者对象
    this.creator = params;
    console.info('获取传递过来的创作者信息:', JSON.stringify(this.creator));
  }


  @Builder
  TabBuilder(index: number, title: string) {
    if (index === this.currentTab) {
      Text(title)
        .fontColor(Color.White)
        .fontSize(16)
        .padding(10)
        .border({ width: { bottom: 2 }, color: 'white' })
    } else {
      Text(title)// .fontWeight(800)
        .fontSize(16)
        .fontColor(Color.Gray)
    }

  }

  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Image($r('app.media.back'))
          .width(24)
          .height(24)
          .onClick(() => {
            router.back()
          })
        Text('创作者主页')
          .fontSize(18)
          .fontColor(Color.White)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      // .backgroundColor('#000000')
      .justifyContent(FlexAlign.SpaceBetween)

      // 主要内容区域
      Scroll() {
        if (this.creator) { // 添加空值检查
          Column() {
            // 个人信息卡片
            Column() {
              Image(this.creator.avatar)
                .sharedTransition(`sharedImage_${this.creator.id}`, {  // 对应唯一动画标识
                  duration: 300,
                  curve: Curve.EaseInOut,
                  delay: 100
                })
                // .sharedTransition('sharedImage', { duration: 300, curve: Curve.EaseInOut, delay: 100 })
                .width(83)
                .height(83)
                .borderRadius(50)
                .border({ width: 3, color: '#000000' })

              Text(this.creator.name)
                .fontSize(15)
                .fontColor(Color.White)
                .fontWeight(FontWeight.Medium)
                .margin({ top: 15 })

              Text('@' + this.creator.accountId)
                .fontSize(10)
                .fontColor(Color.White)
                .opacity(0.6)
                .margin({ top: 5 })

              // 统计数据
              if (!this.isProfileCollapsed) {
                Row({ space: 18 }) {
                  this.StatItem(this.creator.attention, '关注')
                  this.StatItem(this.creator.fans, '粉丝')
                  this.StatItem(this.creator.likes, '获赞')
                }
                .width('50%')
                .justifyContent(FlexAlign.Center)
                //.justifyContent(FlexAlign.SpaceAround)
                .margin({ top: 15 })


                Text(this.creator.description)
                  .fontSize(13)
                  .fontColor(Color.White)
                  .textAlign(TextAlign.Center)
                  .margin({ top: 15, left: 20, right: 20 })

                // 操作按钮
                Row({ space: 10 }) {
                  Button(this.isFollowing ? '已关注' : '关注', { type: ButtonType.Normal, stateEffect: true })
                    .backgroundColor(this.isFollowing ? 'transparent' : '#FE2C55')
                    .borderColor(this.isFollowing ? 'rgba(255, 255, 255, 0.3)' : 'transparent')
                    .borderWidth(1)
                    .onClick(() => {
                      this.isFollowing = !this.isFollowing
                    })
                  Button('私信', { type: ButtonType.Normal, stateEffect: true })//stateEffect:按压效果
                    .backgroundColor('transparent')
                    .borderColor('rgba(255, 255, 255, 0.3)')
                    .borderWidth(1)
                }
                .width('100%')
                .justifyContent(FlexAlign.Center)
                .margin({ left: 15, right: 15 })
                .margin({ top: 20 })
              }


              // 展开/收起按钮
              Button(this.isProfileCollapsed ? '展开 ▼' : '收起 ▲')
                .backgroundColor('rgba(255, 255, 255, 0.2)')
                .borderRadius(20)
                .fontSize(12)
                .height(30)
                .onClick(() => {
                  this.isProfileCollapsed = !this.isProfileCollapsed
                })
                .margin({ top: 10 })
            }
            .width('100%')
            .alignItems(HorizontalAlign.Center)
            // .backgroundColor('#000000')


            // 标签页
            Tabs({ barPosition: BarPosition.Start, controller: this.tabsController }) {
              TabContent() {        // 显示作品列表
                this.VideoGrid(work, 'videos')
              }.tabBar(this.TabBuilder(0,'作品'))
              TabContent() {        // 显示喜欢列表
                this.VideoGrid(likes, 'likes')
              }.tabBar(this.TabBuilder(1,'喜欢'))
              TabContent() {        // 显示收藏列表
                this.VideoGrid(collections, 'favorites')
              }.tabBar(this.TabBuilder(2,'收藏'))
            }
            .barMode(BarMode.Fixed)
            // .backgroundColor('#000000')
            .onChange((index) => {
              this.currentTab = index
            })
          }
        }

      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)

    }
    .width('100%')
    .height('100%')
    .backgroundImage($r("app.media.BackgroundImg"),ImageRepeat.NoRepeat)
    .backgroundImageSize({ width: '100%', height: '100%' })
    // .backgroundColor('#000000')
  }

  @Builder
  StatItem(value: string | number, label: string) {
    Column() {
      Text(value.toString())
        .fontSize(15)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.White)
      Text(label)
        .fontSize(10)
        .fontColor(Color.White)
        .opacity(0.6)
    }
  }

  @Builder          //list: 作品、喜欢、收藏列表
  VideoGrid(list: ThreeContentItem[], type: string) {
    // let filteredList = list.filter(item => item.name === this.creator.name);
    Grid() {
      ForEach(list.filter(item => item.name === this.creator?.name), (item: ThreeContentItem) => {
        GridItem() {
          Stack() {
            Image(item.cover)
              .width('100%')
              .height('100%')
              .objectFit(ImageFit.Cover)
            Row() {
              Text('♡')
                .width(16)
                .height(16)
                .fontColor(Color.White)
                .margin({ bottom: 8 })
                .fontWeight(800)
              Text(item.like)
                .fontSize(12)
                .fontColor('#FFFFFF')
            }
            .margin({ right: 50, top: 130 })
          }
          .width('100%')
          .aspectRatio(3 / 4)
          .onClick(() => {
            router.pushUrl({
              url: 'pages/VideoPlayer',
              params: {
                videoId: item,
                // creatorId: this.creator.id,
                type: type
              }
            })
          })
        }
      })
    }
    .columnsTemplate('1fr 1fr 1fr')
    .columnsGap(2)
    .rowsGap(2)
    .padding(2)
  }
}