// 日期工具类
class DateFormatUtil {

  /**
   * 秒转换成HH:mm:ss。
   *
   * @param seconds最大视频时长(秒)。
   * @return 转换后的时间。
   */
  secondToTime(seconds: number): string {
    let hourUnit = 60 * 60;
    let hour = Math.floor(seconds / hourUnit);
    let minute = Math.floor((seconds - hour * hourUnit) / 60);
    let second = seconds - hour * hourUnit - minute * 60;
    if (hour > 0) {
      return `${this.padding(hour.toString())}${':'}
        ${this.padding(minute.toString())}${':'}${this.padding(second.toString())}`;
    }
    if (minute > 0) {
      return `${this.padding(minute.toString())}${':'}${this.padding(second.toString())}`;
    } else {
      return `'00'${':'}${this.padding(second.toString())}`;
    }
  }

  /**
   * 零填充，2位。
   *
   * @param num 要转换的数字。
   * @return 零填充后的结果。
   */
  padding(num: string): string {
    let length = 2;
    for (let len = (num.toString()).length; len < length; len = num.length) {
      num = `'0'${num}`;
    }
    return num;
  }
}

export default new DateFormatUtil();

