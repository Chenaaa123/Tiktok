// 定义用户接口
export default class creator {
  id: number        // 用户id
  name: string      // 用户名
  avatar: Resource  // 用户头像
  fans: string      // 粉丝数
  videos: string    // 视频数
  description: string   // 用户简介
  tags: Array<string>   // 用户标签
  category: string      // 用户分类
  followed: boolean    // 是否关注
  accountId: string     // 用户账号ID
  attention: number     // 关注数
  likes: number       // 点赞数

  constructor(id: number, name: string, avatar: Resource, fans: string, videos: string,
    description: string, tags: Array<string>, category: string, followed: boolean,accountId: string,attention: number, likes: number) {
    this.id = id
    this.name = name
    this.avatar = avatar
    this.fans = fans
    this.videos = videos
    this.description = description
    this.tags = tags
    this.category = category
    this.followed = followed
    this.accountId = accountId
    this.attention = attention
    this.likes = likes
  }
}

