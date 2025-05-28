/**
 * 数据模型定义文件
 * 包含：
 * 1. 创作者信息接口
 * 2. 视频信息接口
 * 3. 资源类型定义
 */

// 创作者信息接口
export interface Creator {
  id: string;         // 创作者ID
  name: string;       // 创作者名称
  avatar: ResourceStr; // 头像资源路径
  latestVideo: string; // 最新视频标题
}

// 视频信息接口
export interface VideoItem {
  id: string;          // 视频ID
  title: string;       // 视频标题
  cover: ResourceStr;  // 视频封面/文件路径 (用于视频播放器)
  thumbnail: ResourceStr; // 缩略图文件路径 (用于列表展示)
  duration: number;    // 视频时长（秒）
  likes: number;       // 点赞数
  comments: number;    // 评论数
  playCount: number;   // 播放次数
  author: string;      // 作者名称
  category: string;    // 视频分类
  description?: string; // 可选：视频介绍
  isLiked?: boolean;   // 可选：用户是否点赞
  rank?: number;       // 可选：排名
}

// 视频组件相关接口
export interface VideoPreparedEvent {
  duration: number;    // 视频准备完成时的时长
}

export interface VideoUpdateEvent {
  time: number;        // 视频播放进度时间
}

export interface FullscreenChangeEvent {
  fullscreen: boolean; // 是否全屏状态
}

export interface VideoErrorEvent {
  error: string;       // 视频错误信息
}

export interface CommentDataUpdate {
  likeCount: number;   // 点赞数量
  isLiked: boolean;    // 是否已点赞
  commentCount: number; // 评论数量
}

// 视频组件状态接口
export interface VideoComponentState {
  isFullscreen: boolean;  // 是否全屏
  showControls: boolean;  // 是否显示控制栏
  currentTime: number;    // 当前播放时间
  duration: number;       // 视频总时长
  isPlaying: boolean;     // 是否正在播放
  isLiked: boolean;       // 是否已点赞
  likeCount: number;      // 点赞数量
  commentCount: number;   // 评论数量
}

// 字体大小接口
export interface FontSizes {
  SMALL: number;    // 小号字体
  MEDIUM: number;   // 中号字体
  LARGE: number;    // 大号字体
}

// 颜色接口
export interface ColorPalette {
  PRIMARY: string;   // 主题色
  WHITE: string;     // 白色
  GRAY: string;      // 灰色
  BLACK: string;     // 黑色
  OVERLAY: string;   // 遮罩层颜色
}

// 视频组件样式接口
export interface VideoStyles {
  CONTROLS_TIMEOUT: number;        // 控制栏自动隐藏时间
  PLAY_BUTTON_SIZE: number;        // 播放按钮大小
  CONTROL_ICON_SIZE: number;       // 控制图标大小
  FULLSCREEN_BUTTON_SIZE: number;  // 全屏按钮大小
  SLIDER_HEIGHT: number;           // 进度条高度
  FONT_SIZE: FontSizes;            // 字体大小配置
  COLORS: ColorPalette;            // 颜色配置
}

// 评论相关接口
export interface Comment {
  id: string;           // 评论ID
  author: string;       // 评论作者
  avatar: Resource;     // 作者头像
  content: string;      // 评论内容
  time: string;         // 评论时间
  likes: number;        // 点赞数
  isLiked: boolean;     // 是否已点赞
  parentId?: string;    // 可选：父评论ID（用于回复）
  parentAuthor?: string; // 可选：父评论作者（用于回复）
  isReply?: boolean;    // 可选：是否为回复评论
}

// 评论页面参数接口
export interface CommentsPageParams {
  commentCount: number;  // 评论总数
  videoId: string;       // 视频ID
  onDataChange: (data: CommentDataUpdate) => void;  // 数据变化回调函数
}

// 样式相关接口
export interface Colors {
  PRIMARY: string;      // 主题色
  SECONDARY: string;    // 次要色
  GRAY: string;         // 灰色
  DARK_GRAY: string;    // 深灰色
  WHITE: string;        // 白色
  BACKGROUND: string;   // 背景色
}

export interface Spacing {
  SMALL: number;        // 小间距
  MEDIUM: number;       // 中间距
  LARGE: number;        // 大间距
}

export interface IconSizes {
  SMALL: number;        // 小图标
  MEDIUM: number;       // 中图标
  LARGE: number;        // 大图标
}

// 评论样式接口
export interface CommentStyles {
  FONT_SIZE: FontSizes;  // 字体大小配置
  COLORS: Colors;        // 颜色配置
  SPACING: Spacing;      // 间距配置
  ICON_SIZE: IconSizes;  // 图标大小配置
}

// 视频详情页面参数接口
export interface VideoDetailParams {
  videoId: string;           // 视频ID
  fullVideoList: VideoItem[]; // 完整视频列表
}

