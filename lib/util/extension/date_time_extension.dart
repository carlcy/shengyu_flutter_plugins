import 'package:intl/intl.dart';

/// 时间格式枚举
enum DateTimeFormats {
  /// 标准格式 (yyyy-MM-dd HH:mm:ss)
  standard('yyyy-MM-dd HH:mm:ss'),

  /// 日期格式 (yyyy-MM-dd)
  date('yyyy-MM-dd'),

  /// 时间格式 (HH:mm:ss)
  time('HH:mm:ss'),

  /// 短时间格式 (HH:mm)
  shortTime('HH:mm'),

  /// 年月格式 (yyyy-MM)
  yearMonth('yyyy-MM'),

  /// 月日格式 (MM-dd)
  monthDay('MM-dd'),

  /// 中文日期格式 (yyyy年MM月dd日)
  chineseDate('yyyy年MM月dd日'),

  /// 中文日期时间格式 (yyyy年MM月dd日 HH:mm:ss)
  chineseDateTime('yyyy年MM月dd日 HH:mm:ss');

  final String format;

  const DateTimeFormats(this.format);
}

extension DateTimeExtension on DateTime {
  /// 转换为时间戳（毫秒）
  int get timestamp => millisecondsSinceEpoch;

  /// 转换为时间戳字符串
  String get timestampString => timestamp.toString();

  /// 根据指定格式格式化日期时间
  String format(String format) {
    return DateFormat(format).format(this);
  }

  /// 根据枚举格式格式化日期时间
  String formatWithEnum(DateTimeFormats format) {
    return DateFormat(format.format).format(this);
  }

  /// 转换为相对时间字符串（例如：刚刚、x分钟前、x小时前、昨天、x天前）
  String get relativeTimeString {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inSeconds < 60) {
      return '刚刚';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}分钟前';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}小时前';
    } else if (difference.inDays == 1) {
      return '昨天';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}天前';
    } else {
      return formatWithEnum(DateTimeFormats.date);
    }
  }
}

extension StringDateTimeExtension on String {
  /// 从时间戳字符串转换为DateTime
  DateTime? get fromTimestamp {
    try {
      return DateTime.fromMillisecondsSinceEpoch(int.parse(this));
    } catch (e) {
      return null;
    }
  }

  /// 根据指定格式解析日期时间字符串
  DateTime? parse(String format) {
    try {
      return DateFormat(format).parse(this);
    } catch (e) {
      return null;
    }
  }

  /// 根据枚举格式解析日期时间字符串
  DateTime? parseWithEnum(DateTimeFormats format) {
    try {
      return DateFormat(format.format).parse(this);
    } catch (e) {
      return null;
    }
  }

  /// 转换为时间戳字符串
  String? get toTimestampString {
    final dateTime = parseWithEnum(DateTimeFormats.standard) ?? 
                    parseWithEnum(DateTimeFormats.date) ?? 
                    parseWithEnum(DateTimeFormats.time) ?? 
                    parseWithEnum(DateTimeFormats.yearMonth) ?? 
                    parseWithEnum(DateTimeFormats.monthDay) ??
                    parseWithEnum(DateTimeFormats.chineseDate) ?? 
                    parseWithEnum(DateTimeFormats.chineseDateTime);
    return dateTime?.timestampString;
  }
}

/// 统一的日期格式化扩展
class DateTimeFormatter {
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