
import promptAction from '@ohos.promptAction';
import { router } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';
  @State current_index: number = 0
  @Styles style1(){
    .width(80)
    .height(80)
  }

  @Builder
  tabBuilder(index:number ,title: string) {
    if(index === this.current_index){
      Text(title)
        .fontWeight(800)
        .fontSize(20)
        .fontColor(Color.White)
        .border({width:{bottom:2},color:'red'})
    }else {
      Text(title)
        .fontWeight(800)
        .fontSize(20)
        .fontColor(Color.White)
    }
  }

  build() {
    Column(){
      Row(){
        Button('×')
          .backgroundColor('black')
          .fontColor('white')
          .fontSize(25)
          .onClick(()=>{
            router.pushUrl({
              url: "Discover/page/text1",
            })
          })
        Text('创建内容')
          .fontSize(25)
          .fontWeight(20)
          .fontColor('white')
        Button('发布')
          .backgroundColor('red')
          .fontColor('white')
          .fontWeight(FontWeight.Bold)
          .fontSize(15)
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('95%')
      .margin({top:10})

      Divider()
        .color('rgba(255,255,255,0.1)')
        .margin({top:20})
        .strokeWidth(1)

      Scroll(){
        Column(){
          Row(){
            Tabs(){
              TabContent(){
                Button('+')
                  .backgroundColor('rgba(255,255,255,0.1)')
                  .fontColor('white')
                  .fontSize(40)
                  .style1()
              }.tabBar(this.tabBuilder(0,'视频'))
              .backgroundColor('#1a1a1a')

              TabContent(){
                Button('📷')
                  .backgroundColor('rgba(255,255,255,0.1)')
                  .fontSize(40)
                  .style1()
              }.tabBar(this.tabBuilder(1,'照片'))
              .backgroundColor('#1a1a1a')

              TabContent(){
                Button('🎵')
                  .backgroundColor('rgba(255,255,255,0.1)')
                  .fontSize(40)
                  .style1()
              }.tabBar(this.tabBuilder(2,'音乐'))
              .backgroundColor('#1a1a1a')

              TabContent(){
                Button('📝')
                  .backgroundColor('rgba(255,255,255,0.1)')
                  .fontSize(40)
                  .style1()
              }.tabBar(this.tabBuilder(3,'文字'))
              .backgroundColor('#1a1a1a')
            }
            .barHeight('20%')
            .onChange((index)=>{
              this.current_index = index
            })
          }
          .height('35%')

          Row(){
            Column(){
              Button('✂️')
                .backgroundColor('rgba(255,255,255,0.1)')
                .height('50')
                .width('50')
                .onClick(()=>{
                  promptAction.showToast({message:'进行裁剪'})
                })
              Text('裁剪')
                .fontColor('white')
            }
            Column(){
              Button('🎨')
                .backgroundColor('rgba(255,255,255,0.1)')
                .height('50')
                .width('50')
                .onClick(()=>{
                  promptAction.showToast({message:'使用滤镜'})
                })
              Text('滤镜')
                .fontColor('white')
            }
            Column(){
              Button('✨')
                .backgroundColor('rgba(255,255,255,0.1)')
                .height('50')
                .width('50')
                .onClick(()=>{
                  promptAction.showToast({message:'添加特效'})
                })
              Text('特效')
                .fontColor('white')
            }
            Column(){
              Button('⚡')
                .backgroundColor('rgba(255,255,255,0.1)')
                .height('50')
                .width('50')
                .onClick(()=>{
                  promptAction.showToast({message:'调节画面'})
                })
              Text('调节')
                .fontColor('white')
            }
            Column(){
              Button('💬')
                .backgroundColor('rgba(255,255,255,0.1)')
                .height('50')
                .width('50')
                .onClick(()=>{
                  promptAction.showToast({message:'添加字幕'})
                })
              Text('字幕')
                .fontColor('white')
            }
          }
          .justifyContent(FlexAlign.SpaceBetween)
          .margin({top:10})
          .width('90%')
          .height('10%')

          Divider()
            .color('rgba(255,255,255,0.1)')
            .margin({top:10})
            .strokeWidth(1)

          Column({space:8}){
            Row(){
              Text('音乐')
                .fontColor('white')
                .fontWeight(800)
                .fontSize(20)
              Button('更多')
                .fontColor('red')
                .backgroundColor('black')
                .fontSize('15')
            }
            .width('96%')
            .justifyContent(FlexAlign.SpaceBetween)
            .margin({left:20})
            Row(){
              Image($r('app.media.music_cover'))
                .width(50)
                .border({radius:10,color:'rgba(255,255,255,0.2)',width:1})
              Text('音乐封面')
                .fontColor('white')
                .fontSize(20)
                .width(40)
                .margin({left:5})
              Column(){
                Text('晚风轻抚')
                  .fontWeight(FontWeight.Bold)
                  .fontColor('white')
                Text('轻音乐大师-心灵治愈系列')
                  .fontColor('white')
                  .fontSize('12')
              }
              .margin({left:10})
              .width('138')
              .alignItems(HorizontalAlign.Start)
              Text('♫')
                .fontColor('white')
                .margin({left:100})
            }
            .width('95%')
          }
          .height('15%')
          .width('100%')

          Divider()
            .color('rgba(255,255,255,0.1)')
            .margin({top:10, bottom:15})
            .strokeWidth(1)

          Row(){
            Stack({alignContent:Alignment.BottomStart}){
              TextArea({placeholder:'添加视频描述...'})
                .backgroundColor('rgba(255,255,255,0.2)')
                .showCounter(true)
                .maxLength(200)
                .placeholderColor('rgba(255,255,255,0.2)')
                .height('25%')
              Text('#')
                .fontColor('rgba(255,255,255,0.3)')
                .fontSize(25)
                .margin({left:30,bottom:10})
            }
          }
          .width('95%')
          Row(){
            Text('谁可以看')
              .fontColor('white')
            Text('公开 >')
              .fontColor('white')
          }
          .width('95%')
          .margin({top:30})
          .justifyContent(FlexAlign.SpaceBetween)

          Divider()
            .color('rgba(255,255,255,0.1)')
            .margin({top:10, bottom:15})
            .strokeWidth(1)

          Row(){
            Text('允许评论')
              .fontColor('white')
            Text('所有人 >')
              .fontColor('white')
          }
          .width('95%')
          .justifyContent(FlexAlign.SpaceBetween)

          Row(){
            Text('分享到动态')
              .fontColor('white')
            Text('开启 >')
              .fontColor('white')
          }
          .width('95%')
          .margin({top:20})
          .justifyContent(FlexAlign.SpaceBetween)
          Row(){}.height('5%')
        }
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor('black')
      .width('100%')
    }
    .backgroundColor('black')
    .width('100%')
    .height('100%')
  }
}