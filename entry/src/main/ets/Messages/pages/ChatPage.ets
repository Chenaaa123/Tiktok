// ChatPage.ets
import { ChatService } from '../service/ChatService';
import {ChatMessage} from '../viewmodel/ChatMessage'
import promptAction from '@ohos.promptAction';
import { BusinessError } from '@kit.BasicServicesKit';
import router from '@ohos.router';
import { MessageStorage } from '../model/MessageStorage';
import common from '@ohos.app.ability.common';

@Entry
@Component
struct ChatPage {
  @State messages: ChatMessage[] = [];
  @State inputText: string = '';
  @State isConnected: boolean = false;
  @State serverAddress: string = '10.0.2.2'; // 模拟器默认连接主机的IP
  @State serverPort: number = 8080;
  @State loadingStatus: string = '';
  @State isTyping: boolean = false;
  private selfs: boolean[] = []
  private chatService: ChatService = new ChatService();
  private scroller: Scroller = new Scroller();
  // 头像资源池
  private avatarPool: Resource[] = [
    $r('app.media.userA'),
    $r('app.media.userB'),
    $r('app.media.userC'),
    $r('app.media.userD')
  ];
  // 用户头像映射表
  private userAvatars: Map<string, Resource> = new Map();
  // 已使用的头像索引
  private usedAvatarIndices: Set<number> = new Set();
  // 使用现有的头像资源
  private defaultAvatar: Resource = $r('app.media.avatar_1');
  private selfAvatar: Resource = $r('app.media.avatar_2');

  // 获取用户头像
  private getUserAvatar(sender: number | string | undefined): Resource {
    if (sender === undefined) {
      return this.selfAvatar;
    }

    // 将sender转换为字符串作为key
    const senderKey = sender.toString();

    // 如果用户已经有头像，直接返回
    const existingAvatar = this.userAvatars.get(senderKey);
    if (existingAvatar !== undefined) {
      return existingAvatar;
    }

    // 获取一个未使用的头像
    let availableIndices: number[] = [];
    for (let i = 0; i < this.avatarPool.length; i++) {
      if (!this.usedAvatarIndices.has(i)) {
        availableIndices.push(i);
      }
    }

    // 如果所有头像都被使用了，重置使用状态
    if (availableIndices.length === 0) {
      this.usedAvatarIndices.clear();
      availableIndices = [];
      for (let i = 0; i < this.avatarPool.length; i++) {
        availableIndices.push(i);
      }
    }

    // 随机选择一个可用头像
    const randomIndex = availableIndices[Math.floor(Math.random() * availableIndices.length)];
    const selectedAvatar = this.avatarPool[randomIndex];

    // 记录使用情况
    this.usedAvatarIndices.add(randomIndex);
    this.userAvatars.set(senderKey, selectedAvatar);

    return selectedAvatar;
  }

  async aboutToAppear() {
    // 设置 MessageStorage 的上下文
    MessageStorage.setContext(getContext(this) as common.UIAbilityContext);

    // 加载保存的消息
    const savedMessages = await MessageStorage.getMessages();
    this.messages = savedMessages;
    // 初始化selfs数组
    this.selfs = savedMessages.map(msg => msg.sender === undefined);

    // 监听消息接收事件
    this.chatService.onMessage((message: ChatMessage) => {
      this.messages.push(message);
      this.selfs.push(message.sender === undefined);
      // 保存消息
      MessageStorage.saveMessages(this.messages);
      // 保证UI更新后滚动到最新消息
      setTimeout(() => {
        this.scroller.scrollToIndex(this.messages.length - 1);
      }, 100);
    });

    // 监听连接状态变化
    this.chatService.onConnect(() => {
      this.isConnected = true;
      this.loadingStatus = '';

      // 添加连接成功消息
      promptAction.showToast({
        message: '已连接到服务器',
        duration: 2000
      });
    });

    this.chatService.onDisconnect(() => {
      this.isConnected = false;

      // 添加断开连接消息
      this.messages.push({
        type: 'system',
        content: '已断开与服务器的连接'
      });
      // 保存消息
      MessageStorage.saveMessages(this.messages);

      promptAction.showToast({
        message: '已断开连接',
        duration: 2000
      });
    });

    this.chatService.onError((error) => {
      this.loadingStatus = '';
      promptAction.showToast({
        message: '发生错误: ' + error.message,
        duration: 3000
      });
    });
  }

  // 连接服务器
  async connectToServer() {
    if (this.isConnected) {
      return;
    }

    this.loadingStatus = '正在连接...';

    try {
      await this.chatService.connect(this.serverAddress, this.serverPort);
      // 连接成功的处理已经在 onConnect 回调中处理
    } catch (error) {
      this.loadingStatus = '';
      const errorMessage = error instanceof Error ? error.message : '未知错误';
      promptAction.showDialog({
        title: '连接失败',
        message: errorMessage,
        buttons: [
          {
            text: '确定',
            color: '#0000ff',
          }
        ]
      });
    }
  }

  // 断开连接
  async disconnectFromServer() {
    if (!this.isConnected) {
      return;
    }

    try {
      await this.chatService.disconnect();
      // 断开连接后清除消息
      await MessageStorage.clearMessages();
      this.messages = [];
      this.selfs = [];
    } catch (error) {
      const errorMessage = error instanceof Error ? error.message : '未知错误';
      promptAction.showToast({
        message: '断开连接失败: ' + errorMessage,
        duration: 3000
      });
    }
  }

  // 发送消息
  async sendMessage() {
    if (!this.inputText.trim() || !this.isConnected) {
      return;
    }

    try {
      await this.chatService.sendMessage(this.inputText.trim());
      // 清空输入框
      this.inputText = '';
    } catch (error) {
      const errorMessage = error instanceof Error ? error.message : '未知错误';
      promptAction.showToast({
        message: '发送消息失败: ' + errorMessage,
        duration: 3000
      });
    }
  }

  build() {
    Column() {
      // 标题栏
      Row() {
        // 返回按钮
        Row() {
          // Text('←')
          //   .fontSize(28)
          //   .fontWeight(FontWeight.Bold)
          //   .fontColor('#333333')
          //   .margin({ right: 16 })
          //   .onClick(() => {router.back()})
          Row() {
            Text('💬')
              .fontSize(24)
              .margin({ right: 12 })
              .onClick(() => {router.back()})
            Text('实时聊天')
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor('#333333')
          }
          .alignItems(VerticalAlign.Center)
        }
        .alignItems(VerticalAlign.Center)

        Blank()
        if (this.loadingStatus) {
          Row() {
            LoadingProgress()
              .width(16)
              .height(16)
              .margin({ right: 8 })
            Text(this.loadingStatus)
              .fontSize(14)
              .fontColor('#666666')
          }
        } else {
          Row() {
            Circle()
              .width(8)
              .height(8)
              .fill(this.isConnected ? '#4CAF50' : '#FF5252')
              .margin({ right: 6 })
            Text(this.isConnected ? '已连接' : '未连接')
              .fontSize(14)
              .fontColor(this.isConnected ? '#4CAF50' : '#FF5252')
          }
        }
      }
      .width('100%')
      .height(64)
      .padding({ left: 20, right: 20 })
      .backgroundColor('#1A1A1A')
      .shadow({ radius: 8, color: '#1A000000', offsetY: 2 })

      // 服务器设置
      Column() {
        Row() {
          Text('服务器:').fontSize(16).fontColor('#FFFFFF')
          TextInput({ text: this.serverAddress })
            .width('30%')
            .height(40)
            .margin({ left: 8, right: 8 })
            .backgroundColor('#2A2A2A')
            .borderRadius(8)
            .padding({ left: 12, right: 12 })
            .fontColor('#FFFFFF')
            .onChange((value) => {
              this.serverAddress = value;
            })
          Text('端口:').fontSize(16).fontColor('#FFFFFF')
          TextInput({ text: this.serverPort.toString() })
            .width('30%')
            .height(40)
            .margin({ left: 8 })
            .backgroundColor('#2A2A2A')
            .borderRadius(8)
            .padding({ left: 12, right: 12 })
            .fontColor('#FFFFFF')
            .onChange((value) => {
              this.serverPort = parseInt(value);
            })
        }
        .width('100%')
        .padding({ left: 20, right: 20, top: 16, bottom: 16 })
        .backgroundColor('#1A1A1A')

        Button(this.isConnected ? '断开连接' : '连接服务器')
          .width('90%')
          .height(48)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .borderRadius(24)
          .backgroundColor(this.isConnected ? '#FF5252' : '#4CAF50')
          .onClick(() => {
            if (this.isConnected) {
              this.disconnectFromServer();
            } else {
              this.connectToServer();
            }
          })
          .margin({ bottom: 16 })
      }
      .width('100%')
      .backgroundColor('#1A1A1A')

      // 消息列表
      List({ scroller: this.scroller }) {
        ForEach(this.messages, (message: ChatMessage, index) => {
          ListItem() {
            this.MessageBubble(message, index)
          }
        }, (message: ChatMessage, index) => index.toString())
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .backgroundColor('#1A1A1A')

      // 输入区域
      Column() {
        if (this.isTyping) {
          Text('对方正在输入...')
            .fontSize(12)
            .fontColor('#999999')
            .margin({ left: 16, bottom: 4 })
        }

        Row() {
          TextInput({
            placeholder: '输入消息...',
            text: this.inputText
          })
            .layoutWeight(1)
            .height(48)
            .backgroundColor('#2A2A2A')
            .borderRadius(24)
            .padding({ left: 20, right: 20 })
            .placeholderColor('#999999')
            .fontSize(16)
            .fontColor('#FFFFFF')
            .onChange((value) => {
              this.inputText = value;
              this.isTyping = value.length > 0;
            })
            .onSubmit(() => {
              this.sendMessage();
              return true;
            })

          Button('发送')
            .height(48)
            .width(80)
            .margin({ left: 12 })
            .borderRadius(24)
            .backgroundColor('#4CAF50')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .onClick(() => {
              this.sendMessage();
            })
            .enabled(this.isConnected && this.inputText.trim().length > 0)
            .opacity(this.isConnected && this.inputText.trim().length > 0 ? 1.0 : 0.5)
        }
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .backgroundColor('#1A1A1A')
      .shadow({ radius: 8, color: '#1A000000', offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#1A1A1A')
  }

  @Builder
  MessageBubble(message: ChatMessage, index: number) {
    if (message.type === 'system') {
      // 系统消息居中显示
      Text(message.content)
        .fontSize(14)
        .fontColor('#CCCCCC')
        .maxLines(10)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .textAlign(TextAlign.Center)
        .width('90%')
        .padding(12)
        .margin({ top: 8, bottom: 8 })
        .borderRadius(16)
        .backgroundColor('#2A2A2A')
    } else {
      Row() {
        if (!this.selfs[index]) {
          // 接收者头像
          Image(this.getUserAvatar(message.sender))
            .width(40)
            .height(40)
            .borderRadius(20)
            .margin({ right: 8 })
            .objectFit(ImageFit.Cover)
        }

        Column() {
          if (!this.selfs[index] && message.sender !== undefined) {
            Text(`用户 ${message.sender}`)
              .fontSize(12)
              .fontColor('#CCCCCC')
              .alignSelf(this.selfs[index] ? ItemAlign.End : ItemAlign.Start)
              .margin({ bottom: 4 })
          }

          Text(message.content)
            .fontSize(16)
            .maxLines(100)
            .padding(16)
            .borderRadius(20)
            .backgroundColor(this.selfs[index] ? '#4CAF50' : '#2A2A2A')
            .fontColor(this.selfs[index] ? '#FFFFFF' : '#FFFFFF')
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
        }
        .alignItems(this.selfs[index] ? HorizontalAlign.End : HorizontalAlign.Start)
        .width('70%')

        if (this.selfs[index]) {
          // 发送者头像
          Image(this.selfAvatar)
            .width(40)
            .height(40)
            .borderRadius(20)
            .margin({ left: 8 })
            .objectFit(ImageFit.Cover)
        }
      }
      .width('100%')
      .margin({ top: 12, bottom: 12 })
      .justifyContent(this.selfs[index] ? FlexAlign.End : FlexAlign.Start)
      .alignItems(VerticalAlign.Top)
    }
  }
}