// DiscoverPage.ets
import router from '@ohos.router';

@Entry
@Component
struct DiscoverPage {
  @State currentCategory: string = 'recommended'
  @State activeNav: string = 'discover'

  // 热门创作者数据
  @State channels: Array<Channel> = [
    { id: 1, name: '舞蹈达人', avatar: 'media/images/profile1.jpg' },
    { id: 2, name: '音乐制作人', avatar: 'media/images/profile2.jpg' },
    { id: 3, name: '旅行达人', avatar: 'media/images/album_cover2.jpg' },
    { id: 4, name: '美食博主', avatar: 'media/images/album_cover1.jpg' }
  ]

  // 为你推荐数据
  @State recommendedItems: Array<RecommendedItem> = [
    {
      id: 1,
      title: '精选舞蹈教学：从零开始学习街舞基础动作',
      info: '舞蹈达人 · 2.3万次播放',
      thumbnail: 'media/images/background1.jpg'
    },
    {
      id: 2,
      title: '轻音乐合集：助你放松心情，提高工作效率',
      info: '音乐制作人 · 1.8万次播放',
      thumbnail: 'media/images/album_cover1.jpg'
    },
    {
      id: 3,
      title: '城市日落时分：捕捉美丽光影的摄影技巧',
      info: '摄影师小王 · 1.5万次播放',
      thumbnail: 'media/images/album_cover2.jpg'
    },
    {
      id: 4,
      title: '家常菜教程：简单易学的快手菜制作方法',
      info: '美食博主 · 3.2万次播放',
      thumbnail: 'media/images/profile2.jpg'
    }
  ]

  // 正在流行数据
  @State trendingCards: Array<TrendingCard> = [
    {
      id: 1,
      title: '热门街舞视频',
      info: '10.2万次播放',
      image: 'media/images/background1.jpg'
    },
    {
      id: 2,
      title: '热门音乐榜单',
      info: '5.7万次播放',
      image: 'media/images/album_cover1.jpg'
    }
  ]

  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
          .margin({ left: 16 })
          .onClick(() => {
            router.back()
          })

        Text('发现')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .margin({ left: 16 })
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Start)
      .alignItems(VerticalAlign.Center)
      // .border({ bottom: { width: 1, color: '#FFFFFF20' } })

      // 搜索栏
      Row() {
        Image($r('app.media.startIcon'))
          .width(20)
          .height(20)
          .margin({ right: 10 })
          .opacity(0.7)

        TextInput({ placeholder: '搜索音乐、视频或创作者' })
          .fontSize(14)
          .width('80%')
          .backgroundColor(Color.Transparent)
          .placeholderColor('#FFFFFFB3')
          .caretColor(Color.White)
      }
      .width('90%')
      .height(40)
      .backgroundColor('#FFFFFF1A')
      .borderRadius(20)
      .padding(10)
      .margin({ top: 10, bottom: 10 })
      // .alignSelf(FlexAlign.Center)

      // 分类标签
      Scroll() {
        Row() {
          ForEach(['recommended', 'hot', 'music', 'dance', 'game', 'food', 'travel'], (category :string) => {
            Text(this.getCategoryName(category))
              .fontSize(14)
              .padding({ left: 16, right: 16, top: 8, bottom: 8 })
              .borderRadius(20)
              .backgroundColor(this.currentCategory === category ? '#FF0050' : '#FFFFFF1A')
              .margin({ right: 15 })
              .onClick(() => {
                this.currentCategory = category
                // 这里可以添加分类切换逻辑
              })
          })
        }
        .padding({ left: 16, right: 16, top: 10, bottom: 10 })
      }
      .scrollable(ScrollDirection.Horizontal)
      .width('100%')
      .height(48)
      // .border({ bottom: { width: 1, color: '#FFFFFF20' } })

      // 内容区域
      Scroll() {
        Column() {
          // 正在流行部分
          this.buildTrendingSection()

          // 热门创作者部分
          this.buildChannelsSection()

          // 为你推荐部分
          this.buildRecommendedSection()
        }
        .width('100%')
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // 底部导航栏
      Row() {
        this.buildNavItem('home', '🏠', '首页', 'index_main')
        this.buildNavItem('discover', '🔍', '发现', 'discover')
        this.buildNavItem('create', '+', '创建', 'create')
        this.buildNavItem('messages', '💬', '消息', 'messages')
        this.buildNavItem('profile', '👤', '我', 'profile_center')
      }
      .width('100%')
      .height(60)
      .backgroundColor('#000000CC')
      // .border({ top: { width: 1, color: '#FFFFFF20' } })
      .justifyContent(FlexAlign.SpaceAround)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#000000')
  }

  // 构建正在流行部分
  @Builder
  buildTrendingSection() {
    Column() {
      // 标题和查看全部
      Row() {
        Text('正在流行')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)

        Text('查看全部')
          .fontSize(14)
          .opacity(0.8)
          .onClick(() => {
            router.pushUrl({ url: 'pages/TrendingAll' })
          })
      }
      .width('100%')
      .margin({ bottom: 15 })

      // 流行卡片
      Grid() {
        ForEach(this.trendingCards, (card: TrendingCard) => {
          GridItem() {
            Stack() {
              Image($rawfile(card.image))
                .width('100%')
                .height(180)
                .objectFit(ImageFit.Cover)
                .opacity(0.8)

              Column() {
                Text(card.title)
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .margin({ bottom: 5 })

                Text(card.info)
                  .fontSize(12)
                  .opacity(0.8)
              }
              .width('100%')
              .padding(15)
              .alignItems(HorizontalAlign.Start)
              .justifyContent(FlexAlign.End)
              // .backgroundImage($rawfile('media/images/card_gradient.png'))
              .backgroundImageSize(ImageSize.Cover)
            }
            .width('100%')
            .height(180)
            .backgroundColor('#FFFFFF1A')
            .borderRadius(12)
            .onClick(() => {
              // 跳转到详情页
            })
          }
          .padding(5)
        })
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(10)
      .rowsGap(10)
      .width('100%')
    }
    .padding(15)
    .width('100%')
  }

  // 构建热门创作者部分
  @Builder
  buildChannelsSection() {
    Column() {
      // 标题和查看全部
      Row() {
        Text('热门创作者')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)

        Text('查看全部')
          .fontSize(14)
          .opacity(0.8)
          .onClick(() => {
            router.pushUrl({ url: 'pages/CreatorsAll' })
          })
      }
      .width('100%')
      .margin({ bottom: 15 })

      // 创作者列表
      Scroll() {
        Row() {
          ForEach(this.channels, (channel: Channel) => {
            Column() {
              Image($rawfile(channel.avatar))
                .width(60)
                .height(60)
                .borderRadius(30)
                .onClick(() => {
                  router.pushUrl({
                    url: 'pages/ProfileCreator',
                    params: { id: channel.id.toString() }
                  })
                })

              Text(channel.name)
                .fontSize(12)
                .margin({ top: 8 })
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
                .width(70)
                .textAlign(TextAlign.Center)
            }
            .width(70)
            .margin({ right: 15 })
          }
          )}
        .padding({ top: 5, bottom: 5 })
      }
      .scrollable(ScrollDirection.Horizontal)
      .width('100%')
      .height(100)
    }
    .padding(15)
    .width('100%')
  }

  // 构建为你推荐部分
  @Builder
  buildRecommendedSection() {
    Column() {
      // 标题和刷新
      Row() {
        Text('为你推荐')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)

        Text('刷新')
          .fontSize(14)
          .opacity(0.8)
          .onClick(() => {
            // 刷新逻辑
          })
      }
      .width('100%')
      .margin({ bottom: 15 })

      // 推荐列表
      Column() {
        ForEach(this.recommendedItems, (item: RecommendedItem) => {
          Row() {
            Image($rawfile(item.thumbnail))
              .width(120)
              .height(70)
              .borderRadius(8)
              .objectFit(ImageFit.Cover)

            Column() {
              Text(item.title)
                .fontSize(14)
                .fontWeight(FontWeight.Bold)
                .maxLines(2)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
                .lineHeight(20)

              Text(item.info)
                .fontSize(12)
                .opacity(0.8)
                .margin({ top: 10 })
            }
            .height(70)
            .margin({ left: 15 })
            .layoutWeight(1)
            .justifyContent(FlexAlign.SpaceBetween)
          }
          .width('100%')
          .margin({ bottom: 15 })
          .onClick(() => {
            // 跳转到详情页
          })
        })
      }
      .width('100%')
    }
    .padding(15)
    .width('100%')
  }

  // 构建底部导航项
  @Builder
  buildNavItem(id: string, icon: string, label: string, page: string) {
    Column() {
      Text(icon)
        .fontSize(24)

      Text(label)
        .fontSize(12)
    }
    .opacity(this.activeNav === id ? 1 : 0.7)
    .onClick(() => {
      this.activeNav = id
      if (page !== 'discover') {
        router.pushUrl({ url: `pages/${page}` })
      }
    })
  }

  // 获取分类名称
  private getCategoryName(category: string): string {
    const categoryMap: Record<string, string> = {
      'recommended': '推荐',
      'hot': '热门',
      'music': '音乐',
      'dance': '舞蹈',
      'game': '游戏',
      'food': '美食',
      'travel': '旅行'
    }
    return categoryMap[category] || category
  }
}

// 数据模型
interface Channel {
  id: number
  name: string
  avatar: string
}

interface RecommendedItem {
  id: number
  title: string
  info: string
  thumbnail: string
}

interface TrendingCard {
  id: number
  title: string
  info: string
  image: string
}