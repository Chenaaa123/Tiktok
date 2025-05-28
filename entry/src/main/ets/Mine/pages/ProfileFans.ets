import { router } from '@kit.ArkUI'
import { ConnectionItem, interacList, fanslist, followingList ,RouterParams} from '../model/ConnectionData'; // 导入数据和接口


@Entry
@Component
struct Profile1Page {

  @State currentTab: number = 2;    // 0: 互关, 1: 关注, 2: 粉丝，默认显示粉丝

  @State searchText: string = '';   // 添加搜索关键字的状态变量

  // 修改状态变量，使用Map记录点击的用户及其索引，模拟顺序
  @State followedUsersMap: Map<string, ConnectionItem> = new Map(); // 使用Map记录点击关注的用户
  @State isFollowedSet: Set<string> = new Set(); // 使用Set快速查找是否已关注

  @State showSortingOptions: boolean = false; // 控制排序选项是否显示
  @State selectedSort: string = '综合排序'; // 当前选中的排序方式

  aboutToAppear() {
    const params = router.getParams() as RouterParams
    if (params?.initialTab !== undefined) {
      this.currentTab = params.initialTab
    }
  }

  filterList(list: ConnectionItem[]): ConnectionItem[] {  // 添加一个过滤列表的方法
    if (!this.searchText) {
      return list; // 如果搜索框为空，返回原列表
    }
    const lowerCaseSearchText = this.searchText.toLowerCase();
    return list.filter(item => item.name.toLowerCase().includes(lowerCaseSearchText));
  }

  @Builder
  ListItemBuilder(item: ConnectionItem) {   // 添加一个通用的列表项渲染方法
    Row() {
      // 头像
      Image(item.avatar)
        .width(48)
        .height(48)
        .borderRadius(24)
        .margin({ right: 12 })

      // 用户信息
      Column() {
        Text(item.name)
          .fontSize(16)
          .fontColor(Color.White)
          .margin({ bottom: 4 })
        
        if (this.currentTab === 0) {
          Row() {
            if (item.description) {
              Text(item.description)
                .fontSize(12)
                .fontColor(Color.Green)
                .border({
                  radius: 4,
                  color: Color.Green,
                  width: 1
                })
                .padding({left: 4, right: 4})
                .margin({right: 4})
            }
            if (item.status) {
              Text(item.status)
                .fontSize(14)
                .fontColor('#999999')
            }
          }
        } else if (this.currentTab === 1) {
          if (item.unreadWorks) {
            Row() {
              Text(item.unreadWorks)
                .fontSize(12)
                .fontColor(Color.Gray)
              Text(' | 看作品 >')
                .fontSize(12)
                .fontColor(Color.White)
            }
          } else if (item.status) {
            Text(item.status)
              .fontSize(14)
              .fontColor('#999999')
          }
        } else if (this.currentTab === 2) {
          if (item.description) {
            Text(item.description)
              .fontSize(14)
              .fontColor('#999999')
          }
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      // 按钮
      if (item.buttonText) {
        Button(this.isFollowedSet.has(item.name) ? (this.currentTab === 2 ? '已请求' : '已关注') : (item.buttonText === '互相关注' ? '关注' : item.buttonText), 
          { type: ButtonType.Normal, stateEffect: true })
          .fontSize(this.currentTab === 1 ? 13 : 12)
          .fontColor(this.isFollowedSet.has(item.name) ? '#999999' : '#FFFFFF')
          .backgroundColor(this.isFollowedSet.has(item.name) ? Color.White : '#FF0000')
          .border({
            width: 1,
            color: this.isFollowedSet.has(item.name) ? Color.Gray : '#FF0000',
            style: BorderStyle.Solid
          })
          .width(this.currentTab === 1 ? 90 : 85)
          .height(32)
          .margin({ right: 8 })
          .onClick(() => {
            // 只有在关注列表(currentTab === 1)点击时才记录顺序
            if (this.currentTab === 1) {
              if (!this.isFollowedSet.has(item.name)) {
                this.isFollowedSet.add(item.name);
                this.followedUsersMap.set(item.name, item); // 添加到Map，保持点击顺序
              } else {
                this.isFollowedSet.delete(item.name);
                this.followedUsersMap.delete(item.name); // 从Map中移除
              }
            } else { // 其他列表（互关、粉丝）点击时只更新followedUsersSet状态，不影响排序Map
              if (!this.isFollowedSet.has(item.name)) {
                this.isFollowedSet.add(item.name);
              } else {
                this.isFollowedSet.delete(item.name);
              }
            }
          })
      }
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 8, bottom: 8 })
  }

  // 排序选项构建器
  @Builder
  SortingOptionsBuilder() {
    Column() {
      Text('综合排序')
        .fontSize(16)
        .fontColor(this.selectedSort === '综合排序' ? Color.Red : Color.Black)
        .padding(10)
        .onClick(() => {
          this.selectedSort = '综合排序';
          this.showSortingOptions = false;
        })
      Divider()
        .strokeWidth(0.5)
        .color(Color.Gray)
      Text('最近关注')
        .fontSize(16)
        .fontColor(this.selectedSort === '最近关注' ? Color.Red : Color.Black)
        .padding(10)
        .onClick(() => {
          this.selectedSort = '最近关注';
          this.showSortingOptions = false;
        })
      Divider()
        .strokeWidth(0.5)
        .color(Color.Gray)
      Text('最早关注')
        .fontSize(16)
        .fontColor(this.selectedSort === '最早关注' ? Color.Red : Color.Black)
        .padding(10)
        .onClick(() => {
          this.selectedSort = '最早关注';
          this.showSortingOptions = false;
        })
    }
    .width(150) // 设置宽度
    .backgroundColor(Color.White) // 白色背景
    .borderRadius(8) // 圆角
    .shadow({
      radius: 5,
      color: 'rgba(0, 0, 0, 0.2)',
      offsetX: 0,
      offsetY: 2
    }) // 阴影
    .zIndex(1) // 确保在其他内容之上
   .margin({ bottom: 200, left: 180 }) // 调整位置，使其出现在排序文本下方
    .align(Alignment.TopEnd) // 将排序选项对齐到Stack的右上角
  }

  build() {
    Stack() { // 将Stack作为新的根节点
      Column() { // 将原有的Column移到Stack内部
        // 顶部导航栏
        Row(){
          Text('←')
            .fontSize(20)
            .fontColor(Color.White)
            .onClick(() => router.pushUrl({ url: 'Mine/pages/ProfileCenter' }))

          Row({space:20}) {
            Text('互关')
              .fontSize(22)
              .fontColor(this.currentTab === 0 ? Color.White : Color.Gray)
              .fontWeight(this.currentTab === 0 ? FontWeight.Bold : FontWeight.Normal)
              .padding({ right: 10 })
              .onClick(() => this.currentTab = 0)
            Text('关注')
              .fontSize(22)
              .fontColor(this.currentTab === 1 ? Color.White : Color.Gray)
              .fontWeight(this.currentTab === 1 ? FontWeight.Bold : FontWeight.Normal)
              .padding({  right: 10 })
              .onClick(() => this.currentTab = 1)
            Text('粉丝')
              .fontSize(22)
              .fontColor(this.currentTab === 2 ? Color.White : Color.Gray)
              .fontWeight(this.currentTab === 2 ? FontWeight.Bold : FontWeight.Normal)
              .padding({  right: 10 })
              .onClick(() => this.currentTab = 2)
          }
          .layoutWeight(1)
          .justifyContent(FlexAlign.Center)

        }
        .width('100%')
        .height(56)
        .padding({ left: 16 })
        .backgroundColor('#000000')
        .alignItems(VerticalAlign.Center)
        .margin({top:5})

        // 搜索栏
        TextInput({
          placeholder: '搜索用户备注或名字',
          text: this.searchText // 绑定搜索框的值
        })
          .onChange((value) => {
            this.searchText = value; // 更新搜索关键字
          })
          .backgroundColor('#333333')
          .fontColor(Color.White)
          .placeholderColor(Color.Gray)
          .borderRadius(8)
          .margin(16)
          .padding({ left: 12, right: 12 })
          .height(40)

        // 关注页面特有的分类按钮和排序
        if (this.currentTab === 1) {
          Column() {
            // 添加条件：只有当搜索框为空时才显示这些元素
            if (!this.searchText) {
              // 分类按钮
              Row({space:10}) {

                Text('有更新 (99+)')
                  .fontSize(15)
                  .fontColor(Color.Black)
                  .backgroundColor(Color.White)
                  .borderRadius(5)
                  .height(35)
                  .width(100)
                  .textAlign(TextAlign.Center)
                  .margin({ right: 8 })

                Text('直播中 (7)')
                  .fontSize(14)
                  .fontColor(Color.Black)
                  .backgroundColor(Color.White)
                  .borderRadius(5)
                  .height(35)
                  .width(100)
                  .textAlign(TextAlign.Center)
                  .margin({ right: 8 })
                Text('批量管理')
                  .fontSize(14)
                  .fontColor(Color.Black)
                  .backgroundColor(Color.White)
                  .borderRadius(5)
                  .height(35)
                  .width(100)
                  .textAlign(TextAlign.Center)
                  .margin({ right: 8 })
              }
              .padding({ left: 16, right: 16, bottom: 8 })

              // 我的关注数量和排序
              Row() {
                Text('我的关注 (' + followingList.length + '人)')
                  .fontSize(14)
                  .fontColor(Color.Gray)
                  .layoutWeight(1)
                Text(this.selectedSort) // 显示当前选中的排序方式
                  .fontSize(14)
                  .fontColor(Color.Gray)
                Image($r('app.media.sort')) // 假设排序图标资源
                  .width(20)
                  .height(15)
                  .fillColor(Color.White)
                  .margin({ right: 14 })
              }
              .padding({ left: 16, right: 16, bottom: 8 })
              .onClick(() => this.showSortingOptions = true) // 点击触发排序选项显示
            }
          }
        }

        // 列表内容 (根据当前Tab显示不同的数据)
        Column() {
          List() {
            ForEach(
              this.currentTab === 0 ? this.filterList(interacList) : // 互关列表
              this.currentTab === 1 ? // 关注列表，根据排序方式处理
              (() => {
                let filteredList = this.filterList(followingList);
                if (this.selectedSort === '最近关注') {
                  // 模拟最近关注：将被点击的用户按点击顺序反转排在前面，其余用户不变
                  let clickedList = Array.from(this.followedUsersMap.values()).reverse();
                  let remainingList = filteredList.filter(user => !this.isFollowedSet.has(user.name));
                  return clickedList.concat(remainingList);
                } else if (this.selectedSort === '最早关注') {
                  // 模拟最早关注：将被点击的用户按点击顺序排在前面，其余用户不变
                  let clickedList = Array.from(this.followedUsersMap.values());
                  let remainingList = filteredList.filter(user => !this.isFollowedSet.has(user.name));
                  return clickedList.concat(remainingList);
                } else {
                  // 综合排序：保持原序
                  return filteredList;
                }
              })() :
              this.filterList(fanslist), // 粉丝列表
              (item: ConnectionItem) => {
                ListItem() {
                  this.ListItemBuilder(item)
                }
              }
            )
          }
          .width('100%')
          .layoutWeight(1)
        }
        .width('100%')
        .layoutWeight(1)

      } // 原Column结束
      .width('100%')
      .height('100%')
      .backgroundColor('#000000')

      // 显示排序选项浮层
      if (this.showSortingOptions) {
        this.SortingOptionsBuilder() // 直接调用Builder方法，它已经设置了位置和zIndex
      }
    } // Stack结束
    .width('100%')
    .height('100%')
  }
}
