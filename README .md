# TikTok 短视频应用项目介绍

## 项目概述

本项目是一个基于 HarmonyOS 开发的短视频应用，模仿 TikTok 的核心功能，包括视频浏览、内容发现、用户互动、消息系统等。项目采用 ArkUI 框架开发，使用 TypeScript 语言，实现了现代化的移动端短视频应用体验。

## 技术栈

- **开发框架**: HarmonyOS ArkUI
- **开发语言**: TypeScript
- **UI 框架**: ArkUI (声明式UI)
- **状态管理**: @State, @Prop, @Link, @StorageLink
- **路由管理**: @kit.ArkUI.router
- **数据持久化**: PersistentStorage
- **动画系统**: ArkUI Animation API
- **媒体处理**: VideoController, MediaPlayer

## 项目结构

```
entry/src/main/ets/
├── Create/                    # 内容创作模块
│   ├── model/                # 数据模型
│   │   └── musics.ets        # 音乐数据模型
│   └── page/                 # 页面组件
│       ├── Create.ets         # 创作主页面
│       ├── MusicPage.ets     # 音乐选择页面
│       └── test1.ets         # 测试页面
├── Discover/                  # 发现模块
│   ├── component/            # 可复用组件
│   │   ├── Recommend.ets     # 推荐组件
│   │   ├── RecommendList.ets # 推荐列表组件
│   │   ├── Dance.ets         # 舞蹈分类组件
│   │   ├── Food.ets          # 美食分类组件
│   │   ├── Game.ets           # 游戏分类组件
│   │   ├── Music.ets          # 音乐分类组件
│   │   ├── Popular.ets        # 热门分类组件
│   │   └── Travel.ets         # 旅游分类组件
│   ├── model/                # 数据模型
│   │   ├── CreatorItem.ets    # 创作者数据模型
│   │   ├── RecommendListItem.ets # 推荐列表项模型
│   │   ├── ThreeContentItem.ets   # 内容项模型
│   │   ├── TrendingItem.ets      # 热门内容模型
│   │   └── defaultFilter.ets      # 默认筛选器
│   ├── pages/                # 页面组件
│   │   ├── Discover.ets      # 发现主页面
│   │   ├── CreatorsAll.ets    # 创作者列表页面
│   │   ├── Music.ets          # 音乐页面
│   │   └── TrendingContent.ets # 热门内容页面
│   └── viewmodel/            # 视图模型
│       ├── CreatorList.ets    # 创作者列表数据
│       ├── RecommendList.ets  # 推荐列表数据
│       ├── ThreeContentList.ets # 内容列表数据
│       └── TrendingContentList.ets # 热门内容数据
├── Home/                      # 首页模块
│   ├── components/           # 组件
│   │   ├── CategoryTabs.ets   # 分类标签组件
│   │   ├── CreatorItem.ets    # 创作者项组件
│   │   ├── HotVideoCard.ets   # 热门视频卡片
│   │   └── VideoComponent.ets # 视频组件
│   ├── model/                # 数据模型
│   │   ├── CommentDataInitializer.ets # 评论数据初始化
│   │   ├── DataModel.ets     # 数据模型
│   │   └── Tabmodel.ets       # 标签模型
│   └── pages/                # 页面组件
│       ├── Index.ets         # 主入口页面
│       ├── Index_Recommendation.ets # 推荐页面
│       ├── VideoDetail.ets    # 视频详情页面
│       ├── CommentsPage.ets   # 评论页面
│       └── Audio2Page.ets     # 音频页面
├── Messages/                  # 消息模块
│   ├── component/            # 组件
│   │   ├── CommentsPage.ets  # 评论页面组件
│   │   ├── MentionsPage.ets   # @提及页面组件
│   │   ├── NotificationsPage.ets # 通知页面组件
│   │   └── PrivateMessagesPage.ets # 私信页面组件
│   ├── model/                # 数据模型
│   │   ├── AvatarManager.ets  # 头像管理器
│   │   ├── interfaces.ets     # 接口定义
│   │   ├── LikeItem.ets       # 点赞项模型
│   │   ├── MessageStorage.ets # 消息存储
│   │   ├── NotificationItem.ets # 通知项模型
│   │   └── PrivateMessageItem.ets # 私信项模型
│   ├── pages/                # 页面组件
│   │   ├── Messages.ets       # 消息主页面
│   │   ├── ChatPage.ets       # 聊天页面
│   │   └── UserProfile.ets    # 用户资料页面
│   ├── service/              # 服务层
│   │   └── ChatService.ets    # 聊天服务
│   └── viewmodel/            # 视图模型
│       ├── ChatMessage.ets    # 聊天消息数据
│       ├── HistoryResponse.ets # 历史响应数据
│       ├── LikeList.ets       # 点赞列表数据
│       ├── NotificationList.ets # 通知列表数据
│       └── PrivateMessageList.ets # 私信列表数据
├── Mine/                      # 个人中心模块
│   ├── model/                # 数据模型
│   │   ├── ConnectionData.ets # 连接数据模型
│   │   └── profileData.ets   # 个人资料数据模型
│   └── pages/                # 页面组件
│       ├── ProfileCenter.ets  # 个人中心页面
│       ├── ProfileCreator.ets # 创作者资料页面
│       ├── ProfileFans.ets    # 粉丝页面
│       └── CompileData.ets    # 编辑资料页面
├── entryability/             # 应用入口
│   └── EntryAbility.ets      # 主入口能力
└── entrybackupability/       # 备份能力
    └── EntryBackupAbility.ets # 备份入口能力
```

## 核心功能模块

### 1. 首页模块 (Home)

**主要功能**:
- 视频流浏览：支持上下滑动切换视频
- 视频播放控制：自动播放、暂停、音量控制
- 互动功能：点赞、评论、分享、关注
- 分类浏览：热门、推荐等不同分类

**核心组件**:
- `Index.ets`: 主入口页面，包含底部导航栏
- `Index_Recommendation.ets`: 推荐视频流页面
- `VideoComponent.ets`: 视频播放组件
- `VideoDetail.ets`: 视频详情页面

**技术实现**:
```typescript
// 视频播放控制
private videoControllers: Map<string, VideoController> = new Map();
private videoPlayingStates: Map<string, boolean> = new Map();

// 双击点赞功能
private handleDoubleClick() {
  const currentTime = Date.now();
  if (currentTime - this.lastClickTime < this.doubleClickInterval) {
    // 执行点赞逻辑
    this.handleLike();
  }
  this.lastClickTime = currentTime;
}
```

### 2. 发现模块 (Discover)

**主要功能**:
- 内容分类浏览：推荐、热门、音乐、舞蹈、游戏、美食、旅游
- 创作者发现：展示热门创作者
- 搜索功能：支持搜索创作者
- 内容推荐：个性化推荐算法

**核心组件**:
- `Discover.ets`: 发现主页面，包含搜索和分类标签
- `Recommend.ets`: 推荐组件，展示热门内容和创作者
- `RecommendList.ets`: 推荐列表组件，支持下拉刷新和上拉加载

**技术实现**:
```typescript
// 搜索功能实现
onClick(() => {
  this.searchResult = getUserByUsername(this.InputText);
  if (this.searchResult) {
    router.pushUrl({
      url: 'Mine/pages/ProfileCreator',
      params: this.searchResult
    });
  } else {
    promptAction.showToast({
      message: '未找到该用户',
      duration: 1500
    });
  }
});

// 分类标签切换
.onChange((index: number) => {
  this.currentIndex = index;
  switch (index) {
    case 0: this.categoryName = '推荐'; break;
    case 1: this.categoryName = '热门'; break;
    // ... 其他分类
  }
});
```

### 3. 创作模块 (Create)

**主要功能**:
- 视频录制：支持视频拍摄
- 音乐选择：内置音乐库选择
- 特效添加：滤镜、贴纸等特效
- 发布功能：视频发布到平台

**核心组件**:
- `Create.ets`: 创作主页面
- `MusicPage.ets`: 音乐选择页面

**技术实现**:
```typescript
// 创作页面标签切换
@Builder
tabBuilder(index: number, title: string) {
  if (index === this.current_index) {
    Text(title)
      .fontWeight(800)
      .fontSize(20)
      .fontColor(Color.White)
      .border({width: {bottom: 2}, color: 'red'});
  } else {
    Text(title)
      .fontWeight(800)
      .fontSize(20)
      .fontColor(Color.White);
  }
}
```

### 4. 消息模块 (Messages)

**主要功能**:
- 私信系统：用户间私信交流
- 通知系统：点赞、关注、评论通知
- @提及功能：@用户通知
- 评论管理：评论查看和回复

**核心组件**:
- `Messages.ets`: 消息主页面，整合所有消息功能
- `ChatPage.ets`: 聊天页面
- `PrivateMessagesPage.ets`: 私信页面
- `NotificationsPage.ets`: 通知页面

**技术实现**:
```typescript
// 消息搜索过滤
private filterMessages(searchText: string) {
  if (!searchText.trim()) {
    this.filteredMessages = PrivateMessageList;
    return;
  }
  
  const searchLower = searchText.toLowerCase();
  this.filteredMessages = PrivateMessageList.filter(item => 
    item.name.toLowerCase().includes(searchLower) || 
    item.msg.toLowerCase().includes(searchLower)
  );
}
```

### 5. 个人中心模块 (Mine)

**主要功能**:
- 个人资料：用户信息展示和编辑
- 创作者主页：作品、喜欢、收藏展示
- 粉丝管理：粉丝列表查看
- 设置功能：应用设置和偏好

**核心组件**:
- `ProfileCenter.ets`: 个人中心主页面
- `ProfileCreator.ets`: 创作者资料页面
- `ProfileFans.ets`: 粉丝页面
- `CompileData.ets`: 编辑资料页面

## 数据流架构

### 1. 状态管理

项目采用 ArkUI 的状态管理机制：

- `@State`: 组件内部状态
- `@Prop`: 父子组件数据传递
- `@Link`: 双向数据绑定
- `@StorageLink`: 持久化存储

### 2. 数据模型

```typescript
// 视频数据模型
export interface VideoItem {
  id: string;
  title: string;
  cover: Resource;
  thumbnail: Resource;
  duration: number;
  likes: number;
  comments: number;
  playCount: number;
  author: string;
  category: string;
  description: string;
  isLiked: boolean;
}

// 创作者数据模型
export default class CreatorItem {
  id: number;
  name: string;
  avatar: Resource;
  fans: string;
  videos: string;
  description: string;
  tags: string[];
  category: string;
  followed: boolean;
  accountId: string;
  attention: string;
  likes: string;
}
```

### 3. 数据持久化

使用 PersistentStorage 实现数据持久化：

```typescript
// 评论数据持久化
@StorageLink('videoCommentsStorage') allVideoComments: Map<string, Comment[]> = new Map();
```




