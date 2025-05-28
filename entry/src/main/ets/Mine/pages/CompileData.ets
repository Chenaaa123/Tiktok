import { router } from '@kit.ArkUI'
import promptAction from '@ohos.promptAction'


interface RouteParams {
  name: string;
  brief: string;
  avatar: Resource;
}

@Entry
@Component
export default struct CompileData {
  @State name: string = '萌萌的路飞'//用户名
  @State brief: string = ''  //简介
  @State isEditing: boolean = false
  @State tempName: string = ''
  @State tempBrief: string = ''
  @State avatar: Resource = $r('app.media.userA')  // 默认头像
  @State tempAvatar: Resource = $r('app.media.userB')  // 临时头像

  // 随机头像数组
  private avatarList: Resource[] = [
    $r('app.media.userC'),
    $r('app.media.userD')

  ]

  selectImage() {
    try {
      // 随机选择一个头像
      const randomIndex = Math.floor(Math.random() * this.avatarList.length)
      this.avatar = this.avatarList[randomIndex]
      this.tempAvatar = this.avatar
      promptAction.showToast({ message: '头像已更新' })
    } catch (err) {
      console.error('Failed to select image:', err)
      promptAction.showToast({ message: '更换头像失败' })
    }
  }

  aboutToAppear() {
    const params = router.getParams() as RouteParams
    if (params) {
      if (params.name) {
        this.name = params.name
        this.tempName = params.name
      }
      if (params.brief) {
        this.brief = params.brief
        this.tempBrief = params.brief
      }
      if (params.avatar) {
        this.avatar = params.avatar
        this.tempAvatar = params.avatar
      }
    }
  }

  build() {
      Column() {
        Row() {
          // 返回按钮
          Text('←')
            .fontSize(20)
            .margin({ left: 10 })
            .onClick(() => {
              router.pushUrl({
                url: 'Mine/pages/ProfileCenter',
                params: {
                  name: this.name,
                  brief: this.brief,
                  avatar: this.avatar
                }
              })
              router.clear()
            })

          // 保存按钮
          if (this.isEditing) {
            Text('保存')
              .fontSize(16)
              .fontColor('#007DFF')
              .margin({ right: 16 })
              .onClick(() => {
                if (this.tempName.trim() === '') {
                  promptAction.showToast({ message: '用户名不能为空' })
                  return
                }
                this.name = this.tempName
                this.brief = this.tempBrief
                if (this.tempAvatar) {
                  this.avatar = this.tempAvatar
                }
                this.isEditing = false
                promptAction.showToast({ message: '保存成功' })
                // 保存后返回并传递数据
                router.pushUrl({
                  url: 'pages/Profile_Center',
                  params: {
                    name: this.name,
                    brief: this.brief,
                    avatar: this.avatar
                  }
                })
              })
          } else {
            Text('编辑')
              .fontSize(16)
              .fontColor('#007DFF')
              .margin({ right: 16 })
              .onClick(() => {
                this.tempName = this.name
                this.tempBrief = this.brief
                this.tempAvatar = this.avatar
                this.isEditing = true
              })
          }
        }
        .width('100%')
        .height(60)
        .justifyContent(FlexAlign.SpaceBetween)

        // 头像+更换头像
        Column() {
          Stack() {
            Image(this.avatar)
              .width(100).height(100)
              .borderRadius(50)
            if (this.isEditing) {
              Text('更换头像')
                .fontSize(12)
                .fontColor(Color.Gray)
                .onClick(() => this.selectImage())
            }
          }
          .margin({ top: 5})
        }
        .alignItems(HorizontalAlign.Center)
        .margin({ top: 10 })

        // 资料项
        Column() {
          if (this.isEditing) {
            // 编辑模式
            Row() {
              Text('用户名')
                .fontSize(16)
                .fontColor(Color.Black)
                .width(80)
                .textAlign(TextAlign.Center)
              TextInput({ text: this.tempName })
                .fontSize(16)
                .fontColor('#222')
                .backgroundColor(Color.Transparent)
                .width('60%')
                .onChange((value: string) => {
                  this.tempName = value
                })
            }
            .width('95%')
            .height(48)
            .alignItems(VerticalAlign.Center)
            .margin({ left: 16, right: 16, top: 1})
            .backgroundColor('#BEBEBE')
            .borderRadius(5)

            Row() {
              Text('简介')
                .fontSize(16)
                .fontColor(Color.Black)
                .width(80)
                .textAlign(TextAlign.Center)
              TextInput({ text: this.tempBrief })
                .fontSize(16)
                .fontColor('#222')
                .backgroundColor(Color.Transparent)
                .width('60%')
                .onChange((value: string) => {
                  this.tempBrief = value
                })
            }
            .width('95%')
            .height(48)
            .alignItems(VerticalAlign.Center)
            .margin({ left: 16, right: 16, top: 1})
            .backgroundColor('#BEBEBE')
            .borderRadius(5)
          } else {
            // 显示模式
            Row() {
              Text('用户名')
                .fontSize(16)
                .fontColor(Color.Black)
                .width(80)
                .textAlign(TextAlign.Center)
              Text(this.name)
                .fontSize(16)
                .fontColor('#222')
            }
            .width('95%')
            .height(48)
            .alignItems(VerticalAlign.Center)
            .margin({ left: 16, right: 16, top: 1})
            .backgroundColor('#BEBEBE')
            .borderRadius(5)

            Row() {
              Text('简介')
                .fontSize(16)
                .fontColor(Color.Black)
                .width(80)
                .textAlign(TextAlign.Center)
              Text(this.brief)
                .fontSize(16)
                .fontColor('#222')
            }
            .width('95%')
            .height(48)
            .alignItems(VerticalAlign.Center)
            .margin({ left: 16, right: 16, top: 1})
            .backgroundColor('#BEBEBE')
            .borderRadius(5)
          }
        }
        .width('100%')
        .backgroundColor(Color.White)
        .borderRadius({ topLeft: 24, topRight: 24 })
        .margin({ top: 20 })
        .padding({ top: 10, bottom: 20 })
      }
      .width('100%')
      .backgroundColor('linear-gradient(180deg, #B2D8FF 0%, #FFFFFF 100%)')
  }
}
