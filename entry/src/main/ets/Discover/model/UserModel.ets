import User from '../viewmodel/UserItem';

// 创建用户数据数组
const users: User[] = [
  new User(0,$r('app.media.userA'),'舞蹈达人'),
  new User(1,$r('app.media.userB'),'音乐制作人'),
  new User(2,$r('app.media.userC'),'旅行达人'),
  new User(3,$r('app.media.userD'),'美食博主'),
];
export {users}