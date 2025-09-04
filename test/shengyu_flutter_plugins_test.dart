import 'package:flutter_test/flutter_test.dart';
import 'package:shengyu_flutter_plugins/core/shengyu_flutter_plugins.dart';
class MockShengyuFlutterPluginsPlatform  {
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  test('getPlatformVersion', () async {
    ShengyuFlutterPlugins shengyuFlutterPluginsPlugin = ShengyuFlutterPlugins();
    MockShengyuFlutterPluginsPlatform fakePlatform = MockShengyuFlutterPluginsPlatform();

    expect(await shengyuFlutterPluginsPlugin.getPlatformVersion(), 'Web');
  });
}
