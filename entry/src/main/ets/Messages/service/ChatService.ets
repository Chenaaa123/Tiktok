import socket from '@ohos.net.socket';
import util from '@ohos.util'
import { ChatMessage } from '../viewmodel/ChatMessage'
import { BusinessError } from '@kit.BasicServicesKit';

// 事件监听器类型定义
type MessageListener = (message: ChatMessage) => void
type StatusListener = () => void;
type ErrorListener = (err: Error) => void;

export class ChatService {
  private client: socket.TCPSocket | null = null;
  private serverAddress: string = ''
  private serverPort: number = 8080;
  private connected: boolean = false;
  private buffer: string = '' // 用于处理分片消息

  // 事件处理器
  private messageListeners: MessageListener[] = []
  private connectListeners: StatusListener[] = []
  private disconnectListeners: StatusListener[] = []
  private errorListeners: ErrorListener[] = []

  // 添加消息监听器
  public onMessage(listener: MessageListener): void {
    this.messageListeners.push(listener)
  }

  // 添加连接状态监听器
  public onConnect(listener: StatusListener): void {
    this.connectListeners.push(listener)
  }

  // 添加断开连接监听器
  public onDisconnect(listener: StatusListener): void {
    this.disconnectListeners.push(listener)
  }

  // 添加错误监听器
  public onError(listener: ErrorListener): void {
    this.errorListeners.push(listener)
  }

  // 触发消息事件
  private triggerMessageEvent(message: ChatMessage): void {
    this.messageListeners.forEach(listener => listener(message))
  }

  // 触发连接事件
  private triggerConnectEvent(): void {
    this.connectListeners.forEach(listener => listener())
  }

  // 触发断开连接事件
  private triggerDisconnectEvent(): void {
    this.disconnectListeners.forEach(listener => listener())
  }

  // 触发错误事件
  private triggerErrorEvent(error: Error): void {
    this.errorListeners.forEach(listener => listener(error))
  }

  // 连接到聊天服务器
  public connect(serverAddress: string, serverPort: number = 8080): Promise<void> {
    return new Promise((resolve, reject) => {
      if (this.connected) {
        resolve();
        return;
      }

      this.serverAddress = serverAddress;
      this.serverPort = serverPort;

      //
      // let tcpSocketServer = socket.constructTCPSocketServerInstance(); // 服务端
      this.client = socket.constructTCPSocketInstance(); // 客户端

      // 监听断开
      this.client.on('close', (data) => {

      })
      // 监听连接
      this.client.on('connect', (data) => {
        console.debug(``);
      })

      // 监听消息
      this.client.on('message', (data) => {
        try {
          const messageStr = this.arrayBufferToString(data.message);

          // 追加到缓冲区处理分片消息
          this.buffer += messageStr;

          // 按换行符分割多条消息
          let endIndex = -1;
          while ((endIndex = this.buffer.indexOf('\n')) !== -1) {
            const jsonStr = this.buffer.substring(0, endIndex);
            this.buffer = this.buffer.substring(endIndex + 1);

            const message = JSON.parse(jsonStr) as ChatMessage;
            this.triggerMessageEvent(message);
          }
        } catch (err) {
          console.error('解析消息失败:', err);
        }
      });

      // 监听连接关闭
      this.client.on('close', () => {
        this.connected = false;
        this.triggerDisconnectEvent();
      });

      // 监听错误
      this.client.on('error', (err) => {
        console.error('聊天客户端错误:', JSON.stringify(err));
        this.triggerErrorEvent(new Error(JSON.stringify(err)));
      });

      // 连接服务器
      this.client.connect({
        address: {
          address: this.serverAddress,
          port: this.serverPort
        },
        timeout: 6000
      }).then(() => {
        this.connected = true;
        this.triggerConnectEvent();
        resolve();
      }).catch((err: BusinessError) => {
        console.error('连接聊天服务器失败:', JSON.stringify(err));
        this.client = null;
        reject(err);
      });
    });
  }

  // 发送消息
  public sendMessage(content: string): Promise<void> {
    if (!this.client || !this.connected) {
      return Promise.reject(new Error('未连接到聊天服务器'));
    }

    const message: ChatMessage = {
      type: 'text',
      content: content
    };

    // 发送消息，添加换行符作为消息分隔符
    return this.client.send({
      data: JSON.stringify(message) + '\n'
    });
  }

  //  aboutToAppear():void{
  //
  //   八卦内容= await this.callPhone()
  //
  // }

  // async await
  // 打电话聊八卦
  // async callPhone():Promise<string>{
  //      return new Promise((resolve,reject)=>{
  //          if(电话打欠费了){
  //              reject(err)
  //          }else{
  //              resolve(八卦)
  //          }
  //      })
  // }
  // 异步逻辑 通过 async 关键可以同步的方式编写
  // 通过await来等待异步执行结果

  // 断开连接
  public disconnect(): Promise<void> {
    if (!this.client || !this.connected) {
      return Promise.resolve();
    }

    // 断开连接的api是不是就用起来了
    return this.client.close().then(() => {
      this.client = null;
      this.connected = false;
    });
  }

  // 获取连接状态
  public isConnected(): boolean {
    return this.connected;
  }

  // ArrayBuffer转字符串
  private arrayBufferToString(buffer: ArrayBuffer): string {
    const textDecoder = util.TextDecoder.create('utf-8');
    return textDecoder.decodeWithStream(new Uint8Array(buffer));
  }
}