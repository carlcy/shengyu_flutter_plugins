import 'dart:async';
import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';

// 音频播放工具
// 有两种播放方式：
// （官网文档：https://github.com/bluefireteam/audioplayers/blob/main/getting_started.md）
class AudioUtil {
  AudioUtil._();

  static var _isInit = true;
  static var _player = AudioPlayer();
  static final _subscriberMap = <String, StreamSubscription>{};

  static bool isInit() {
    return _isInit;
  }

  static void init() {
    if (!isInit()) {
      _player = AudioPlayer();
      _isInit = true;
    }
  }

  // 播放本地文件
  static playFile(String filePath,
      {double? volume,
      double? balance,
      Duration? position,
      Function(Duration)? onPosition,
      Function(Duration)? onTotalTime,
      Function(PlayerState)? onPlayerState,
      Function()? onComplete}) async {
    play(DeviceFileSource(filePath),
        volume: volume,
        balance: balance,
        position: position,
        onPosition: onPosition,
        onTotalTime: onTotalTime,
        onPlayerState: onPlayerState,
        onComplete: onComplete);
  }

  // 播放应用Assets资源
  // （假设音频存储在/assets/audio/my-audio.wav，那么assetPath就是'audio/my-audio.wav'，已存在默认前缀，也可以修改）
  static playAsset(String assetPath,
      {double? volume,
      double? balance,
      Duration? position,
      Function(Duration)? onPosition,
      Function(Duration)? onTotalTime,
      Function(PlayerState)? onPlayerState,
      Function()? onComplete}) async {
    play(AssetSource(assetPath),
        volume: volume,
        balance: balance,
        position: position,
        onPosition: onPosition,
        onTotalTime: onTotalTime,
        onPlayerState: onPlayerState,
        onComplete: onComplete);
  }

  // 播放url
  static playUrl(String url,
      {double? volume,
      double? balance,
      Duration? position,
      Function(Duration)? onPosition,
      Function(Duration)? onTotalTime,
      Function(PlayerState)? onPlayerState,
      Function()? onComplete}) async {
    play(UrlSource(url),
        volume: volume,
        balance: balance,
        position: position,
        onPosition: onPosition,
        onTotalTime: onTotalTime,
        onPlayerState: onPlayerState,
        onComplete: onComplete);
  }

  // 播放字节流
  static playBytes(Uint8List bytes,
      {double? volume,
      double? balance,
      Duration? position,
      Function(Duration)? onPosition,
      Function(Duration)? onTotalTime,
      Function(PlayerState)? onPlayerState,
      Function()? onComplete}) async {
    play(BytesSource(bytes),
        volume: volume,
        balance: balance,
        position: position,
        onPosition: onPosition,
        onTotalTime: onTotalTime,
        onPlayerState: onPlayerState,
        onComplete: onComplete);
  }

  // 播放
  static play(Source source,
      {double? volume,
      double? balance,
      Duration? position,
      Function(Duration)? onPosition,
      Function(Duration)? onTotalTime,
      Function(PlayerState)? onPlayerState,
      Function()? onComplete}) async {
    if (!isInit()) init();
    _cancelSubscribers();

    // 设置按特定时间间隔更新位置
    _player.positionUpdater = TimerPositionUpdater(
      interval: const Duration(milliseconds: 1000),
      getPosition: _player.getCurrentPosition,
    );

    // 音频的当前位置
    _register(
        "onPositionChanged",
        () => _player.onPositionChanged.listen((Duration p) {
              if (onPosition != null) onPosition(p);
            }));

    // 音频的总时长
    _register(
        "onDurationChanged",
        () => _player.onDurationChanged.listen((Duration d) {
              if (onTotalTime != null) onTotalTime(d);
            }));

    // 玩家是否正在播放、停止或暂停
    _register(
        "onPlayerStateChanged",
        () => _player.onPlayerStateChanged.listen((PlayerState s) {
              if (onPlayerState != null) onPlayerState(s);
            }));

    // 完成事件
    _register(
        "onPlayerComplete",
        () => _player.onPlayerComplete.listen((_) {
              if (onComplete != null) onComplete();
            }));

    await _player.play(source,
        volume: volume, balance: balance, position: position);
  }

  /// 注册并监听事件
  static void _register(String subscriber, StreamSubscription Function() run) {
    String subscribeKey = "${_player.playerId}:$subscriber";
    if (!_subscriberMap.containsKey(subscribeKey)) {
      _subscriberMap[subscribeKey] = run();
    }
  }

  /// 取消注册
  static void _unregister(String subscriber) {
    String subscribeKey = "${_player.playerId}:$subscriber";
    StreamSubscription? subscription = _subscriberMap[subscribeKey];
    if (subscription != null) {
      subscription.cancel();
      _subscriberMap.remove(subscribeKey);
    }
  }

  // 设置源文件
  static setSourceFile(String path) async {
    await _player.setSourceDeviceFile(path);
  }

  // 设置源文件
  static setSourceAsset(String path) async {
    await _player.setSourceAsset(path);
  }

  // 设置源url
  static setSourceUrl(String url) async {
    await _player.setSourceUrl(url);
  }

  // 设置源url
  static setSourceBytes(Uint8List bytes) async {
    await _player.setSourceBytes(bytes);
  }

  // 暂停
  static pause() async {
    await _player.pause();
  }

  // 恢复
  static resume() async {
    await _player.resume();
  }

  // 停止（还可以使用）
  static stop() async {
    await _player.stop();
  }

  // 销毁（AudioPlayer实例不能再次使用）
  static release() async {
    await _player.dispose();
    _cancelSubscribers();
    _isInit = false;
  }

  // 取消全部事件订阅者
  static _cancelSubscribers() async {
    _subscriberMap.forEach((key, value) {
      value.cancel();
    });
    _subscriberMap.clear();
  }

  // 设置播放位置
  static seek(int seconds) async {
    await _player.seek(Duration(seconds: seconds));
  }

  // 更改音量。默认为1.0.它可以从0.0（静音）到1.0（最大；某些平台允许大于 1），线性变化
  static setVolume(double volume) async {
    await _player.setVolume(volume);
  }

  // 更改播放速率（即播放的“速度”）。默认为1.0（正常速度）。2.0将是 2 倍速度，等等。
  static setPlaybackRate(double playbackRate) async {
    await _player.setPlaybackRate(playbackRate);
  }

  // 更改立体声平衡。默认为0.0（两个通道）。1.0- 仅右声道，-1.0- 仅左声道。
  static setBalance(double balance) async {
    await _player.setBalance(balance);
  }

  // 获取总时长
  Future<Duration?> getDuration() {
    return _player.getDuration();
  }

  // 获取当前位置
  Future<Duration?> getCurrentPosition() {
    return _player.getCurrentPosition();
  }
}
