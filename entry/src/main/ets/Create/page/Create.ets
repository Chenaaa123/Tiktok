import promptAction from '@ohos.promptAction';
import { router } from '@kit.ArkUI';

@Entry
@Component
export default struct Create {
  @State text: string = '';
  @State current_index: number = 0

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

  @Builder
  tabContent(content:string){
    Button(content)
    .backgroundColor('rgba(255,255,255,0.1)')
    .fontColor('white')
    .fontSize(40)
    .width(80)
    .height(80)
  }

  @Builder
  buttonBuilder(content:string, message:string, text:string){
    Column(){
      Button(content)
        .backgroundColor('rgba(255,255,255,0.1)')
        .height('50')
        .width('50')
        .onClick(()=>{
          promptAction.showToast({message:message})
        })
      Text(text)
        .fontColor('white')
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
              url: "Home/pages/Index",
            })
            router.clear()
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
                this.tabContent('+')
              }.tabBar(this.tabBuilder(0,'视频'))
              .backgroundColor('#1a1a1a')

              TabContent(){
                this.tabContent('📷')
              }.tabBar(this.tabBuilder(1,'照片'))
              .backgroundColor('#1a1a1a')

              TabContent(){
                this.tabContent('🎵')
              }.tabBar(this.tabBuilder(2,'音乐'))
              .backgroundColor('#1a1a1a')

              TabContent(){
                this.tabContent('📝')
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
            this.buttonBuilder('✂️','进行裁剪','裁剪')
            this.buttonBuilder('🎨','使用滤镜','滤镜')
            this.buttonBuilder('✨','添加特效','特效')
            this.buttonBuilder('⚡','调节画面','调节')
            this.buttonBuilder('💬','添加字幕','字幕')
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
                .onClick(()=>{
                  router.pushUrl({url:'Create/page/MusicPage'})
                })
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
              TextArea({placeholder:'添加视频描述...',text:this.text})
                .backgroundColor('rgba(255,255,255,0.2)')
                .showCounter(true)
                .maxLength(520)
                .placeholderColor('rgba(255,255,255,0.2)')
                .height('25%')
                .onChange((text)=>{
                  this.text = text
                })
              Text('#话题')
                .fontColor('rgba(255,255,255,0.3)')
                .fontSize(20)
                .margin({left:30,bottom:10})
                .onClick(()=>{
                  this.text = this.text + '#话题'
                })
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