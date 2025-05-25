import { Creator } from '../model/DataModel';
import { CreatorItem } from '../components/CreatorItem';
import router from '@ohos.router';

@Component
export struct Home_Follow {
  @State listSpace: number = 12
  @State followList: Creator[] = [
    {
      id: 'c001',
      name: '科技实验室',
      avatar: $r('app.media.avatar_1'),
      latestVideo: '全新折叠屏体验',
      isLive: true
    },
    {
      id: 'c002',
      name: '美食作家',
      avatar: $r('app.media.avatar_2'),
      latestVideo: '秘制红烧肉教程',
      isLive: false
    }
  ];

  build() {
    List({ space: this.listSpace}) {
      ForEach(this.followList, (creator: Creator) => {
        ListItem() {
          CreatorItem({ data: creator })
            .margin({ top: 8, bottom: 8 })
            .onClick(() => {
              router.pushUrl({
                url: 'Home/pages/CreatorProfile',
                params: {
                  id: creator.id,
                  name: creator.name
                }
              });
            })
        }
        .padding({ left: 16, right: 16 })
      })
    }
    .scrollBar(BarState.Off)
    .edgeEffect(EdgeEffect.Spring)
    .divider({
      strokeWidth: 1,
      color: '#EEE',
      startMargin: 16,
      endMargin: 16
    })
  }
}