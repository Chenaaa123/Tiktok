//
//
//
// import { router } from '@kit.ArkUI'
// import { profileTabsData, ContentItem, TabData, UserProfile, defaultProfile ,GeneratedType} from '../model/profileData'
//
//
// @Entry
// @Component
// export default struct ProfileCenter {
//   private tabsController: TabsController = new TabsController()
//   @State currentTab: number = 0
//   @State userProfile: UserProfile = defaultProfile
//
//   // 通用视频网格渲染
//   @Builder
//   VideoGrid(list: ContentItem[], type: string) {
//     Grid() {
//       ForEach(list, (item: ContentItem) => {
//         GridItem() {
//           Stack() {
//             Image(item.cover)
//               .width('100%')
//               .height('100%')
//               .objectFit(ImageFit.Cover)
//             Row() {
//               Text('♡')
//                 .width(16)
//                 .height(16)
//                 .fontColor(Color.White)
//                 .margin({ bottom: 8 })
//                 .fontWeight(800)
//               Text(item.likes)
//                 .fontSize(12)
//                 .fontColor('#FFFFFF')
//             }
//             .margin({ right: 50, top: 130 })
//           }
//           .width('100%')
//           .aspectRatio(3 / 4)
//           .onClick(() => {
//             router.pushUrl({
//               url: 'pages/VideoPlayer',
//               params: { videoId: item, type: type }
//             })
//           })
//         }
//       })
//     }
//     .columnsTemplate('1fr 1fr 1fr')
//     .columnsGap(2)
//     .rowsGap(2)
//     .padding(2)
//   }
//
//   @Builder
//   TabBuilder(index: number, title: string) {
//     Text(title)
//       .fontSize(16)
//       .padding(10)
//       .fontColor(index === this.currentTab ? Color.White : Color.Gray)
//       .border(index === this.currentTab ? { width: { bottom: 2 }, color: 'white' } : {})
//   }
//
//   @Builder
//   ProfileHeader() {
//     Column() {
//       Image(this.userProfile.avatar)
//         .width(100)
//         .height(100)
//         .borderRadius(50)
//         .objectFit(ImageFit.Cover)
//         .border({ width: 2, color: 'rgba(255,255,255,0.2)' })
//         .margin({ bottom: 15 })
//       Text(this.userProfile.name)
//         .fontSize(22)
//         .fontWeight(FontWeight.Bold)
//         .margin({ bottom: 8 })
//         .fontColor('#ffeceaea')
//       Text(this.userProfile.brief)
//         .fontSize(14)
//         .opacity(0.8)
//         .margin({ bottom: 15 })
//         .textAlign(TextAlign.Center)
//         .fontColor('#ffeceaea')
//     }
//     .alignItems(HorizontalAlign.Center)
//   }
//
//   @Builder
//   ProfileStats() {
//     Row() {
//       Column() {
//         Text(this.userProfile.following.toString())
//           .fontSize(18)
//           .fontWeight(FontWeight.Bold)
//           .fontColor('#ffeceaea')
//         Text('关注')
//           .fontSize(12)
//           .opacity(0.8)
//           .fontColor('#ffeceaea')
//       }
//       .alignItems(HorizontalAlign.Center)
//       .width('33%')
//       Column() {
//         Text(this.userProfile.followers.toString())
//           .fontSize(18)
//           .fontWeight(FontWeight.Bold)
//           .fontColor('#ffeceaea')
//           .onClick(() => router.pushUrl({ url: 'pages/ProfileFans' }))
//         Text('粉丝')
//           .fontSize(12)
//           .opacity(0.8)
//           .fontColor('#ffeceaea')
//       }
//       .alignItems(HorizontalAlign.Center)
//       .width('33%')
//       Column() {
//         Text(this.userProfile.likes.toString())
//           .fontSize(18)
//           .fontWeight(FontWeight.Bold)
//           .fontColor('#ffeceaea')
//         Text('获赞')
//           .fontSize(12)
//           .opacity(0.8)
//           .fontColor('#ffeceaea')
//       }
//       .alignItems(HorizontalAlign.Center)
//       .width('33%')
//     }
//     .margin({ bottom: 20 })
//   }
//
//   aboutToAppear() {
//     const params = router.getParams() as GeneratedType
//     if (params) {
//       // 逐个更新用户资料属性
//       if (params.name) {
//         this.userProfile.name = params.name
//       }
//       if (params.brief) {
//         this.userProfile.brief = params.brief
//       }
//       if (params.avatar) {
//         this.userProfile.avatar = params.avatar
//       }
//     }
//   }
//
//   build() {
//     Stack() {
//       Column() {
//         // 返回按钮
//         Row() {
//           Text('←')
//             .fontSize(20)
//             .fontColor(Color.White)
//             .onClick(() => router.pushUrl({ url: 'pages/IndexMain' }))
//         }
//         .height(20)
//         .padding({ right: 300, top: 10 })
//         .alignItems(VerticalAlign.Top)
//
//         // 个人信息区域
//         this.ProfileHeader()
//         this.ProfileStats()
//
//         // 编辑资料按钮
//         Button('编辑资料')
//           .backgroundColor('#ff353333')
//           .fontColor(Color.White)
//           .borderRadius(20)
//           .fontSize(18)
//           .width(120)
//           .onClick(() => {
//             router.pushUrl({
//               url: 'pages/CompileData',
//               params: this.userProfile
//             })
//           })
//
//         // Tab内容区域
//         Tabs({ barPosition: BarPosition.Start, controller: this.tabsController }) {
//           ForEach(profileTabsData, (tabItem: TabData, index: number) => {
//             TabContent() {
//               this.VideoGrid(tabItem.list, tabItem.type)
//             }.tabBar(this.TabBuilder(index, tabItem.title))
//           })
//         }
//         .barMode(BarMode.Fixed)
//         .onChange((index: number) => {
//           this.currentTab = index
//         })
//       }
//       .width('100%')
//       .height('100%')
//       .backgroundImage($r("app.media.BackgroundImg"), ImageRepeat.NoRepeat)
//       .backgroundImageSize({ width: '100%', height: '100%' })
//     }
//     .width('100%')
//     .height('100%')
//   }
// }
import { router } from '@kit.ArkUI'
import { profileTabsData, ContentItem, TabData, UserProfile, defaultProfile ,GeneratedType} from '../model/profileData'


@Entry
@Component
export default struct ProfileCenter {
  private tabsController: TabsController = new TabsController()
  @State currentTab: number = 0
  @State userProfile: UserProfile = defaultProfile

  // 通用视频网格渲染
  @Builder
  VideoGrid(list: ContentItem[], type: string) {
    Grid() {
      ForEach(list, (item: ContentItem) => {
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
              Text(item.likes)
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
              params: { videoId: item, type: type }
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

  @Builder
  TabBuilder(index: number, title: string) {
    Text(title)
      .fontSize(16)
      .padding(10)
      .fontColor(index === this.currentTab ? Color.White : Color.Gray)
      .border(index === this.currentTab ? { width: { bottom: 2 }, color: 'white' } : {})
  }

  @Builder
  ProfileHeader() {
    Column() {
      Image(this.userProfile.avatar)
        .width(100)
        .height(100)
        .borderRadius(50)
        .objectFit(ImageFit.Cover)
        .border({ width: 2, color: 'rgba(255,255,255,0.2)' })
        .margin({ bottom: 15 })
      Text(this.userProfile.name)
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 8 })
        .fontColor('#ffeceaea')
      Text(this.userProfile.brief)
        .fontSize(14)
        .opacity(0.8)
        .margin({ bottom: 15 })
        .textAlign(TextAlign.Center)
        .fontColor('#ffeceaea')
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  ProfileStats() {
    Row() {
      Column() {
        Text(this.userProfile.following.toString())
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#ffeceaea')
          .onClick(() => router.pushUrl({ url: 'Mine/pages/ProfileFans', params: { initialTab: 1 } }))
        Text('关注')
          .fontSize(12)
          .opacity(0.8)
          .fontColor('#ffeceaea')
      }
      .alignItems(HorizontalAlign.Center)
      .width('33%')
      Column() {
        Text(this.userProfile.followers.toString())
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#ffeceaea')
          .onClick(() => router.pushUrl({ url: 'Mine/pages/ProfileFans', params: { initialTab: 2 } }))
        Text('粉丝')
          .fontSize(12)
          .opacity(0.8)
          .fontColor('#ffeceaea')
      }
      .alignItems(HorizontalAlign.Center)
      .width('33%')
      Column() {
        Text(this.userProfile.likes.toString())
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#ffeceaea')
        Text('获赞')
          .fontSize(12)
          .opacity(0.8)
          .fontColor('#ffeceaea')
      }
      .alignItems(HorizontalAlign.Center)
      .width('33%')
    }
    .margin({ bottom: 20 })
  }

  aboutToAppear() {
    const params = router.getParams() as GeneratedType
    if (params) {
      // 逐个更新用户资料属性
      if (params.name) {
        this.userProfile.name = params.name
      }
      if (params.brief) {
        this.userProfile.brief = params.brief
      }
      if (params.avatar) {
        this.userProfile.avatar = params.avatar
      }
    }
  }

  build() {
    Stack() {
      Column() {
        // 返回按钮
        Row() {
          Text('←')
            .fontSize(20)
            .fontColor(Color.White)
            .onClick(() =>
              router.pushUrl({
                url: 'Home/pages/Index'
              })
            )
        }
        .height(20)
        .padding({ right: 300, top: 10 })
        .alignItems(VerticalAlign.Top)

        // 个人信息区域
        this.ProfileHeader()
        this.ProfileStats()

        // 编辑资料按钮
        Button('编辑资料')
          .backgroundColor('#ff353333')
          .fontColor(Color.White)
          .borderRadius(20)
          .fontSize(18)
          .width(120)
          .onClick(() => {
            router.pushUrl({
              url: 'Mine/pages/CompileData',
              params: this.userProfile
            })
          })

        // Tab内容区域
        Tabs({ barPosition: BarPosition.Start, controller: this.tabsController }) {
          ForEach(profileTabsData, (tabItem: TabData, index: number) => {
            TabContent() {
              this.VideoGrid(tabItem.list, tabItem.type)
            }.tabBar(this.TabBuilder(index, tabItem.title))
          })
        }
        .barMode(BarMode.Fixed)
        .onChange((index: number) => {
          this.currentTab = index
        })
      }
      .width('100%')
      .height('100%')
      .backgroundImage($r("app.media.BackgroundImg"), ImageRepeat.NoRepeat)
      .backgroundImageSize({ width: '100%', height: '100%' })
    }
    .width('100%')
    .height('100%')
  }
}
