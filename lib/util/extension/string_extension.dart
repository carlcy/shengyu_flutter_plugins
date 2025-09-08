import 'package:intl/intl.dart';
import 'package:shengyu_flutter_plugins/enum/date_time_type.dart';

extension StringExtension on String? {
  /// 空安全
  String get nullSafe => this ?? '';

  /// 是否为空
  bool get isEmptyOrNull => this == null || this!.isEmpty;

  /// 是否不为空
  bool get isNotNullAndEmpty => this != null && this!.isNotEmpty;

  /// 为国际化做准备,如果要考虑国际化在这里根据选择的语言，返回不同的翻译
  String get tr => this ?? '';

  /// 根据枚举格式将时间戳字符串转换为日期时间字符串
  String? toFormattedDate(DateTimeFormats format) {
    if (isEmptyOrNull) return null;
    try {
      final timestamp = int.parse(this!);
      return DateFormat(format.format).format(DateTime.fromMillisecondsSinceEpoch(timestamp));
    } catch (e) {
      return null;
    }
  }

  /// 根据枚举格式将日期字符串转换为时间戳字符串
  String? fromFormattedDate(DateTimeFormats format) {
    if (isEmptyOrNull) return null;
    try {
      final dateTime = DateFormat(format.format).parse(this!);
      return dateTime.millisecondsSinceEpoch.toString();
    } catch (e) {
      return null;
    }
  }

  /// 时间戳字符串转换为相对时间（刚刚、x分钟前、x小时前、昨天、x天前）
  String? get toRelativeTime {
    if (isEmptyOrNull) return null;
    try {
      final timestamp = int.parse(this!);
      final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
      final now = DateTime.now();
      final difference = now.difference(dateTime);

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
        return toFormattedDate(DateTimeFormats.date);
      }
    } catch (e) {
      return null;
    }
  }

  DateTime? get toDateTime {
    if (isEmptyOrNull) return null;
    try {
      final timestamp = int.parse(this!);
      return DateTime.fromMillisecondsSinceEpoch(timestamp);
    } catch (e) {
      return null;
    }
  }
}
