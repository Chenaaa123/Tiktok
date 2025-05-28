import Recommend from '../component/Recommend'
import Popular from '../component/Popular';
import Music from '../component/Music';
import Dance from '../component/Dance';
import Game from '../component/Game';
import Food from '../component/Food';
import Travel from '../component/Travel';
import { promptAction, router } from '@kit.ArkUI';
import { getUserByUsername } from '../viewmodel/CreatorList';
import CreatorItem from '../model/CreatorItem';

@Entry
@Component
export default struct Discover {
  @State InputText: string = ''
  @State searchResult: CreatorItem | null = null
  @State currentIndex: number = 0
  @State categoryName: string = '推荐' // 设置默认值

  @Builder    // 顶部Tab栏
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
      // 顶部标题栏
      Row() {
        Image($r('app.media.back'))   // 返回箭头
          .width(30)
          .margin({ left: 10 })
          .onClick(()=>{
            router.pushUrl({
              url: "Home/pages/Index",
            })
            router.clear()
          })
        Text(`发现 - ${this.categoryName}`)  // 根据点击tab栏改变标题
          .margin({ right: 10 })
          .fontColor(Color.White)
          .fontSize(16)
          .fontWeight(800)
      }
      .width('100%')
      .height(50)
      .justifyContent(FlexAlign.SpaceBetween)

      // 搜索框
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
            this.InputText = value    // 更新搜索框的值
          })
        Button('搜索')    // 搜索按钮，进行用户搜索
          .height(40)
          .fontColor(Color.White)
          .fontSize(12)
          .padding({ left: 15, right: 15 })
          .backgroundColor('#333333')
          .borderRadius(20)
          .position({ right: -3})
          .onClick(() => {
            // 1. 执行搜索、通过用户名得到用户信息
            this.searchResult = getUserByUsername(this.InputText)

            if (this.searchResult) {    // 如果搜索到用户
              // 2. 跳转并传递用户数据
              router.pushUrl({
                url: 'Mine/pages/ProfileCreator',
                params: this.searchResult   // 传递用户数据
              })
              this.InputText = ''    // 清空搜索框
            } else {
              promptAction.showToast({
                message: '未找到该用户',
                duration: 1500, // 持续时间为3秒
              })
            }
            console.log('搜索:', this.InputText)
          })
      }
      .borderRadius(20)
      .width('94%')
      .backgroundColor('#333333')
      .margin({ left: 10, right: 10, top: 5 })
      .height(40)

        // 主内容区 - 使用剩余空间
        Column() {
          Tabs({ barPosition: BarPosition.Start }) {   // Tab 栏在顶部
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
          .onChange((index: number) => {    // Tab栏切换时，更新当前索引和标题
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
          .barMode(BarMode.Scrollable)    // 支持横向滚动
          .backgroundColor('#000')
          .barHeight(40) // 设置标签栏高度
        }
        .width('100%')
        .height('100%')
        .margin({ top: 5 })

      }
      .width('100%')
      .height('90%')
      .backgroundColor('#000')
    }
  }

