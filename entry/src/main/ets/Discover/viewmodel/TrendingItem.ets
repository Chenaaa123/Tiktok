// 发现热门内容
export default class  TrendingItem {
  id: number
  category: string  // 类别
  title: string
  likes: string    // 点赞
  comments: string    // 评论
  author: string   // 作者
  duration: string    // 时长
  thumbnail: ResourceStr   // 缩略图图片
  avatar: ResourceStr    // 头像图片

  constructor(id: number,category: string,title: string,likes: string,
    comments: string,author: string,duration: string,thumbnail: ResourceStr,avatar: ResourceStr) {
    this.id = id
    this.category = category
    this.title = title
    this.likes = likes
    this.comments = comments
    this.author = author
    this.duration = duration
    this.thumbnail = thumbnail
    this.avatar = avatar
  }
}

