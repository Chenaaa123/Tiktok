/**
 * 通知模型类 - 表示系统发送的各类通知
 */
export default class Notification {
  /** 通知唯一标识 */
  id: number;
  /** 通知类型（如 "like", "comment", "follow"） */
  type: string;
  /** 通知内容（如 "用户A点赞了你的动态"） */
  content: string;
  /** 通知时间戳（格式：YYYY-MM-DD HH:mm） */
  time: string;

  /**
   * 构造函数
   * @param id - 通知ID
   * @param type - 通知类型（决定显示样式和交互逻辑）
   * @param content - 通知具体内容
   * @param time - 通知发送时间
   */
  constructor(id: number, type: string, content: string, time: string) {
    this.id = id;
    this.type = type;
    this.content = content;
    this.time = time;
  }
}