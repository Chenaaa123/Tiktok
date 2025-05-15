import User from "./UserItem";

// 定义推荐内容接口
export default class  RecommendItem {
  id: number;
  coverImage: Resource;
  title: string;
  author: User;
  viewCount: number;

  constructor(id: number,coverImage: Resource,title: string,author: User,viewCount: number) {
    this.id = id
    this.coverImage = coverImage
    this.title = title
    this.author = author
    this.viewCount = viewCount
  }
}