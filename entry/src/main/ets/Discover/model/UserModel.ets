import User from '../viewmodel/UserItem';

// 创建用户数据数组
const users: User[] = [
  new User(1, '舞蹈达人', $r('app.media.userA'), '826万粉丝', '312视频', '专业舞者，街舞教学，每周更新舞蹈教程', ['街舞', '教学'], 'dance', false),
  new User(2, '音乐制作人', $r('app.media.userB'), '427万粉丝', '186视频', '电子音乐制作，原创音乐分享，乐器演奏', ['电子音乐', '制作教程'], 'music', false),
  new User(3, '旅行达人', $r('app.media.userC'), '356万粉丝', '254视频', '探索世界各地，分享旅行攻略和美景', ['旅行', '攻略'], 'travel', false),
  new User(4, '美食博主', $r('app.media.userD'), '512万粉丝', '378视频', '家常菜教程，美食探店，烹饪技巧分享', ['美食', '烹饪'], 'food', false),
  new User(5, '搞笑达人', $r('app.media.userA'), '763万粉丝', '426视频', '原创搞笑短剧，生活喜剧，日常趣事', ['搞笑', '喜剧'], 'comedy', false),
  new User(6, '健身教练', $r('app.media.userB'), '412万粉丝', '256视频', '家庭健身教程，健康饮食，塑形减脂指南', ['健身', '减脂'], 'fitness', false),
  new User(7, '歌手小林', $r('app.media.userC'), '328万粉丝', '178视频', '原创歌曲，翻唱作品，音乐分享', ['唱歌', '原创'], 'music', false),
  new User(8, '现代舞团', $r('app.media.userD'), '247万粉丝', '134视频', '现代舞编排，舞蹈表演，舞台幕后', ['现代舞', '表演'], 'dance', false)

];
export {users}

//   {
//     id: 1,
//     name: '舞蹈达人',
//     avatar: 'media/images/profile1.jpg',
//     fans: '826万粉丝',
//     videos: '312视频',
//     description: '专业舞者，街舞教学，每周更新舞蹈教程',
//     tags: ['街舞', '教学'],
//     category: 'dance',
//     followed: false
//   },

