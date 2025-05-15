// 定义用户接口
export default class creator {
  id: number
  name: string
  avatar: Resource
  fans: string
  videos: string
  description: string
  tags: Array<string>
  category: string
  followed: boolean

  constructor(id: number, name: string, avatar: Resource, fans: string, videos: string,
    description: string, tags: Array<string>, category: string, followed: boolean) {
    this.id = id
    this.name = name
    this.avatar = avatar
    this.fans = fans
    this.videos = videos
    this.description = description
    this.tags = tags
    this.category = category
    this.followed = followed
  }
}

