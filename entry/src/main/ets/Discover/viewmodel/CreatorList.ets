import creator from '../model/CreatorItem';

// 创建用户数据数组
const CreatorList: creator[] = [
  new creator(1, '舞蹈达人', $r('app.media.userA'), '826万', '312视频', '专业舞者，街舞教学，每周更新舞蹈教程', ['街舞', '教学'], 'dance', false,"wudaodaren",100,200),
  new creator(2, '音乐制作人', $r('app.media.userB'), '427万', '186视频', '电子音乐制作，原创音乐分享，乐器演奏', ['电子音乐', '制作教程'], 'music', false,"yinyuezhizuoshe",200,300),
  new creator(3, '旅行达人', $r('app.media.userC'), '356万', '254视频', '探索世界各地，分享旅行攻略和美景', ['旅行', '攻略'], 'travel', false,"lvxingdaren",300,400),
  new creator(4, '美食博主', $r('app.media.userD'), '512万', '378视频', '家常菜教程，美食探店，烹饪技巧分享', ['美食', '烹饪'], 'food', false, "meishidaren",400,500),
  new creator(5, '搞笑达人', $r('app.media.userA'), '763万', '426视频', '原创搞笑短剧，生活喜剧，日常趣事', ['搞笑', '喜剧'], 'comedy', false, "gaoxiao",500,600),
  new creator(6, '健身教练', $r('app.media.userB'), '412万', '256视频', '家庭健身教程，健康饮食，塑形减脂指南', ['健身', '减脂'], 'fitness', false, "jianshen",600,700),
  new creator(7, '歌手小林', $r('app.media.userC'), '328万', '178视频', '原创歌曲，翻唱作品，音乐分享', ['唱歌', '原创'], 'music', false, "gege",700,800),
  new creator(8, '现代舞团', $r('app.media.userD'), '247万', '134视频', '现代舞编排，舞蹈表演，舞台幕后', ['现代舞', '表演'], 'dance', false, "xiandao",800,900)

];
export {CreatorList}

 //通过用户名查找用户信息
export function getUserByUsername(name: string): creator | null {
  return CreatorList.find(user => user.name === name) || null;
}
 // 通过分类查找用户信息
export function getCreatorsByCategory(category: string): creator[] {
  return CreatorList.filter(creator => creator.category === category);
}

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

