export interface Creator {
  id: string;         // 创作者ID
  name: string;       // 创作者名称
  avatar: ResourceStr; // 头像资源路径
  latestVideo: string; // 最新视频标题
  isLive: boolean;     // 是否正在直播
  // 可根据需要扩展其他字段，如：
  // fansCount?: number; // 粉丝数
  // description?: string; // 作者简介
}

export interface VideoItem {
  id: string;
  title: string;
  cover: ResourceStr;
  duration: number;
  likes: number;
  comments: number;
  playCount: number;
  author: string;
  category: string;
  rank?: number;     // 添加可选的 rank 属性
}

export interface HotItem {
  id: string;          // 热门项ID
  type: string;        // 分类类型（music/dance等）
  title: string;       // 热门标题
  cover: ResourceStr;  // 封面资源路径
  playCount: number;   // 播放量
  // 可扩展字段示例：
  // duration?: number;  // 视频时长（秒）
  // tags?: string[];    // 内容标签
  // heatValue?: number; // 热度值
}

// 可添加通用资源类型定义
type ResourceStr = string | Resource;

// 模拟数据
export const mockVideoList: VideoItem[] = [
  {
    id: 'v001',
    title: '超燃街舞集锦',
    cover: $rawfile('Video/dance_video.mp4'),
    duration: 185,
    likes: 105200,
    comments: 3420,
    playCount: 1052000,
    author: '舞蹈达人',
    category: '舞蹈'
  },
  {
    id: 'v002',
    title: '轻音乐治愈合集',
    cover: $rawfile('Video/music_video.mp4'),
    duration: 245,
    likes: 85700,
    comments: 2180,
    playCount: 857000,
    author: '音乐制作人',
    category: '音乐'
  },
  {
    id: 'v003',
    title: '年度旅行精选',
    cover: $rawfile('Video/travel_video.mp4'),
    duration: 320,
    likes: 76300,
    comments: 1890,
    playCount: 763000,
    author: '旅行达人',
    category: '旅行'
  },
  {
    id: 'v004',
    title: '十分钟家常菜教程',
    cover: $rawfile('Video/food_video.mp4'),
    duration: 600,
    likes: 63500,
    comments: 2800,
    playCount: 635000,
    author: '美食博主',
    category: '美食'
  }
];