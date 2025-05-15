
export default class  Like {
  id: number;
  user: string;
  content: string;
  time: string;

  constructor(  id: number,user: string,content: string, time: string) {
  this.id = id
  this.user = user
  this.content = content
  this.time = time
}
}