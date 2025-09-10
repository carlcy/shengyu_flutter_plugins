import 'package:intl/intl.dart';
import 'package:shengyu_flutter_plugins/enum/date_time_type.dart';

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