import preferences from '@ohos.data.preferences';
import { Comment } from './DataModel';
import common from '@ohos.app.ability.common';

// Define initial comment data
const initialV001Comments: Comment[] = [
  {
    id: 'c1',
    author: '旅行爱好者',
    avatar: $r('app.media.avatar_1'),
    content: '夕阳真的太美了，让人心旷神怡！',
    time: '2分钟前',
    likes: 128,
    isLiked: false
  },
  {
    id: 'r1',
    author: '摄影达人',
    avatar: $r('app.media.avatar_2'),
    content: '拍摄角度选得真好，光线也很完美！',
    time: '1分钟前',
    likes: 5,
    isLiked: false,
    parentId: 'c1',
    parentAuthor: '旅行爱好者',
    isReply: true
  },
  {
    id: 'c2',
    author: '自然爱好者',
    avatar: $r('app.media.avatar_3'),
    content: '这个夕阳的颜色太梦幻了，请问是在哪里拍摄的？',
    time: '5分钟前',
    likes: 89,
    isLiked: false
  },
  {
    id: 'r2',
    author: '旅行达人',
    avatar: $r('app.media.avatar_1'),
    content: '在海南三亚的海边拍的，傍晚的景色特别美！',
    time: '4分钟前',
    likes: 12,
    isLiked: false,
    parentId: 'c2',
    parentAuthor: '自然爱好者',
    isReply: true
  }
];

const initialV002Comments: Comment[] = [
  {
    id: 'c1',
    author: '骑行爱好者',
    avatar: $r('app.media.avatar_1'),
    content: '这段路我也骑过，风景确实很棒！',
    time: '3分钟前',
    likes: 98,
    isLiked: false
  },
  {
    id: 'r1',
    author: '运动达人',
    avatar: $r('app.media.avatar_2'),
    content: '下次可以约着一起骑！',
    time: '2分钟前',
    likes: 12,
    isLiked: false,
    parentId: 'c1',
    parentAuthor: '骑行爱好者',
    isReply: true
  },
  {
    id: 'c2',
    author: '户外探险家',
    avatar: $r('app.media.avatar_3'),
    content: '请问这条路线大概多少公里？适合新手吗？',
    time: '6分钟前',
    likes: 45,
    isLiked: false
  },
  {
    id: 'r2',
    author: '运动达人',
    avatar: $r('app.media.avatar_2'),
    content: '全程约30公里，坡度适中，新手也可以尝试！',
    time: '5分钟前',
    likes: 23,
    isLiked: false,
    parentId: 'c2',
    parentAuthor: '户外探险家',
    isReply: true
  }
];

const initialV003Comments: Comment[] = [
  {
    id: 'c1',
    author: '城市探索者',
    avatar: $r('app.media.avatar_1'),
    content: '夜景拍得太美了，城市的另一面！',
    time: '4分钟前',
    likes: 156,
    isLiked: false
  },
  {
    id: 'c2',
    author: '摄影师',
    avatar: $r('app.media.avatar_2'),
    content: '构图很专业，光线处理得也很好！',
    time: '2分钟前',
    likes: 89,
    isLiked: false
  },
  {
    id: 'c3',
    author: '夜生活爱好者',
    avatar: $r('app.media.avatar_3'),
    content: '这个角度拍出来的夜景太震撼了，请问是用什么相机拍的？',
    time: '7分钟前',
    likes: 67,
    isLiked: false
  }
];

const initialV004Comments: Comment[] = [
  {
    id: 'c1',
    author: '雨景爱好者',
    avatar: $r('app.media.avatar_1'),
    content: '雨中的城市别有一番韵味！',
    time: '5分钟前',
    likes: 112,
    isLiked: false
  },
  {
    id: 'r1',
    author: '文艺青年',
    avatar: $r('app.media.avatar_2'),
    content: '让我想起了那首《雨巷》',
    time: '3分钟前',
    likes: 45,
    isLiked: false,
    parentId: 'c1',
    parentAuthor: '雨景爱好者',
    isReply: true
  },
  {
    id: 'c2',
    author: '摄影爱好者',
    avatar: $r('app.media.avatar_3'),
    content: '雨滴的质感拍得真好，请问是用什么镜头拍的？',
    time: '8分钟前',
    likes: 78,
    isLiked: false
  }
];

const initialV005Comments: Comment[] = [
  {
    id: 'c1',
    author: '美食家',
    avatar: $r('app.media.avatar_1'),
    content: '这些美食看起来太诱人了！',
    time: '6分钟前',
    likes: 234,
    isLiked: false
  },
  {
    id: 'c2',
    author: '吃货',
    avatar: $r('app.media.avatar_2'),
    content: '口水都要流出来了，好想去尝尝！',
    time: '4分钟前',
    likes: 167,
    isLiked: false
  },
  {
    id: 'c3',
    author: '美食博主',
    avatar: $r('app.media.avatar_3'),
    content: '请问这些美食是在哪家店拍的？看起来太精致了！',
    time: '9分钟前',
    likes: 145,
    isLiked: false
  }
];

const initialV006Comments: Comment[] = [
  {
    id: 'c1',
    author: '旅行达人',
    avatar: $r('app.media.avatar_1'),
    content: '这些地方我都去过，确实很美！',
    time: '7分钟前',
    likes: 189,
    isLiked: false
  },
  {
    id: 'r1',
    author: '背包客',
    avatar: $r('app.media.avatar_2'),
    content: '能分享一下具体的路线吗？',
    time: '5分钟前',
    likes: 78,
    isLiked: false,
    parentId: 'c1',
    parentAuthor: '旅行达人',
    isReply: true
  },
  {
    id: 'c2',
    author: '摄影爱好者',
    avatar: $r('app.media.avatar_3'),
    content: '风景太美了，请问是用什么相机拍的？',
    time: '10分钟前',
    likes: 123,
    isLiked: false
  }
];

const initialV007Comments: Comment[] = [
  {
    id: 'c1',
    author: '音乐爱好者',
    avatar: $r('app.media.avatar_1'),
    content: '现场氛围太棒了！',
    time: '8分钟前',
    likes: 145,
    isLiked: false
  },
  {
    id: 'c2',
    author: '乐迷',
    avatar: $r('app.media.avatar_2'),
    content: '音质很好，表演也很精彩！',
    time: '6分钟前',
    likes: 98,
    isLiked: false
  },
  {
    id: 'c3',
    author: '音乐制作人',
    avatar: $r('app.media.avatar_3'),
    content: '请问这是什么音乐节？现场效果太震撼了！',
    time: '11分钟前',
    likes: 167,
    isLiked: false
  }
];

const initialV008Comments: Comment[] = [
  {
    id: 'c1',
    author: '舞蹈老师',
    avatar: $r('app.media.avatar_1'),
    content: '动作编排很有创意！',
    time: '9分钟前',
    likes: 167,
    isLiked: false
  },
  {
    id: 'r1',
    author: '舞者',
    avatar: $r('app.media.avatar_2'),
    content: '谢谢老师点评，我们会继续努力！',
    time: '7分钟前',
    likes: 56,
    isLiked: false,
    parentId: 'c1',
    parentAuthor: '舞蹈老师',
    isReply: true
  },
  {
    id: 'c2',
    author: '舞蹈爱好者',
    avatar: $r('app.media.avatar_3'),
    content: '这个舞蹈编排太精彩了，请问是什么舞种？',
    time: '12分钟前',
    likes: 134,
    isLiked: false
  }
];

// Create the initial Map for PersistentStorage
const initialVideoCommentsMap: Map<string, Comment[]> = new Map([
  ['v001', initialV001Comments],
  ['v002', initialV002Comments],
  ['v003', initialV003Comments],
  ['v004', initialV004Comments],
  ['v005', initialV005Comments],
  ['v006', initialV006Comments],
  ['v007', initialV007Comments],
  ['v008', initialV008Comments]
]);

// Initialize PersistentStorage
export async function initializeCommentData(context: common.UIAbilityContext): Promise<void> {
  try {
    const prefs = await preferences.getPreferences(context, 'videoCommentsStorage');
    await prefs.put('comments', JSON.stringify(Array.from(initialVideoCommentsMap.entries())));
    await prefs.flush();
  } catch (err) {
    console.error('Failed to initialize comment data:', err.message);
  }
}

// Export comment data for direct use
export {
  initialV001Comments,
  initialV002Comments,
  initialV003Comments,
  initialV004Comments,
  initialV005Comments,
  initialV006Comments,
  initialV007Comments,
  initialV008Comments
}; 