export default class  PrivateMessage {
  id: number
  name: string
  msg: string
  unread: number
  time: string

  constructor(  id: number,name: string,msg: string,
    unread: number, time: string) {
    this.id = id
    this.name = name
    this.msg = msg
    this.unread = unread
    this.time = time
  }
}