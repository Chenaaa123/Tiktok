// 聊天记录
export interface ChatMessage {
  type: 'text' | 'system' | 'image'; // 发送的内容的类型
  content: string // 发送的具体内容
  sender?: number | string // 发送方的身份表示 1 客户端ID1  server 可能就是服务端
  time?: number // 发送消息时间

}
