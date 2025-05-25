export interface Tabs {
  name: string,
  icon: ResourceStr
}

const tabs: Tabs[] = [
  { name: '首页', icon: $r('app.media.Home') },
  { name: '发现', icon: $r('app.media.Discover') },
  { name: '发布', icon: $r('app.media.Create') },
  { name: '消息', icon: $r('app.media.Messages') },
  { name: '我', icon: $r('app.media.Mine') },
]
export default tabs