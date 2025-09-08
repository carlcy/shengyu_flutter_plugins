import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:shengyu_flutter_plugins/log/log_util.dart';

class TakePhotosOrAlbum {
  TakePhotosOrAlbum._();

  // 获取图片(拍照或相册)
  static getImage(bool isCamera, Function(File) callback) async {
    final ImagePicker picker = ImagePicker();
    ImageSource source = isCamera ? ImageSource.camera : ImageSource.gallery;
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      callback(File(pickedFile.path));
    } else {
      printLog('No image selected.');
    }
  }
}