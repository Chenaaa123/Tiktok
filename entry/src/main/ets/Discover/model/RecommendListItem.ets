import creator from "./CreatorItem";

// 定义推荐内容接口
export default class  RecommendItem {
  id: number;
  coverImage: Resource;
  title: string;
  author: creator;
  viewCount: number;

  constructor(id: number,coverImage: Resource,title: string,author: creator,viewCount: number) {
    this.id = id
    this.coverImage = coverImage
    this.title = title
    this.author = author
    this.viewCount = viewCount
  }
}