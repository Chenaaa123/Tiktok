
import { VideoItem } from '../model/DataModel';
import { VideoComponent } from '../components/VideoComponent';
import { Home_Follow } from './Home_Follow';
import { Home_Hot } from './Home_Hot';
import router from '@ohos.router';
import window from '@ohos.window';
import Discover from '../../Discover/pages/Discover';
import Messages from '../../Messages/pages/Messages';

@Entry
@Component
export default struct Index_Recommendation {
  @State selectedNavItem: number = 0;
  @State currentIndex: number = 0;
  @State screenWidth: number = 0;
  @State screenHeight: number = 0;
  private lastTapTime: number = 0;
  private tabsController: TabsController = new TabsController();
  private bottomTabsController: TabsController = new TabsController();
  @State videoList: VideoItem[] = [
    {
      id: 'v001',
      title: '沉浸式体验夕阳西下',
      cover: $rawfile('Video/the_setting_sun.mp4'),
      duration: 185,
      likes: 1280,
      comments: 342,
      playCount: 1052000,
      author: '旅行达人',
      category: '旅行'
    },
    {
      id: 'v002',
      title: '来次美妙的公路骑行',
      cover: $rawfile('Video/Road_Cycling.mp4'),
      duration: 245,
      likes: 2560,
      comments: 678,
      playCount: 850000,
      author: '运动达人',
      category: '运动'
    }
  ];

  aboutToAppear() {
    // 获取屏幕尺寸
    try {
      window.getLastWindow(getContext(this))
        .then((windowClass) => {
          let windowProperties = windowClass.getWindowProperties()
          this.screenWidth = windowProperties.windowRect.width;
          this.screenHeight = windowProperties.windowRect.height;
        })
    } catch (err) {
      console.error('Failed to get window size: ' + err);
    }
  }

  @Builder
  TabBuilder(title: string, index: number) {
    Column() {
      Image(this.currentIndex === index ?
      $r('app.media.ic_tab_selected') :
      $r('app.media.ic_tab_normal'))
        .width(24)
        .height(24)
        .margin({ bottom: 4 })
      Text(title)
        .fontColor(this.currentIndex === index ? '#007DFF' : '#6B6B6B')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
    }
    .width('100%')
    .height(60)
    .justifyContent(FlexAlign.Center)
  }

  @Builder
  HomeTabs() {
    Tabs({ barPosition: BarPosition.Start, controller: this.tabsController }) {
      // 音乐页
      TabContent() {
        Column() {
          Text('点击跳转到音乐播放页')
            .fontSize(18)
            .fontColor('#333333')
            .margin(20)
            .onClick(() => {
              router.pushUrl({
                url: 'pages/Audio2Page'
              });
            })
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#FFFFFF')
      }
      .tabBar(this.TabBuilder('音乐', 0))

      // 热门页 - 视频播放
      TabContent() {
        Swiper() {
          ForEach(this.videoList, (item: VideoItem) => {
            Stack() {
              VideoComponent({
                data: item,
                onCommentClick: () => {
                  router.pushUrl({
                    url: 'pages/CommentsPage',
                    params: { videoId: item.id }
                  });
                }
              })
                .width('100%')
                .height('100%')
                .onTouch((event: TouchEvent) => {
                  if (event.type === TouchType.Down) {
                    const currentTime = new Date().getTime();
                    if (currentTime - this.lastTapTime < 300) {
                      // 双击
                      animateTo({ duration: 200 }, () => {
                        item.likes += 1;
                      });
                    }
                    this.lastTapTime = currentTime;
                  }
                })
            }
            .width('100%')
            .height('100%')
            .backgroundColor('#000000')
          })
        }
        .vertical(true)
        .autoPlay(false)
        .indicator(false)
        .width('100%')
        .height('100%')
      }
      .tabBar(this.TabBuilder('热门', 1))

      // 推荐页
      TabContent() {
        Column() {
          Home_Follow()
        }
      }
      .tabBar(this.TabBuilder('推荐', 2))
    }
    .barWidth('100%')
    .barHeight(60)
    .barMode(BarMode.Fixed)
    .onChange((index: number) => {
      this.currentIndex = index;
    })
    .backgroundColor('#FFFFFF')
    .layoutWeight(1)
  }


  build() {
    Column() {
      this.HomeTabs()
    }
    .height('100%')
    .width('100%')
  }
}


//
// import { VideoItem } from '../model/DataModel';
// import { VideoComponent } from '../components/VideoComponent';
// import { Home_Follow } from './Home_Follow';
// import { Home_Hot } from './Home_Hot';
// import router from '@ohos.router';
// import window from '@ohos.window';
// import Discover from '../../Discover/pages/Discover';
// import Messages from '../../Messages/pages/Messages';
//
// @Entry
// @Component
// export default struct Index_Recommendation {
//   @State selectedNavItem: number = 0;
//   @State currentIndex: number = 0;
//   @State screenWidth: number = 0;
//   @State screenHeight: number = 0;
//   private lastTapTime: number = 0;
//   private tabsController: TabsController = new TabsController();
//   private bottomTabsController: TabsController = new TabsController();
//   @State videoList: VideoItem[] = [
//     {
//       id: 'v001',
//       title: '沉浸式体验夕阳西下',
//       cover: $rawfile('Video/the_setting_sun.mp4'),
//       duration: 185,
//       likes: 1280,
//       comments: 342,
//       playCount: 1052000,
//       author: '旅行达人',
//       category: '旅行'
//     },
//     {
//       id: 'v002',
//       title: '来次美妙的公路骑行',
//       cover: $rawfile('Video/Road_Cycling.mp4'),
//       duration: 245,
//       likes: 2560,
//       comments: 678,
//       playCount: 850000,
//       author: '运动达人',
//       category: '运动'
//     }
//   ];
//
//   aboutToAppear() {
//     // 获取屏幕尺寸
//     try {
//       window.getLastWindow(getContext(this))
//         .then((windowClass) => {
//           let windowProperties = windowClass.getWindowProperties()
//           this.screenWidth = windowProperties.windowRect.width;
//           this.screenHeight = windowProperties.windowRect.height;
//         })
//     } catch (err) {
//       console.error('Failed to get window size: ' + err);
//     }
//   }
//
//   @Builder
//   TabBuilder(title: string, index: number) {
//     Column() {
//       Image(this.currentIndex === index ?
//       $r('app.media.ic_tab_selected') :
//       $r('app.media.ic_tab_normal'))
//         .width(24)
//         .height(24)
//         .margin({ bottom: 4 })
//       Text(title)
//         .fontColor(this.currentIndex === index ? '#007DFF' : '#6B6B6B')
//         .fontSize(14)
//         .fontWeight(FontWeight.Medium)
//     }
//     .width('100%')
//     .height(60)
//     .justifyContent(FlexAlign.Center)
//   }
//
//   @Builder
//   HomeTabs() {
//     Tabs({ barPosition: BarPosition.Start, controller: this.tabsController }) {
//       // 音乐页
//       TabContent() {
//         Column() {
//           Text('点击跳转到音乐播放页')
//             .fontSize(18)
//             .fontColor('#333333')
//             .margin(20)
//             .onClick(() => {
//               router.pushUrl({
//                 url: 'pages/Audio2Page'
//               });
//             })
//         }
//         .width('100%')
//         .height('100%')
//         .backgroundColor('#FFFFFF')
//       }
//       .tabBar(this.TabBuilder('音乐', 0))
//
//       // 热门页 - 视频播放
//       TabContent() {
//         Swiper() {
//           ForEach(this.videoList, (item: VideoItem) => {
//             Stack() {
//               VideoComponent({
//                 data: item,
//                 onCommentClick: () => {
//                   router.pushUrl({
//                     url: 'pages/CommentsPage',
//                     params: { videoId: item.id }
//                   });
//                 }
//               })
//                 .width('100%')
//                 .height('100%')
//                 .onTouch((event: TouchEvent) => {
//                   if (event.type === TouchType.Down) {
//                     const currentTime = new Date().getTime();
//                     if (currentTime - this.lastTapTime < 300) {
//                       // 双击
//                       animateTo({ duration: 200 }, () => {
//                         item.likes += 1;
//                       });
//                     }
//                     this.lastTapTime = currentTime;
//                   }
//                 })
//             }
//             .width('100%')
//             .height('100%')
//             .backgroundColor('#000000')
//           })
//         }
//         .vertical(true)
//         .autoPlay(false)
//         .indicator(false)
//         .width('100%')
//         .height('100%')
//       }
//       .tabBar(this.TabBuilder('热门', 1))
//
//       // 推荐页
//       TabContent() {
//         Column() {
//           Home_Follow()
//         }
//       }
//       .tabBar(this.TabBuilder('推荐', 2))
//     }
//     .barWidth('100%')
//     .barHeight(60)
//     .barMode(BarMode.Fixed)
//     .onChange((index: number) => {
//       this.currentIndex = index;
//     })
//     .backgroundColor('#FFFFFF')
//     .layoutWeight(1)
//   }
//
//   @Builder
//   DiscoveryContent() {
//     Column() {
//       Text('发现页内容')
//         .fontSize(16)
//         .fontColor('#333333')
//     }
//     .width('100%')
//     .height('100%')
//     .backgroundColor('#FFFFFF')
//     .layoutWeight(1)
//   }
//
//   @Builder
//   MessagesContent() {
//     Column() {
//       Text('消息页内容')
//         .fontSize(16)
//         .fontColor('#333333')
//     }
//     .width('100%')
//     .height('100%')
//     .backgroundColor('#FFFFFF')
//     .layoutWeight(1)
//   }
//
//   @Builder
//   ProfileContent() {
//     Column() {
//       Text('我的页面内容')
//         .fontSize(16)
//         .fontColor('#333333')
//     }
//     .width('100%')
//     .height('100%')
//     .backgroundColor('#FFFFFF')
//     .layoutWeight(1)
//   }
//
//   build() {
//     Column() {
//       if (this.selectedNavItem === 0) {
//         this.HomeTabs()
//       } else if (this.selectedNavItem === 1) {
//         // this.DiscoveryContent()
//         Discover()
//       } else if (this.selectedNavItem === 3) {
//         Messages()
//       } else if (this.selectedNavItem === 4) {
//         this.ProfileContent()
//       }
//
//       // 底部导航栏
//       Row() {
//         Column() {
//           Image(this.selectedNavItem === 0 ? $rawfile('Home/home_selected.png') : $rawfile('Home/home_normal.png'))
//             .width(24)
//             .height(24)
//           Text('首页')
//             .fontSize(12)
//             .fontColor(this.selectedNavItem === 0 ? '#FF4B50' : '#999999')
//         }
//         .layoutWeight(1)
//         .onClick(() => this.selectedNavItem = 0)
//
//         Column() {
//           Image(this.selectedNavItem === 1 ? $rawfile('Home/discovery_selected.png') : $rawfile('Home/discovery_normal.png'))
//             .width(24)
//             .height(24)
//           Text('发现')
//             .fontSize(12)
//             .fontColor(this.selectedNavItem === 1 ? '#FF4B50' : '#999999')
//         }
//         .layoutWeight(1)
//         .onClick(() => this.selectedNavItem = 1)
//
//         Column() {
//           Image(this.selectedNavItem === 2 ? $rawfile('Home/post_selected.png') : $rawfile('Home/post_normal.png'))
//             .width(48)
//             .height(48)
//           Text('发布')
//             .fontSize(12)
//             .fontColor(this.selectedNavItem === 2 ? '#FF4B50' : '#999999')
//         }
//         .layoutWeight(1)
//         .onClick(() => this.selectedNavItem = 2)
//
//         Column() {
//           Image(this.selectedNavItem === 3 ? $rawfile('Home/messages_selected.png') : $rawfile('Home/messages_normal.png'))
//             .width(24)
//             .height(24)
//           Text('消息')
//             .fontSize(12)
//             .fontColor(this.selectedNavItem === 3 ? '#FF4B50' : '#999999')
//         }
//         .layoutWeight(1)
//         .onClick(() => this.selectedNavItem = 3)
//
//         Column() {
//           Image(this.selectedNavItem === 4 ? $rawfile('Home/profile_selected.png') : $rawfile('Home/profile_normal.png'))
//             .width(24)
//             .height(24)
//           Text('我')
//             .fontSize(12)
//             .fontColor(this.selectedNavItem === 4 ? '#FF4B50' : '#999999')
//         }
//         .layoutWeight(1)
//         .onClick(() => this.selectedNavItem = 4)
//       }
//       .width('100%')
//       .height(60)
//       .padding({ bottom: 8 })
//       .backgroundColor('#FFFFFF')
//     }
//     .height('100%')
//     .width('100%')
//   }
// }