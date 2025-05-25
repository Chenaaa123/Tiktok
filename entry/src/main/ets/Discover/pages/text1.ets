import CreatorItem from '../model/CreatorItem';
import { router } from '@kit.ArkUI';

@Entry
@Component
export default struct text1 {
  @State creator: CreatorItem | null = null; // 修改为单个创作者对象

  aboutToAppear(): void {
    let params = router.getParams() as CreatorItem; // 直接获取创作者对象
    this.creator = params;
    console.info('获取传递过来的创作者信息:', JSON.stringify(this.creator));
  }

  build() {
    Column() {
      if (this.creator) { // 添加空值检查
        // 顶部创作者信息卡片
        Column() {
          // 头像和基本信息行
          Row() {
            Image(this.creator.avatar)
              .width(80)
              .height(80)
              .borderRadius(40)
              .margin({ right: 16 })
            
            Column() {
              Text(this.creator.name)
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.White)
              
              Text(this.creator.fans)
                .fontSize(14)
                .fontColor('#999999')
                .margin({ top: 4 })
              
              Text(this.creator.videos)
                .fontSize(14)
                .fontColor('#999999')
                .margin({ top: 4 })
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)
          }
          .width('100%')
          .padding(16)
          
          // 描述信息
          Text(this.creator.description)
            .fontSize(14)
            .fontColor(Color.White)
            .margin({ top: 12, left: 16, right: 16 })
            .textAlign(TextAlign.Start)
          
          // 标签行
          Row() {
            ForEach(this.creator.tags || [], (tag: string) => {
              Text(tag)
                .fontSize(12)
                .fontColor('#FF4081')
                .backgroundColor('#1A1A1A')
                .borderRadius(12)
                .padding({ left: 12, right: 12, top: 4, bottom: 4 })
                .margin({ right: 8 })
            })
          }
          .margin({ top: 12, left: 16, right: 16 })
          // .flexWrap(FlexWrap.Wrap)
          
          // 关注按钮
          Button(this.creator.followed ? '已关注' : '关注')
            .width(120)
            .height(36)
            .fontSize(14)
            .fontColor(this.creator.followed ? '#999999' : Color.White)
            .backgroundColor(this.creator.followed ? '#1A1A1A' : '#FF4081')
            .borderRadius(18)
            .margin({ top: 16, bottom: 16 })
        }
        .width('100%')
        .backgroundColor('#2A2A2A')
        .borderRadius(16)
        .margin(16)
      } else {
        // 如果没有数据，显示加载中或空状态
        Text('加载中...')
          .fontSize(16)
          .fontColor(Color.White)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.Black)
  }
}
