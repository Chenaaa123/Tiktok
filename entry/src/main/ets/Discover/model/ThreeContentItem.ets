import creator from "./CreatorItem";

export default class ThreeContentItem {
  id: number;
  name:string;
  cover: Resource;
  like: string;

  constructor(id: number,name:string,cover: Resource, like: string) {
    this.id = id
    this.name = name
    this.cover = cover
    this.like = like
  }
}