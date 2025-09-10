import 'package:intl/intl.dart';
import 'package:shengyu_flutter_plugins/enum/date_time_type.dart';

class DateTimeFormatConstants {
  static const iso8601WithMillisecondsOnly = 'yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'';
  static const defaultDateTimeFormat = 'EEEE, d MMM y';
  static const dMMMyyyyHHmmFormatID = 'd MMM yyyy, HH.mm';
  static const dMMMyyyyHHmmFormatEN = 'd MMM yyyy, HH:mm';
  static const dMMMyyyyFormat = 'd MMM yyyy';
  static const ddMMMyyyyFormat = 'dd MMM yyyy';
  static const dMMMMyyyyFormat = 'd MMMM yyyy';
  static const ddMMyyyyFormat = 'ddMMyyyy';
  static const mMMyyyyFormat = 'MMM yyyy';
  static const ddMMMFormat = 'd MMM';
  static const timeHHmmssFormatID = 'HH.mm.ss';
  static const timeHHmmssFormatEN = 'HH:mm:ss';
  static const timeHHmmFormatID = 'HH.mm';
  static const timeHHmmFormatEN = 'HH:mm';
  static const eEEEdMMMMyFormat = 'EEEE, d MMMM y';
  static const yyyyMMdd = 'yyyy-MM-dd';
  static const ddMMyyyy = 'dd-MM-yyyy';
  static const day = 'dd';
  static const weekday = 'EEEE';
  static const month = 'MMM';
  static const ddMMMMyyyy = 'dd MMMM yyyy';
  static const ddMMMyyyy = 'dd MMM yyyy';
  static const timeMMMMyyyy = 'MMMM yyyy';
  static const mmyy = 'MM/yy';
  static const timeSeparater = ':';
  static const String monthFull = 'MMMM';
  static const String year = 'y';

  static const timeBooking = 'HH:mm';
  static const hHddMMyyyy = 'dd/MM/yyyy';

  /// 存储时间统一为时间戳（毫秒）
  //  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
  // int timestamp = DateTime.now().millisecondsSinceEpoch;

  String getWeekDay(int weekday) {
    switch (weekday) {
      case 1:
        return '一';
      case 2:
        return '二';
      case 3:
        return '三';
      case 4:
        return '四';
      case 5:
        return '五';
      case 6:
        return '六';
      case 7:
        return '日';
      default:
        return '';
    }
  }

  /// 处理时间
  String handleTime(String time) {
    DateTime dateTime = DateTime.parse(time);
    DateTime nowTime = DateTime.now();

    /// 如果是同一天，那么就只显示时间点
    if (dateTime.year == nowTime.year &&
        dateTime.month == nowTime.month &&
        dateTime.day == nowTime.day) {
      return DateFormat(timeBooking).format(dateTime).toString();
    }

    /// 如果是前一天那么显示昨天

    else if (nowTime.day == dateTime.day + 1) {
      return '昨天';
    }

    /// 如果是同一个周，那么显示周几
    else if (dateTime.year == nowTime.year &&
        dateTime.month == nowTime.month &&
        dateTime.day >= nowTime.day - 7) {
      return '周${getWeekDay(dateTime.weekday)}';
    }

    /// 如果是同一年，那么显示月-日
    else if (dateTime.year == nowTime.year) {
      return '${dateTime.month}-${dateTime.day}';
    }

    /// 否则显示年-月-日
    else {
      return '${dateTime.year}-${dateTime.month}-${dateTime.day}';
    }
  }

  // 解析自定义格式的字符串
  static DateTime? parseCustomFormat(String dateString, String formatPattern) {
    try {
      DateFormat format = DateFormat(formatPattern);
      return format.parse(dateString);
    } catch (e) {
      print('解析自定义格式失败: $e');
      return null;
    }
  }

  // 按格式获取当前时间字符串
  static String getNowCustomFormat(String formatPattern) {
    // 获取当前时间的 DateTime 对象
    DateTime now = DateTime.now();
    // 按指定格式输出当前时间
    String formattedNow = DateFormat(formatPattern).format(now);
    return formattedNow;
  }

  /// 根据指定格式格式化日期时间
  static String format(DateTime dateTime, String format) {
    return DateFormat(format).format(dateTime);
  }

  /// 根据指定格式解析日期时间字符串
  static DateTime? parse(String dateTimeString, String format) {
    try {
      return DateFormat(format).parse(dateTimeString);
    } catch (e) {
      return null;
    }
  }

  /// 根据枚举格式格式化日期时间
  static String formatWithEnum(DateTime dateTime, DateTimeFormats format) {
    return DateFormat(format.format).format(dateTime);
  }

  /// 根据枚举格式解析日期时间字符串
  static DateTime? parseWithEnum(String dateTimeString, DateTimeFormats format) {
    try {
      return DateFormat(format.format).parse(dateTimeString);
    } catch (e) {
      return null;
    }
  }
}
