import RecommendItem from '../view/RecommendListItem';
import { CreatorList } from './CreatorList';


// 创建推荐列表数据
const  recommendList: RecommendItem[] = [
  new RecommendItem(1,$r('app.media.RecommendItemA'),'精选舞蹈教学：从零开始学习街舞基础动作',CreatorList[0],2.3),
  new RecommendItem(2,$r('app.media.RecommendItemB'),'轻音乐合集：助你放松心情，提高工作效率',CreatorList[1],1.8),
  new RecommendItem(3,$r('app.media.RecommendItemC'),'城市日落时分：捕捉美丽光影的摄影技巧',CreatorList[2],1.5),
];

export {recommendList}