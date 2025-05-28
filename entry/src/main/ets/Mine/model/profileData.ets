export interface ContentItem {
  cover: Resource;
  likes: string;
}

export interface TabData {
  title: string;
  type: string;
  list: ContentItem[];
}

export interface GeneratedType{
  name: string;
  brief: string;
  avatar: Resource;
}

export const profileTabsData: TabData[] = [
  {
    title: '作品',
    type: 'videos',
    list: [
      { cover: $r('app.media.RecommendItemA'), likes: '88.6万' },
      { cover: $r('app.media.RecommendItemC'), likes: '482.6万' },
      { cover: $r('app.media.pixels'), likes: '88.6万' },
      { cover: $r('app.media.RecommendItemB'), likes: '88.6万' }
    ]
  },
  {
    title: '喜欢',
    type: 'likes',
    list: [
      { cover: $r('app.media.RecommendItemC'), likes: '66.6万' },
      { cover: $r('app.media.pixels'), likes: '44.6万' }
    ]
  },
  {
    title: '收藏',
    type: 'favorites',
    list: [
      { cover: $r('app.media.pixels'), likes: '412.6万' },
      { cover: $r('app.media.RecommendItemA'), likes: '432.6万' },
      { cover: $r('app.media.pixels'), likes: '442.6万' }
    ]
  },
  {
    title: '历史',
    type: 'history',
    list: [
      { cover: $r('app.media.RecommendItemB'), likes: '60.6万' }
    ]
  }
];

export interface UserProfile {
  name: string;
  brief: string;
  avatar: Resource;
  following: number;
  followers: number;
  likes: number;
}

export const defaultProfile: UserProfile = {
  name: '用户昵称',
  brief: '这是个人简介，分享你的生活态度和个性',
  avatar: $r('app.media.userD'),
  following: 168,
  followers: 286,
  likes: 42
};

export interface RouteParams {
  name?: string;
  brief?: string;
  avatar?: Resource;
}
