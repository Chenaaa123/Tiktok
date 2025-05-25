import { HotItem } from '../model/DataModel';
import { HotItemComponent } from '../components/HotItemComponent';
import router from '@ohos.router';

@Component
export struct Home_Hot {
  @State category: string = 'all';
  @State hotList: HotItem[] = [
    {
      id: 'h001',
      type: 'music',
      title: '雨夜街头',
      cover: $rawfile('Video/Rain_Road.mp4'),
      playCount: 2540000
    },
    {
      id: 'h002',
      type: 'dance',
      title: '城市夜景',
      cover: $rawfile('Video/City_Night_View.mp4'),
      playCount: 1860000
    }
  ];

  build() {
    Column() {
      // 分类栏
      Scroll() {
        Row({ space: 15 }) {
          ForEach(['全部', '音乐', '舞蹈'], (type: string) => {
            Button() {
              Text(type)
                .fontSize(16)
                .fontColor(this.category === type.toLowerCase() ? '#FFFFFF' : '#666666')
            }
            .padding({
              left: 20,
              right: 20,
              top: 8,
              bottom: 8
            })
            .backgroundColor(this.category === type.toLowerCase() ? '#007DFF' : '#F5F5F5')
            .borderRadius(20)
            .type(ButtonType.Normal)
            .onClick(() => {
              this.category = type.toLowerCase();
              // 过滤逻辑（示例）
              // this.handleFilter();
            })
          })
        }
        .padding(16)
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)

      // 内容列表
      Grid() {
        ForEach(this.hotList, (item: HotItem) => {
          GridItem() {
            HotItemComponent({ data: item })
              .aspectRatio(1)
              .onClick(() => {
                router.pushUrl({
                  url: 'pages/VideoDetail',
                  params: {
                    itemId: item.id,
                    from: 'hot'
                  }
                });
              })
          }
          .margin(4)
        })
      }
      .columnsTemplate('1fr 1fr 1fr')
      .columnsGap(8)
      .rowsGap(8)
      .padding(16)
    }
    .backgroundColor('#FFFFFF')
  }
}