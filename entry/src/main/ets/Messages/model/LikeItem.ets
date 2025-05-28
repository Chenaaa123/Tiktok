/**
 * 点赞模型类 - 表示用户的点赞记录
 */
export default class Like {
  /** 点赞记录唯一标识 */
  id: number;
  /** 点赞用户姓名/用户名 */
  user: string;
  /** 点赞内容（可选扩展字段，如动态内容摘要） */
  content: string;
  /** 点赞时间戳（格式：YYYY-MM-DD HH:mm） */
  time: string;

  /**
   * 构造函数
   * @param id - 点赞记录ID
   * @param user - 点赞用户
   * @param content - 点赞关联的内容（如动态文本）
   * @param time - 点赞时间
   */
  constructor(id: number, user: string, content: string, time: string) {
    this.id = id;
    this.user = user;
    this.content = content;
    this.time = time;
  }
}