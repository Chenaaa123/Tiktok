// 定义用户接口
export default class  User{
  id : number
  avatar: Resource;   // 头像
  username: string;   // 用户名

  constructor(id : number,avatar: Resource,username: string) {
    this.id = id
    this.avatar = avatar
    this.username = username
  }
}