/**
 * 消息中心页面组件
 * 整合了私信、通知、@提及和评论功能的消息中心
 * 支持消息搜索、标签页切换等功能
 */

import CommentsPage from '../component/CommentsPage'; // 评论页面组件
import MentionsPage from '../component/MentionsPage'; // @提及页面组件
import NotificationsPage from '../component/NotificationsPage'; // 通知页面组件
import PrivateMessageItem from '../model/PrivateMessageItem'; // 私信数据模型
// import PrivateMessageList from '../viewmodel/PrivateMessageList'; // 私信列表视图模型
import { router } from '@kit.ArkUI'; // 路由组件
import { BusinessError } from '@kit.BasicServicesKit'; // 业务错误处理
import { AvatarManager } from '../model/AvatarManager'; // 头像管理器
import { PrivateMessageList } from '../viewmodel/PrivateMessageList';

/**
 * 消息中心页面组件
 * @Entry 标记为入口组件
 * @Component 标记为自定义组件
 */
@Entry
@Component
export default struct Messages {
  @State currentTab: string = 'private'; // 当前选中的标签页（private: 私信, notice: 通知, mention: @提及, like: 评论）
  @State searchText: string = ''; // 搜索框文本内容
  @State currentNav: string = 'message'; // 当前导航项
  @State isPressed: boolean = false; // 按钮按压状态
  @State filteredMessages: PrivateMessageItem[] = PrivateMessageList; // 过滤后的消息列表

  /**
   * 根据搜索文本过滤消息列表
   * @param searchText - 搜索关键词
   */
  private filterMessages(searchText: string) {
    if (!searchText.trim()) {
      this.filteredMessages = PrivateMessageList; // 搜索文本为空时显示所有消息
      return;
    }
    
    const searchLower = searchText.toLowerCase();
    // 根据用户名或消息内容进行过滤
    this.filteredMessages = PrivateMessageList.filter(item => 
      item.name.toLowerCase().includes(searchLower) || 
      item.msg.toLowerCase().includes(searchLower)
    );
  }

  /**
   * 构建标签页项
   * @param label - 标签显示文本
   * @param tabName - 标签标识名称
   */
  @Builder
  buildTabItem(label: string, tabName: string) {
    Column() {
      Text(label)
        .fontSize(18)
        .fontWeight(800)
        .fontColor(this.currentTab === tabName ? '#FFFFFF' : '#999999') // 选中状态使用白色，未选中使用灰色

      // 选中状态下显示下划线
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
      this.currentTab = tabName; // 点击切换标签页
    })
  }

  /**
   * 构建页面UI
   * 包含顶部导航栏、标签页导航、搜索栏和内容区域
   */
  build() {
    Column() {
      // 顶部导航栏
      Row() {
        // 返回按钮
        Text('←')
          .fontSize(24)
          .fontColor('#fff')
          .margin({ left: 16 })
          .onClick(() => {
            router.pushUrl({ url: 'Discover/pages/Discover' }) // 点击返回发现页
              .then(() => console.info('push page success'))
              .catch((err: BusinessError) =>
              console.error(`pushUrl failed, code is ${err.code}, message is ${err.message}`)
              );
          })

        Blank().layoutWeight(1)

        // 页面标题
        Text('消息')
          .fontSize(20)
          .fontColor('#fff')
          .fontWeight(FontWeight.Bold)
          .margin({ right: 16 })

        Blank().layoutWeight(1)

        // 创建消息按钮
        Text('✍️')
          .fontSize(20)
          .margin({ right: 16 })
      }
      .width('100%')
      .height(48)
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#00000')

      // 顶部标签页导航
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
        Text('🔎') // 搜索图标
          .fontSize(20)
          .margin({ left: 12 })

        TextInput({ 
          placeholder: '搜索用户名或聊天记录',
          text: this.searchText 
        })
          .placeholderFont({ size: 14 })
          .placeholderColor('#666666')
          .textAlign(TextAlign.Start)
          .height(36)
          .layoutWeight(1)
          .fontColor('#FFFF')
          .margin({ left: 8, right: 12 })
          .onChange((value: string) => {
            this.searchText = value;
            this.filterMessages(value); // 输入时实时过滤消息
          })

        // 清除搜索文本按钮
        if (this.searchText) {
          Text('✕')
            .fontSize(16)
            .fontColor('#999999')
            .margin({ right: 12 })
            .onClick(() => {
              this.searchText = '';
              this.filterMessages('');
            })
        }
      }
      .borderRadius(18)
      .backgroundColor('#333333')
      .margin({ left: 12, right: 12, top: 8 })

      // 内容区域
      Column() {
        if (this.currentTab === 'private') {
          if (this.searchText && this.filteredMessages.length === 0) {
            // 无搜索结果提示
            Column() {
              Text('未找到相关聊天记录')
                .fontSize(16)
                .fontColor('#999999')
                .margin({ top: 100 })
            }
            .width('100%')
            .height('100%')
          } else {
            // 消息列表
            Scroll() {
              Column() {
                ForEach(this.filteredMessages, (item: PrivateMessageItem) => {
                  Row() {
                    // 用户头像
                    Image(AvatarManager.getUserAvatar(item.id))
                      .width(48)
                      .height(48)
                      .borderRadius(24)
                      .margin({ left: 12, right: 12 })
                      .onClick(()=>{
                        router.pushUrl({url:"Messages/pages/ChatPage"}) // 点击头像跳转到聊天页面
                      })

                    Column() {
                      // 用户名和时间
                      Row() {
                        Text(item.name)
                          .fontSize(16)
                          .fontColor('#FFFF')
                          .layoutWeight(1)

                        Text(item.time)
                          .fontSize(12)
                          .fontColor('#999999')
                      }
                      .width('100%')

                      // 消息内容和未读消息数
                      Row() {
                        Text(item.msg)
                          .fontSize(14)
                          .fontColor('#B2B2B2')
                          .maxLines(1)
                          .layoutWeight(1)

                        // 显示未读消息数
                        if (item.unread > 0) {
                          Text(item.unread.toString())
                            .fontSize(12)
                            .fontColor('#FFFF')
                            .backgroundColor('#FF0000')
                            .borderRadius(8)
                            .padding({ left: 6, right: 6, top: 2, bottom: 2 })
                            .margin({ left: 8 })
                        }
                      }
                      .width('100%')
                      .margin({ top: 4 })
                    }
                    .layoutWeight(1)
                  }
                  .width('100%')
                  .height(72)
                  .border({ width: 0.5, color: '#333333' })
                  .padding({ top: 8, bottom: 8 })
                  .backgroundColor('#00000')
                })
              }
            }
            .width('100%')
          }
        } else if (this.currentTab === 'notice') {
          NotificationsPage() // 显示通知页面
        } else if (this.currentTab === 'mention') {
          MentionsPage() // 显示@提及页面
        } else if (this.currentTab === 'like') {
          CommentsPage() // 显示评论页面
        }
      }
      .width('100%')
      .padding({ top: 16 })
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.Black)
  }
}