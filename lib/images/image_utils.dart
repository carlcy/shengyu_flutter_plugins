import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shengyu_flutter_plugins/util/extension/string_extension.dart';

class ImageUtils {
  static ImageProvider getAssetImage(String name, {ImageFormat format = ImageFormat.png, String? packageName}) {
    return AssetImage(getImgPath(name, format: format), package: packageName);
  }

  static String getImgPath(String name, {ImageFormat format = ImageFormat.png}) {
    return 'assets/images/$name.${format.value}';
  }

  static ImageProvider getImageProvider(String? imageUrl, {String holderImg = 'none', String? packageName}) {
    if (imageUrl.isEmptyOrNull) {
      return AssetImage(getImgPath(holderImg), package: packageName);
    }
    return CachedNetworkImageProvider(imageUrl!);
  }
}

enum ImageFormat { png, jpg, gif, webp }

extension ImageFormatExtension on ImageFormat {
  String get value => ['png', 'jpg', 'gif', 'webp'][index];
}
