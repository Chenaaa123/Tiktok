import Create from '../../Create/page/Create'
import Discover from '../../Discover/pages/Discover'
import Messages from '../../Messages/pages/Messages'
import Index_Recommendation from './Index_Recommendation'

import ProfileCenter from '../../Mine/pages/ProfileCenter'
import tabs from '../model/Tabmodel'
import {Tabs} from '../model/Tabmodel'

@Entry
@Component
struct Index {
  @State activeName: string = '首页'

  // tabs
  @Builder
  tabBarBuilder() {
    Row() {
      ForEach(tabs, (item: Tabs) => {
        Column() {
          Image(item.icon)
            .width(24)
            .aspectRatio(1)
            .fillColor(this.activeName === item.name ? $r('app.color.tab_click_color') : $r('app.color.tab_color'))
          Text(item.name)
            .fontColor(this.activeName === item.name ? $r('app.color.tab_click_color') : $r('app.color.tab_color'))
        }.onClick(() => {
          this.activeName = item.name
        })
      })
    }.width('100%').height('100%').justifyContent(FlexAlign.SpaceAround).backgroundColor(Color.Black)
  }

  build() {
    Navigation() {
      if (this.activeName === '首页') {
        Index_Recommendation()
      }
      else if (this.activeName === '发现') {
        Discover()
      }
      else if (this.activeName === '发布') {
        Create()
      }
      else if (this.activeName === '消息') {
        Messages()
      }
      else {
        ProfileCenter()
      }
    }
    .height('100%')
    .width('100%')
    .backgroundColor(Color.Black)
    .toolbarConfiguration(this.tabBarBuilder) // 设置自定义tabBar
  }
}