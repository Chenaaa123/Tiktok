// 发现热门内容
export default class  TrendingItem {
  id: number
  category: string  // 类别
  introduce: string  // 简介
  title: string     // 标题
  likes: string    // 点赞
  comments: string    // 评论
  author: string   // 作者
  duration: string    // 时长
  thumbnail: ResourceStr   // 缩略图图片
  avatar: ResourceStr    // 头像图片
  content:string   // 视频或者音频

  constructor(id: number,category: string,introduce: string,title: string,likes: string,
    comments: string,author: string,duration: string,thumbnail: ResourceStr,avatar: ResourceStr,content:string) {
    this.id = id
    this.category = category
    this.introduce = introduce
    this.title = title
    this.likes = likes
    this.comments = comments
    this.author = author
    this.duration = duration
    this.thumbnail = thumbnail
    this.avatar = avatar
    this.content = content
  }
}

