import Recommend from '../view/Recommend'
import Popular from '../view/Popular';
import Music from '../view/Music';
import Dance from '../view/Dance';
import Game from '../view/Game';
import Food from '../view/Food';
import Travel from '../view/Travel';

@Entry
@Component
struct Discover {
  @State InputText: string = ''
  @State currentIndex: number = 0
  @State categoryName: string = '推荐' // 设置默认值

  @Builder
  tabBuilder(title: string, targetIndex: number) {
    Button(title)
      .fontSize(14)
      .fontColor(Color.White)
      .margin({ left: 5, right: 5 })
      .backgroundColor(this.currentIndex === targetIndex ? '#FF0050' : '#333333')
      .width(65)
      .height(30)
      .borderRadius(20)
  }

  build() {
    Column() {
      // 顶部标题栏 - 固定高度
      Row() {
        Image($r('app.media.back'))
          .width(30)
          .margin({ left: 10 })
        Text(`发现 - ${this.categoryName}`)
          .margin({ right: 10 })
          .fontColor(Color.White)
          .fontSize(16)
          .fontWeight(800)
      }
      .width('100%')
      .height(50)
      .justifyContent(FlexAlign.SpaceBetween)

      // 搜索框 - 固定高度
      Row() {
        Image($r('app.media.search'))
          .height(16)
          .fillColor('#ffff')
          .margin({ left: 10 })
        TextInput({ placeholder: '搜索音乐、视频或创作者', text: this.InputText })
          .height(40)
          .fontColor(Color.White)
          .placeholderColor(Color.White)
          .padding({ left: 10, right: 10 })
          .fontSize(12)
          .placeholderFont({ size: 12 })
          .onChange((value: string) => {
            this.InputText = value
          })
      }
          .borderRadius(20)
          .width('94%')
          .backgroundColor('#333333')
          .margin({ left: 10, right: 10, top: 5 })
          .height(40)

        // 主内容区 - 使用剩余空间
        Column() {
          Tabs({ barPosition: BarPosition.Start }) {
            TabContent() {
              Recommend()
            }.tabBar(this.tabBuilder('推荐', 0))

            TabContent() {
              Popular()
            }.tabBar(this.tabBuilder('热门', 1))

            TabContent() {
              Music()
            }.tabBar(this.tabBuilder('音乐', 2))

            TabContent() {
              Dance()
            }.tabBar(this.tabBuilder('舞蹈', 3))

            TabContent() {
              Game()
            }.tabBar(this.tabBuilder('游戏', 4))

            TabContent() {
              Food()
            }.tabBar(this.tabBuilder('美食', 5))

            TabContent() {
              Travel()
            }.tabBar(this.tabBuilder('旅游', 6))
          }
          .onChange((index: number) => {
            this.currentIndex = index;
            switch (index) {
              case 0:
                this.categoryName = '推荐';
                break;
              case 1:
                this.categoryName = '热门';
                break;
              case 2:
                this.categoryName = '音乐';
                break;
              case 3:
                this.categoryName = '舞蹈';
                break;
              case 4:
                this.categoryName = '游戏';
                break;
              case 5:
                this.categoryName = '美食';
                break;
              case 6:
                this.categoryName = '旅游';
                break;
              default:
                this.categoryName = '推荐';
            }
          })
          .padding(0)
          .barMode(BarMode.Scrollable)
          .backgroundColor('#000')
          .barHeight(40) // 设置标签栏高度
        }
        .width('100%')
        .height('100%') // 使用剩余空间
        .margin({ top: 5 })

      }
      .width('100%')
      .height('90%') // 填满整个屏幕
      .backgroundColor('#000')
    }
  }

