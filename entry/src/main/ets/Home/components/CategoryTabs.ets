@Component
export struct CategoryTabs {
  @Link currentCategory: string;
  categories: string[] = ['全部', '音乐', '舞蹈', '游戏', '美食', '旅行'];

  @Builder
  CategoryItem(category: string) {
    Text(category)
      .fontSize(14)
      .fontColor(this.currentCategory === category ? '#FF2D55' : '#FFFFFF')
      .backgroundColor(this.currentCategory === category ? '#2A2A2A' : 'transparent')
      .padding({ left: 12, right: 12, top: 6, bottom: 6 })
      .borderRadius(16)
      .margin({ right: 8 })
      .onClick(() => {
        this.currentCategory = category;
      })
  }

  build() {
    Scroll() {
      Row() {
        ForEach(this.categories, (category: string) => {
          this.CategoryItem(category)
        })
      }
      .padding({ left: 16, right: 16 })
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .width('100%')
  }
} 