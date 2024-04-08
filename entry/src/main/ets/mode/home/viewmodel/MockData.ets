import { HomeChannel } from './HomeChannel'
import { HomeItem } from './HomeItem'

class MockData {
  listHomeChanel(): Array<HomeChannel> {
    let list: Array<HomeChannel> = []
    HomeChannelList.forEach(item => {
      list.push(new HomeChannel(item.id, item.name))
    })
    return list
  }

  async listHomeItem(id: string): Promise<HomeItem[]> {
    let resultList: Array<HomeItem> = []
    HomeChannelList.forEach(async item => {
      if (item.id === id) {
        let dataList: any[] = item.data
        await dataList.forEach(d => {
          resultList.push(new HomeItem(d.sid, d.title))
        })
      }
    })
    return resultList
  }
}

export default new MockData();

//频道数据
const HomeChannelList: any[] = [
  {
    "id": "H01",
    "name": "学习",
    "data": [
      {
        "sid": "H01_S01",
        "title": "ArkTs调用C/C++"
      },
      {
        "sid": "H01_S02",
        "title": "H5与原生的交互"
      },
      {
        "sid": "H01_S03",
        "title": "锤子笔记"
      }
    ]
  },
  {
    "id": "H02",
    "name": "UI",
    "data": [
      {
        "sid": "H02_S01",
        "title": "UI_1"
      },
      {
        "sid": "H02_S02",
        "title": "UI_2"
      }
    ]
  },
  {
    "id": "H03",
    "name": "优化",
    "data": [
      {
        "sid": "H03_S01",
        "title": "Optimize_1"
      },
      {
        "sid": "H03_S02",
        "title": "Optimize_2"
      }
    ]
  },
  {
    "id": "H04",
    "name": "算法",
    "data": [
      {
        "sid": "H03_S01",
        "title": "算法_1"
      },
      {
        "sid": "H03_S02",
        "title": "算法_2"
      }
    ]
  },
  {
    "id": "H05",
    "name": "数据",
    "data": []
  },
  {
    "id": "H06",
    "name": "排雷",
    "data": []
  },
  {
    "id": "H07",
    "name": "推荐",
    "data": []
  },
  {
    "id": "H08",
    "name": "工具",
    "data": []
  }
]