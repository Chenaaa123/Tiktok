/**
 * 用户个人资料页面组件
 * 展示用户的个人信息、作品、喜欢和收藏的视频列表
 * 支持关注/取消关注、查看用户作品等功能
 */

import { router } from '@kit.ArkUI';
import { AvatarManager } from '../model/AvatarManager';
import { VideoItem } from '../../Home/model/DataModel';


/**
 * 扩展视频项接口，添加发布日期字段
 */
interface ExtendedVideoItem extends VideoItem {
  publishDate: string; // 视频发布日期
}

/**
 * 用户信息接口
 */
interface UserInfo {
  followers: number; // 粉丝数
  following: number; // 关注数
  likes: number; // 获赞数
  bio: string; // 个人简介
}

/**
 * 路由参数接口
 */
interface RouteParams {
  userId?: number; // 用户ID
  userName?: string; // 用户名
}

/**
 * 用户个人资料页面组件
 * @Entry 标记为入口组件
 * @Component 标记为自定义组件
 */
@Entry
@Component
export default struct UserProfile {
  @State userId: number = 0; // 用户ID
  @State userName: string = ''; // 用户名
  @State isFollowing: boolean = false; // 是否已关注
  @State currentTab: string = 'works'; // 当前选中的标签页：works-作品, likes-喜欢, favorites-收藏

  // 添加作品列表状态
  @State worksList: ExtendedVideoItem[] = [
    {
      id: 'Video/the_setting_sun.mp4',
      title: '沉浸式体验夕阳西下',
      cover: $rawfile('Video/the_setting_sun.mp4'),
      thumbnail:'',
      duration: 185,
      likes: 1280,
      comments: 342,
      playCount: 1052000,
      author: '旅行达人',
      category: '旅行',
      publishDate: '2023-10-26'
    },
    {
      id: 'Video/Road_Cycling.mp4',
      title: '来次美妙的公路骑行',
      cover: $rawfile('Video/Road_Cycling.mp4'),
      thumbnail:'',
      duration: 245,
      likes: 2560,
      comments: 678,
      playCount: 850000,
      author: '运动达人',
      category: '运动',
      publishDate: '2023-10-25'
    }
  ];

  // 添加喜欢列表状态
  @State likesList: ExtendedVideoItem[] = [
    {
      id: 'Video/City_Night_View.mp4',
      title: '城市夜景',
      cover: $rawfile('Video/City_Night_View.mp4'),
      thumbnail:'',
      duration: 180,
      likes: 3200,
      comments: 456,
      playCount: 1200000,
      author: '城市探索者',
      category: '城市',
      publishDate: '2023-10-24'
    }
  ];

  // 添加收藏列表状态
  @State favoritesList: ExtendedVideoItem[] = [
    {
      id: 'Video/food_video.mp4',
      title: '美食制作',
      cover: $rawfile('Video/food_video.mp4'),
      thumbnail:'',
      duration: 600,
      likes: 3800,
      comments: 432,
      playCount: 1100000,
      author: '美食博主',
      category: '美食',
      publishDate: '2023-10-22'
    }
  ];

  @State userInfo: UserInfo = {
    followers: 0,
    following: 0,
    likes: 0,
    bio: '这个人很懒，什么都没写~'
  };

  /**
   * 组件即将出现时的生命周期函数
   * 初始化用户信息和路由参数
   */
  aboutToAppear() {
    try {
      // 获取路由参数
      const params = router.getParams() as RouteParams;
      if (params) {
        this.userId = params.userId ?? 0;
        this.userName = params.userName ?? '';
      }
    } catch (error) {
      console.error('Failed to get route params:', error);
      // 设置默认值
      this.userId = 0;
      this.userName = '';
    }

    // 模拟获取用户信息
    this.userInfo = {
      followers: Math.floor(Math.random() * 1000),
      following: Math.floor(Math.random() * 500),
      likes: Math.floor(Math.random() * 10000),
      bio: '音乐创作者 | 分享美好生活'
    };
  }

  /**
   * 构建标签页项
   * @param label - 标签显示文本
   * @param tabName - 标签标识名称
   */
  @Builder
  buildTabItem(label: string, tabName: string) {
    Column() {
      Text(label)
        .fontSize(16)
        .fontColor(this.currentTab === tabName ? '#FFFFFF' : '#999999')
        .fontWeight(this.currentTab === tabName ? FontWeight.Bold : FontWeight.Normal)
        .margin({ bottom: 8 })
        .border({
          width: { bottom: this.currentTab === tabName ? 2 : 0 },
          color: this.currentTab === tabName ? '#FF0050' : 'transparent'
        })
    }
    .width('33%')
    .height(40)
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      this.currentTab = tabName;
    })
  }

  /**
   * 格式化数字显示
   * 将大数字转换为带单位的字符串（如：1.2万）
   * @param count - 要格式化的数字
   * @returns 格式化后的字符串
   */
  formatCount(count: number): string {
    if (count >= 10000) {
      return `${(count / 10000).toFixed(1)}万`;
    }
    return count.toString();
  }

  /**
   * 构建作品列表项
   * @param item - 视频项数据
   */
  @Builder
  buildWorkListItem(item: ExtendedVideoItem) {
    Row() {
      // 视频封面图片
      Image($r("app.media.profilePicture"))
        .width(120)
        .height(80)
        .borderRadius(8)
        .objectFit(ImageFit.Cover)
        .margin({ right: 12 })

      Column() {
        // 视频标题
        Text(item.title)
          .fontSize(14)
          .fontColor('#FFFFFF')
          .fontWeight(FontWeight.Medium)
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .margin({ bottom: 4 })
          .width('100%')
          .textAlign(TextAlign.Start)

        // 发布日期
        Text(item.publishDate)
          .fontSize(12)
          .fontColor('#999999')
          .margin({ bottom: 8 })
          .width('100%')
          .textAlign(TextAlign.Start)

        // 播放量和评论数
        Row({ space: 12 }) {
          // 播放量
          Row({ space: 4 }) {
            Image($r('app.media.play'))
              .width(16)
              .height(16)
              .fillColor('#999999')
            Text(this.formatCount(item.playCount))
              .fontSize(12)
              .fontColor('#999999')
          }

          // 评论数
          Row({ space: 4 }) {
            Image($r('app.media.ic_comment'))
              .width(16)
              .height(16)
              .fillColor('#999999')
            Text(this.formatCount(item.comments))
              .fontSize(12)
              .fontColor('#999999')
          }
        }
        .width('100%')
        .justifyContent(FlexAlign.Start)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 8, bottom: 8 }) // 卡片内边距
    .onClick(() => {
      // 点击跳转到视频详情页，传递整个VideoItem对象
      router.pushUrl({
        url: 'pages/VideoDetail', // 确保这是您的视频播放页面的路径
        params: {
          videoItem: item // 传递整个 VideoItem 对象
        }
      });
    })
  }

  build() {
    Stack() { // 使用 Stack 允许叠加内容 (视频播放器)
      Column() {
        // 顶部导航栏
        Row() {
          Text('←') // 使用项目中的返回图标
            .width(24)
            .height(24)
            .fontColor('#FFFF')
            .fontWeight(700)
            .margin({ left: 16 })
            .onClick(() => {
              router.back();
            })

          Text(this.userName || '舞蹈达人' + this.userId)
            .fontSize(18)
            .fontColor('#FFFFFF')
            .fontWeight(FontWeight.Bold)
            .margin({ left: 16 })

          Blank().layoutWeight(1)

          Text('⋮') // 使用项目中的更多图标
            .width(24)
            .height(24)
            .fontColor('#FFFF')
            .margin({ right: 16 })
        }
        .width('100%')
        .height(56)
        .backgroundColor('#000000')
        .alignItems(VerticalAlign.Center)

        // 用户信息区域
        Column() {
          Image(AvatarManager.getUserAvatar(this.userId))
            .width(100)
            .height(100)
            .borderRadius(50)
            .margin({ top: 20 })
            .objectFit(ImageFit.Cover)

          Text(this.userName || '舞蹈达人' + this.userId)
            .fontSize(20)
            .fontColor('#FFFFFF')
            .fontWeight(FontWeight.Bold)
            .margin({ top: 16 })

          // 用户简介
          Text(this.userInfo.bio)
            .fontSize(14)
            .fontColor('#999999')
            .margin({ top: 8 })
            .textAlign(TextAlign.Center)
            .width('80%')

          // 数据统计
          Row() {
            Column() {
              Text(this.userInfo.followers.toString())
                .fontSize(16)
                .fontColor('#FFFFFF')
                .fontWeight(FontWeight.Bold)
              Text('粉丝')
                .fontSize(12)
                .fontColor('#999999')
                .margin({ top: 4 })
            }
            .width('33%')

            Column() {
              Text(this.userInfo.following.toString())
                .fontSize(16)
                .fontColor('#FFFFFF')
                .fontWeight(FontWeight.Bold)
              Text('关注')
                .fontSize(12)
                .fontColor('#999999')
                .margin({ top: 4 })
            }
            .width('33%')

            Column() {
              Text(this.userInfo.likes.toString())
                .fontSize(16)
                .fontColor('#FFFFFF')
                .fontWeight(FontWeight.Bold)
              Text('获赞')
                .fontSize(12)
                .fontColor('#999999')
                .margin({ top: 4 })
            }
            .width('33%')
          }
          .width('100%')
          .margin({ top: 16 })

          // 关注按钮
          Button(this.isFollowing ? '已关注' : '关注')
            .width(120)
            .height(36)
            .fontSize(16)
            .fontColor('#FFFFFF')
            .backgroundColor(this.isFollowing ? '#333333' : '#FF0050')
            .borderRadius(18)
            .margin({ top: 16 })
            .onClick(() => {
              this.isFollowing = !this.isFollowing;
            })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
        .backgroundColor('#000000')

        // 标签页导航
        Row() {
          this.buildTabItem('作品', 'works')
          this.buildTabItem('喜欢', 'likes')
          this.buildTabItem('收藏', 'favorites')
        }
        .width('100%')
        .height(40)
        .backgroundColor('#000000')
        .border({ width: { bottom: 1 }, color: '#333333' })

        // 内容区域
        Column() {
          if (this.currentTab === 'works') {
            List() {
              ForEach(this.worksList, (item: ExtendedVideoItem) => {
                ListItem() {
                  this.buildWorkListItem(item)
                }
              })
            }
            .width('100%')
            .layoutWeight(1)
            .backgroundColor('#000000')
            .divider({
              strokeWidth: 1,
              color: '#333333',
              startMargin: 16,
              endMargin: 16
            })
          } else if (this.currentTab === 'likes') {
            List() {
              ForEach(this.likesList, (item: ExtendedVideoItem) => {
                ListItem() {
                  this.buildWorkListItem(item)
                }
              })
            }
            .width('100%')
            .layoutWeight(1)
            .backgroundColor('#000000')
            .divider({
              strokeWidth: 1,
              color: '#333333',
              startMargin: 16,
              endMargin: 16
            })
          } else if (this.currentTab === 'favorites') {
            List() {
              ForEach(this.favoritesList, (item: ExtendedVideoItem) => {
                ListItem() {
                  this.buildWorkListItem(item)
                }
              })
            }
            .width('100%')
            .layoutWeight(1)
            .backgroundColor('#000000')
            .divider({
              strokeWidth: 1,
              color: '#333333',
              startMargin: 16,
              endMargin: 16
            })
          }
        }
        .width('100%')
        .layoutWeight(1)
        .backgroundColor('#000000')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#000000')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#000000')
  }
}