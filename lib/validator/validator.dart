/// 用来存放各种验证器
class AllValidator {
  /// 账号密码验证
  /// 至少6位，同时包含大小写字母和数字
  static String? passwordValidator(value) {
    if (!RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,}$")
        .hasMatch(value!)) {
      return "密码格式不正确";
    } else {
      return null;
    }
  }

  /// 邮箱验证
  static String? emailValidator(String? value) {
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value!)) {
      return "邮箱格式不正确";
    } else {
      return null;
    }
  }

  /// 手机号验证，如果必须是11位 并且是1开头
   static String? phoneNumberValidator(String? value) {
    if (!RegExp(r"^1[3456789]\d{9}$").hasMatch(value!)) {
      return "手机号格式不正确";
    } else {
      return null;
    }
  }
}
