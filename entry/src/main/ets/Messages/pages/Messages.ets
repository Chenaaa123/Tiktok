import CommentsPage from '../component/CommentsPage';
import MentionsPage from '../component/MentionsPage';
import NotificationsPage from '../component/NotificationsPage';
import PrivateMessagesPage from '../component/PrivateMessagesPage';
import { router } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';


@Entry
@Component
export default struct Messages {
  @State currentTab: string = 'private' // 当前选中的标签
  @State searchText: string = '' // 搜索文本
  @State currentNav: string = 'message' // 当前导航
  @State isPressed: boolean = false

  // 构建标签项
  @Builder
  buildTabItem(label: string, tabName: string) {
    Column() {
      Text(label)
        .fontSize(18)
        .fontWeight(800)
        .fontColor(this.currentTab === tabName ? '#FFFFFF' : '#999999')
      if (this.currentTab === tabName) {
        Divider()
          .color('#FFFF')
          .strokeWidth(2)
          .width(24)
          .margin({ top: 4 })
      }
    }
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      this.currentTab = tabName
    })
  }

  // // 构建导航项
  // @Builder
  // buildNavItem(label: string, navName: string) {
  //   Column() {
  //     Text(this.getNavIcon(navName))
  //       .fontSize(24)
  //       .fontColor(this.currentNav === navName ? '#FFFFFF' : '#999999')
  //     Text(label)
  //       .fontSize(10)
  //       .fontColor(this.currentNav === navName ? '#FFFFFF' : '#999999')
  //       .margin({ top: 2 })
  //   }
  //   .layoutWeight(1)
  //   .height('100%')
  //   .justifyContent(FlexAlign.Center)
  //   .onClick(() => {
  //     this.currentNav = navName
  //   })
  // }
  //
  // // 获取导航图标
  // private getNavIcon(navName: string): string {
  //   switch (navName) {
  //     case 'home':
  //       return '🏠'
  //     case 'explore':
  //       return '🔎'
  //     case 'create':
  //       return '➕'
  //     case 'message':
  //       return '💬'
  //     case 'profile':
  //       return '👤'
  //     default:
  //       return ''
  //   }
  // }

  build() {
    // Stack() {
      Column() {
        // 顶部栏
        Row() {
          Text('←')
            .fontSize(24)
            .fontColor('#fff')
            .margin({ left: 16 })
            .onClick(()=>{
              router.pushUrl({
                url: 'Discover/pages/Discover'
              }).then(() => {
                console.info('push page success');
              }).catch((err: BusinessError) => {
                console.error(`pushUrl failed, code is ${err.code}, message is ${err.message}`);
              })
            })
          Blank().layoutWeight(1)
          Text('消息')
            .fontSize(20)
            .fontColor('#fff')
            .fontWeight(FontWeight.Bold)
            .margin({ right: 16 })
          Blank().layoutWeight(1)
          Text('✍️')
            .fontSize(20)
            .margin({ right: 16 })
        }
        .width('100%')
        .height(48)
        .alignItems(VerticalAlign.Center)
        .backgroundColor('#00000')

        // 顶部标签页
        Row() {
          this.buildTabItem('私信', 'private')
          this.buildTabItem('通知', 'notice')
          this.buildTabItem('@我', 'mention')
          this.buildTabItem('评论', 'like')
        }
        .width('100%')
        .height(56)
        .justifyContent(FlexAlign.SpaceAround)
        .backgroundColor('#0000')

        // 搜索栏
        Row() {
          Text('🔎')
            .fontSize(20)
            .margin({ left: 12 })
          TextInput({ placeholder: '搜索' })
            .placeholderFont({ size: 14 })
            .placeholderColor('#666666')
            .textAlign(TextAlign.Start)
            .height(36)
            .layoutWeight(1)
            .margin({ left: 8, right: 12 })
            .onChange((value: string) => {
              this.searchText = value
            })
        }
        .width('96%')
        .borderRadius(18)
        .backgroundColor('#333333')
        .margin({ left: 12, right: 12, top: 8 })

        // 内容区域
        Column() {
          if (this.currentTab === 'private') {
            PrivateMessagesPage()   // 私信
          } else if (this.currentTab === 'notice') {
            NotificationsPage()     // 通知
          } else if (this.currentTab === 'mention') {
            MentionsPage()          // @我
          } else if (this.currentTab === 'like') {
            CommentsPage()          // 评论
          }
        }
        .width('100%')
        .padding({ top: 16 })
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.Black)

      // // 底部导航栏
      // Row() {
      //   this.buildNavItem('首页', 'home')
      //   this.buildNavItem('发现', 'explore')
      //   this.buildNavItem('创建', 'create')
      //   this.buildNavItem('消息', 'message')
      //   this.buildNavItem('我', 'profile')
      // }
      // .width('100%')
      // .height(56)
      // .backgroundColor(Color.Black)
      // .alignItems(VerticalAlign.Center)
      // .position({ x: 0, y: '100%' })
      // .translate({ y: -56 })
    // }
    // .width('100%')
    // .height('100%')
  }
}


