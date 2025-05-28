import CreatorItem from "../model/CreatorItem"
import { router } from "@kit.ArkUI"
import { BusinessError } from "@kit.BasicServicesKit"
import { CreatorList } from "../viewmodel/CreatorList"
import RecommendList from "./RecommendList"

// 推荐
@Component
export default struct Recommend {
  build() {
    Scroll() {
      Column() {
        // 正在流行
        Row() {
          Text('正在流行')
            .margin({ left: 10 })
            .fontColor(Color.White)
            .fontSize(16)
            .fontWeight(800)
          Text('查看全部')
            .margin({ right: 10 })
            .fontColor(Color.White)
            .fontSize(12)
            .fontWeight(400)
            .onClick(() => {
              router.pushUrl({
                url: 'Discover/pages/TrendingContent',    // 跳转到流行内容页面
                params: { defaultFilter: 'all' }
              }).then(() => {
                console.info('push page success');
              }).catch((err: BusinessError) => {
                console.error(`pushUrl failed, code is ${err.code}, message is ${err.message}`);
              })
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        Row() {
          Stack({ alignContent: Alignment.BottomStart }) {    // 子组件会按照左下角对齐
            Image($r("app.media.pixels"))
              .width(170)
              .height(170)
              .objectFit(ImageFit.Cover)
              .borderRadius(20)
              .onClick(()=>{
                router.pushUrl({
                  url: 'Discover/pages/TrendingContent',
                  params: { defaultFilter: 'dance' }  // 跳转到舞蹈分类
                }).then(() => {
                  console.info('push page success');
                }).catch((err: BusinessError) => {
                  console.error(`pushUrl failed, code is ${err.code}, message is ${err.message}`);
                })
              })
            Column() {
              Text('热门街舞视频')
                .fontSize(16)
                .fontColor(Color.White)
                .margin({ left: 10, bottom: 5 })
                .fontWeight(800)
              Text('10.2万次播放')
                .fontSize(12)
                .fontColor(Color.White)
                .margin({ bottom: 10, left: 10 })
            }.alignItems(HorizontalAlign.Start)
          }.width('50%')
          .margin({ left: 10 })

          Stack({ alignContent: Alignment.BottomStart }) {
            Image($r('app.media.rock'))
              .width(170)
              .height(170)
              .margin({ right: 5 })
              .objectFit(ImageFit.Cover)
              .borderRadius(20)
              .onClick(()=>{
                router.pushUrl({
                  url: 'Discover/pages/TrendingContent',
                  params: { defaultFilter: 'music' }  // 跳转到音乐分类
                }).then(() => {
                  console.info('push page success');
                }).catch((err: BusinessError) => {
                  console.error(`pushUrl failed, code is ${err.code}, message is ${err.message}`);
                })
              })
            Column() {
              Text('热门音乐榜单')
                .fontSize(16)
                .fontWeight(800)
                .fontColor(Color.White)
                .margin({ left: 10, bottom: 5 })
              Text('10.2万次播放')
                .fontSize(12)
                .fontColor(Color.White)
                .margin({ bottom: 10, left: 10 })
            }.alignItems(HorizontalAlign.Start)
          }.width('50%')
          .margin({ right: 10 })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .margin({ bottom: 20, top: 15 })

        // 热门创作者
        Row() {
          Text('热门创作者')
            .margin({ left: 10 })
            .fontColor(Color.White)
            .fontSize(16)
            .fontWeight(800)
          Text('查看全部')
            .margin({ right: 10 })
            .fontColor(Color.White)
            .fontSize(12)
            .fontWeight(400)
            .onClick(() => {        // 跳转到创作者页面
              router.pushUrl({
                url: 'Discover/pages/CreatorsAll'
              }).then(() => {
                console.info('push page success');
              }).catch((err: BusinessError) => {
                console.error(`pushUrl failed, code is ${err.code}, message is ${err.message}`);
              })
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        Row() {         // 只显示4个用户
          ForEach(CreatorList.slice(0, 4), (Creator: CreatorItem) => {
            Column() {
              Image(Creator.avatar)
                .sharedTransition(`sharedImage_${Creator.id}`, {  // 绑定用户ID使得动画唯一标识
                  duration: 300,
                  curve: Curve.EaseInOut,  // 缓慢开始和结束，中间加速
                  delay: 100
                })
                  /*改进了共享动画标识冲突，因为用户头像是循环渲染出来，不能用同一个动画标识
                   否则，每次动画转场都是从列表最后一个位置到目标位置*/
                  // .sharedTransition('sharedImage', { duration: 300, curve: Curve.EaseInOut, delay: 100 })
                .width(60)
                .height(60)
                .borderRadius(30)
                .margin({ bottom: 8 })
                .onClick(() => {
                  let paramsInfo: CreatorItem = Creator
                  router.pushUrl({
                    url: 'Mine/pages/ProfileCreator', // 跳转到用户主页并传递该用户数据
                    params: paramsInfo // 用户信息
                  }, (err) => {
                    if (err) {
                      console.error(`Invoke pushUrl failed, code is ${err.code}, message is ${err.message}`);
                      return;
                    }
                    console.info('Invoke pushUrl succeeded.');
                  })
                })

              Text(Creator.name)
                .fontSize(12)
                .fontWeight(500)
                .fontColor('#333333')
                .fontColor(Color.White)
            }
            .margin({ right: 20 })
          })
        }
        .width('100%')
        .padding({ left: 10 })
        .margin({ bottom: 20, top: 10 })

        // 为你推荐
        Row() {
          Text('为你推荐')
            .margin({ left: 10 })
            .fontColor(Color.White)
            .fontSize(16)
            .fontWeight(800)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        // 推荐列表组件
        Column(){
          RecommendList()
        }
        .width('100%').height(300).margin({ bottom: 30, top: 10 })

      }
      .height('auto')
      // height('100%') 不行
    }
    .height('100%')
  }
}

