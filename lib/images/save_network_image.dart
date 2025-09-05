import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shengyu_flutter_plugins/toast/toast.dart';

Future<void> saveNetworkImageToGallery(String imageUrl) async {
  try {
    // 检查权限
    if (await _requestPermission()) {
      // 下载图片
      var response = await Dio().get(
        imageUrl,
        options: Options(responseType: ResponseType.bytes),
      );

      // 将图片保存到图库
      final result = await ImageGallerySaverPlus.saveImage(
        Uint8List.fromList(response.data),
        quality: 80, // 压缩质量 (1-100)
        name: "dq_image_${DateTime.now().millisecondsSinceEpoch}", // 图片名称
      );

      if (result['isSuccess']) {
        Toast.show("图片保存成功！");
      } else {
        Toast.show("图片保存失败！");
      }
    }
  } catch (e) {
    Toast.show("保存图片出错：$e");
  }
}

Future<bool> _requestPermission() async {
  if (await Permission.storage.isGranted) {
    return true;
  }

  // Android 11 及以上
  if (await Permission.manageExternalStorage.request().isGranted) {
    return true;
  }

  // 处理权限被拒绝的情况
  Toast.show("存储权限被拒绝！");
  return false;
}
