export interface PrivateMessage {
  id: number; // 唯一标识（主键）
  name: string; // 会话对象姓名/用户名
  msg: string; // 最新消息内容
  unread: number; // 未读消息数量（0表示已读）
  comments: Comment[]; // 消息附带的评论列表（可选扩展字段）
  time: string; // 最新消息时间戳（如："2025-05-26 14:30"）
}


export interface Comment {
  id: number; // 评论唯一标识
  user: string; // 评论者姓名/用户名
  content: string; // 评论内容
  time: string; // 评论时间戳（如："2025-05-26 14:35"）
}

export interface Mention {
  id: number; // 提及记录唯一标识
  user: string; // 提及者姓名/用户名
  content: string; // 提及内容（如："@你 这条动态很棒！"）
  time: string; // 提及时间戳（如："2025-05-26 14:40"）
}

