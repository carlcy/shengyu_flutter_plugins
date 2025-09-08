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