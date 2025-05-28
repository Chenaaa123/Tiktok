export interface ConnectionItem {
  avatar: Resource;
  name: string;
  description?: string;
  buttonText?: string;
  buttonColor?: Color;
  buttonBgColor?: Color;
  status?: string;
  unreadWorks?: string;
}

export  interface RouterParams {
  initialTab: number;
}


export const interacList: ConnectionItem[] = [
  {
    avatar: $r('app.media.userA'), // 假设 app.media.7 是飞风头像
    name: '舞蹈达人',
    status: '在线'
  },
  {
    avatar: $r('app.media.userB'), // 假设 app.media.8 是老段头像
    name: '音乐制作人',
    status: '在线'
  },
  {
    avatar: $r('app.media.userC'), // 假设 app.media.9 是修勾走吧头像
    name: '旅行达人',
    status: '做咩也'
  },
  {
    avatar: $r('app.media.userD'), // 假设 app.media.12 是@感恩有你头像
    name: '美食博主',
    status: '昨天在线'
  },


  // ... 添加更多互关数据
];

export const fanslist: ConnectionItem[] = [
  {
    avatar: $r('app.media.userA'),
    name: '搞笑达人',
    description: '有3个共同互关的人',
    buttonText: '回关',
    buttonColor: Color.Gray,
    buttonBgColor: Color.White
  },
  {
    avatar: $r('app.media.userB'),
    name: '健身教练',
    description: '与英子等7人...',
    buttonText: '回关',
    buttonColor: Color.White,
    buttonBgColor: Color.Red
  },
  {
    avatar: $r('app.media.userC'),
    name: '歌手小林',
    description: '与花花等5人互...',
    buttonText: '回关',
    buttonColor: Color.White,
    buttonBgColor: Color.Red
  },
  {
    avatar: $r('app.media.userD'), // 假设 app.media.6 是可可爱爱的牢夏头像
    name: '现代舞团',
    description: '',
    buttonText: '回关',
    buttonColor: Color.Black,
    buttonBgColor: Color.White
  }
  // ... 添加更多粉丝数据
];

export const followingList: ConnectionItem[] = [
  {
    avatar: $r('app.media.userA'), // 假设头像资源
    name: '舞蹈达人',
    buttonText: '关注',
    buttonColor: Color.Black,
    buttonBgColor: Color.White,
  },
  {
    avatar: $r('app.media.userB'), // 假设头像资源
    name: '音乐制作人',
    buttonText: '关注',
    buttonColor: Color.Black,
    buttonBgColor: Color.White,
  },
  {
    avatar: $r('app.media.userC'), // 假设头像资源
    name: '旅行达人',
    buttonText: '关注',
    buttonColor: Color.Black,
    buttonBgColor: Color.White,
  },
  {
    avatar: $r('app.media.userD'), // 假设头像资源
    name: '美食博主 ',
    buttonText: '关注',
    buttonColor: Color.Black,
    buttonBgColor: Color.White,
  },

  // ... 添加更多关注数据
];