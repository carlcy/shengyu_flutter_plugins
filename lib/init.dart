class ShengYuGlobalManager {
  // 单例实例
  static final ShengYuGlobalManager _instance =
      ShengYuGlobalManager._internal();

  // 工厂构造函数
  factory ShengYuGlobalManager() {
    return _instance;
  }

  // 私有构造函数
  ShengYuGlobalManager._internal() {}

  /// 默认的暂无网络的image地址
  String defaultNetWorkImage = 'assets/images/default_loading_error';

  /// 看是用默认的图标还是自定义的图标
  bool isDefaultNetWorkImage = true;

  // 初始化函数
  Future<void> init({String? defaultNetWorkImage}) async {
    /// 先给默认的网络图片地址赋值
    if (defaultNetWorkImage != null && defaultNetWorkImage.isNotEmpty) {
      this.defaultNetWorkImage = defaultNetWorkImage;
      isDefaultNetWorkImage = false;
    }
  }
}
