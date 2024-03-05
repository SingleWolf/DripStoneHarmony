import { HomeChannel } from './HomeChannel'

class MockData {
  listHomeChanel(): Array<HomeChannel> {
    let list: Array<HomeChannel> = []
    list.push(new HomeChannel('01', '学习'))
    list.push(new HomeChannel('02', 'UI'))
    list.push(new HomeChannel('03', '优化'))
    list.push(new HomeChannel('04', '算法'))
    list.push(new HomeChannel('05', '数据'))
    list.push(new HomeChannel('06', '排雷'))
    list.push(new HomeChannel('07', '推荐'))
    list.push(new HomeChannel('08', '工具'))
    return list
  }

  listHomeChannelIndex(): Array<number> {
    let channelIndex: number[] = [0, 1, 2, 3, 4, 5, 6, 7];
    return channelIndex
  }
}

export default new MockData();