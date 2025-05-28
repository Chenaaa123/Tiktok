import RecommendItem from '../model/RecommendListItem'
import { recommendList } from '../viewmodel/RecommendList'
import { router } from '@kit.ArkUI'
import { BusinessError } from '@kit.BasicServicesKit'

@Component
export default struct RecommendList {
  private currentOffsetY: number = 0; // 记录当前触摸的Y轴偏移量
  @State refreshStatus: boolean = false; // 刷新状态标识
  @State refreshText: string = '正在刷新';
  @State pullUpText: string = '正在加载';
  private timer: number = 0; // 定时器ID
  @State isRefreshing: boolean = false; // 是否正在刷新
  @State isCanLoadMore: boolean = false; // 是否可以加载更多
  @State pullDownDistance: number = 0; // 下拉距离
  @State pullUpDistance: number = 0; // 上拉距离
  @State recommendList: RecommendItem[] = recommendList; // 完整的推荐列表
  @State displayedRecommendations: RecommendItem[] = []; // 当前显示的推荐项
  @State availableItems: RecommendItem[] = []; // 可用的推荐项

  private readonly PULL_THRESHOLD: number = 30; // 触发刷新的阈值
  private readonly MAX_PULL_DISTANCE: number = 150; // 最大拉动距离
  private readonly INITIAL_ITEMS_COUNT: number = 3; // 初始显示项数
  private readonly LOAD_MORE_COUNT: number = 3; // 每次加载更多项数

  aboutToAppear() {
    this.initializeItems(); // 组件出现时初始化数据
  }

  // 初始化可显示项
  initializeItems() {
    this.availableItems = [...this.recommendList]; // 展开运算符用于浅拷贝数组
    this.displayedRecommendations = this.getRandomItems(this.INITIAL_ITEMS_COUNT); // 获取随机初始项
  }

  // 获取随机项
  getRandomItems(count: number): RecommendItem[] {
    const result: RecommendItem[] = []; // 结果数组
    const tempAvailable = [...this.availableItems]; // 临时可用项副本

    for (let i = 0; i < Math.min(count, tempAvailable.length); i++) {
      const randomIndex = Math.floor(Math.random() * tempAvailable.length); // 生成随机索引
      result.push(tempAvailable[randomIndex]); // 添加随机项到结果
      tempAvailable.splice(randomIndex, 1); // 从临时数组中移除已选项
    }
    return result; // 返回随机项数组
  }

  // 处理下拉刷新和上拉加载
  putDownPullUpRefresh(event?: TouchEvent): void {
    if (event === undefined) return; // 无事件则返回

    switch (event.type) {
      case TouchType.Down:
        this.currentOffsetY = event.touches[0].y; // 记录按下时的Y坐标
        break;

      case TouchType.Move:
        const deltaY = event.touches[0].y - this.currentOffsetY; // 计算Y轴移动距离

        // 处理下拉刷新
        if (deltaY > 0 && this.refreshStatus === false) {
          this.pullDownDistance = Math.min(deltaY, this.MAX_PULL_DISTANCE); // 限制下拉距离
          if (this.pullDownDistance > this.PULL_THRESHOLD) {
            this.refreshStatus = true; // 超过阈值则允许刷新
          }
        }
        // 处理上拉加载
        else if (deltaY < 0 && this.isCanLoadMore === false) {
          this.pullUpDistance = Math.min(Math.abs(deltaY), this.MAX_PULL_DISTANCE); // 限制上拉距离
          if (this.pullUpDistance > this.PULL_THRESHOLD &&
            this.availableItems.length > 0) {
            this.isCanLoadMore = true; // 超过阈值且有数据则允许加载
          }
        }
        break;

      case TouchType.Up:
      case TouchType.Cancel:
        // 处理刷新完成
        if (this.refreshStatus) {
          this.timer = setTimeout(() => {
            this.refreshStatus = false; // 重置刷新状态
            this.pullDownDistance = 0; // 重置下拉距离
            this.initializeItems(); // 重新初始化数据
          }, 1500); // 1.5秒延迟
        }

        // 处理加载更多完成
        if (this.isCanLoadMore) {
          this.timer = setTimeout(() => {
            this.isCanLoadMore = false; // 重置加载状态
            this.pullUpDistance = 0; // 重置上拉距离
            this.loadMoreItems(); // 加载更多数据
          }, 2000); // 2秒延迟
        } else {
          // 重置距离
          this.pullDownDistance = 0;
          this.pullUpDistance = 0;
        }
        break;
    }
  }

  // 加载更多项
  loadMoreItems() {
    if (this.availableItems.length === 0) return; // 无可用项则返回

    const newItems = this.getRandomItems(this.LOAD_MORE_COUNT); // 获取随机新项
    this.displayedRecommendations = [...this.displayedRecommendations, ...newItems]; // 合并到显示列表

    // 从可用项中移除已显示的项
    newItems.forEach(item => {
      const index = this.availableItems.findIndex(i => i.id === item.id);
      if (index !== -1) {
        this.availableItems.splice(index, 1);
      }
    });
  }

  @Builder      // 下拉刷新UI构建器
  putDown() {
    Column() {
      Row() {
        Image($r('app.media.load')) // 加载图标
          .width(40)
          .height(40)
          .fillColor('#ffff')
          .rotate({ angle: this.pullDownDistance > this.PULL_THRESHOLD ? 180 : 0 }) // 根据距离旋转图标
        Text(this.refreshText) // 刷新文本
          .fontSize(16)
          .height(40)
          .fontColor('#ffff')
          .opacity(this.pullDownDistance > this.PULL_THRESHOLD ? 1 : 0.5) // 根据距离调整透明度
      }
      .justifyContent(FlexAlign.Center) // 水平居中
      .alignItems(VerticalAlign.Center) // 垂直居中
      .width('94%')
      .height('5%')
    }
    .height(this.pullDownDistance) // 高度随下拉距离变化
    .opacity(Math.min(this.pullDownDistance / this.PULL_THRESHOLD, 1)) // 透明度随距离变化
    .padding({top:20})  // 顶部内边距防止显示不全
  }

  @Builder    // 上拉加载UI构建器
  PullUp() {
    Column() {
      Row() {
        Image($r('app.media.load')) // 加载图标
          .width(40)
          .height(40)
          .fillColor('#ffffffff')
          .rotate({ angle: this.pullUpDistance > this.PULL_THRESHOLD ? 180 : 0 }) // 根据距离旋转图标
        Text(this.pullUpText) // 加载文本
          .fontSize(16)
          .height(40)
          .fontColor('#ffffffff')
          .opacity(this.pullUpDistance > this.PULL_THRESHOLD ? 1 : 0.5) // 根据距离调整透明度
      }
      .alignItems(VerticalAlign.Center) // 垂直居中
      .justifyContent(FlexAlign.Center) // 水平居中
      .width('94%')
      .height('5%')
      .padding({top:-60}) // 调整位置
    }
    .height(this.pullUpDistance) // 高度随上拉距离变化
    .opacity(Math.min(this.pullUpDistance / this.PULL_THRESHOLD, 1)) // 透明度随距离变化
  }

  build() {
    Column() {
      Scroll() {
        Column() {
          // 下拉刷新区域
          if (this.refreshStatus || this.pullDownDistance > 0) {
            this.putDown()
          }
          
          // 推荐列表项
          ForEach(this.displayedRecommendations, (item: RecommendItem) => {
            ListItem() {
              Row() {
                // 封面图片
                Image(item.coverImage)
                  .width(120)
                  .height(80)
                  .borderRadius(8)
                  .margin({ right: 12 })
                  .objectFit(ImageFit.Cover) // 图片填充模式
                
                // 内容信息
                Column({ space: 20 }) {
                  // 标题
                  Text(item.title)
                    .fontSize(14)
                    .fontWeight(800)
                    .margin({ bottom: 6 })
                    .maxLines(2) // 限制两行
                    .textOverflow({ overflow: TextOverflow.Ellipsis }) // 超出显示省略号
                    .fontColor(Color.White)
                  
                  // 作者和播放量
                  Row() {
                    Text(item.author.name) // 作者名
                      .fontSize(12)
                      .opacity(0.8)
                      .fontColor(Color.White)
                    Text(`·${item.viewCount}万次播放`) // 播放量
                      .fontSize(12)
                      .opacity(0.8)
                      .fontColor(Color.White)
                  }
                }
                .alignItems(HorizontalAlign.Start) // 左对齐
                .justifyContent(FlexAlign.Center) // 垂直居中
                .layoutWeight(1) // 占据剩余空间
              }
              .width('100%')
              .padding(12) // 内边距
            }
            .onClick(() => {
              // 点击跳转到详情页
              router.pushUrl({
                url: 'Discover/pages/TrendingContent',
                params: { defaultFilter: 'all' }
              }).then(() => {
                console.info('push page success');
              }).catch((err: BusinessError) => {
                console.error(`pushUrl failed, code is ${err.code}, message is ${err.message}`);
              })
            })
            .height(90) // 固定高度
            .borderRadius(12) // 圆角
            .margin({ top: this.displayedRecommendations.indexOf(item) === 0 ? 0 : 4 }) // 首项无上边距
          }, (item: RecommendItem, index?: number) => `${item.id}_${index}`) // 唯一键生成

          // 上拉加载区域
          if ((this.isCanLoadMore || this.pullUpDistance > 0) &&
            this.availableItems.length > 0) {
            this.PullUp()
          }

          // 无更多数据提示
          if (this.availableItems.length === 0 &&
            this.displayedRecommendations.length > this.INITIAL_ITEMS_COUNT) {
            Text('暂无更多数据')
              .fontColor(Color.White)
              .margin({ bottom: 30 }) // 底部边距
          }
        }
        .width('100%') // 占满宽度
      }
      .width('100%') // 占满宽度
      .onTouch((event?: TouchEvent) => { // 触摸事件处理
        this.putDownPullUpRefresh(event);
      })
    }
  }
}
