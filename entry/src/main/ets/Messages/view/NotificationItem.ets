
export default class Notification {
  id: number;
  type: string;
  content: string;
  time: string;

  constructor(  id: number,type: string,content: string, time: string) {
    this.id = id
    this.type = type
    this.content = content
    this.time = time
  }
}