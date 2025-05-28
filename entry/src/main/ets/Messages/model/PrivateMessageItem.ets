/**
 * 私信模型类 - 表示用户间的一对一消息会话
 */
export default class PrivateMessage {
  /** 消息唯一标识 */
  id: number;
  /** 发送方/接收方用户名 */
  name: string;
  /** 消息内容 */
  msg: string;
  /** 未读消息数量（0表示已读） */
  unread: number;
  /** 消息时间戳（格式：YYYY-MM-DD HH:mm） */
  time: string;

  /**
   * 构造函数
   * @param id - 消息ID
   * @param name - 对方用户名
   * @param msg - 消息文本内容
   * @param unread - 未读计数（用于会话列表显示）
   * @param time - 消息发送时间
   */
  constructor(id: number, name: string, msg: string, unread: number, time: string) {
    this.id = id;
    this.name = name;
    this.msg = msg;
    this.unread = unread;
    this.time = time;
  }
}