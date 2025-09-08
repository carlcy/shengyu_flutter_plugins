import 'package:flutter/material.dart';
import 'package:shengyu_flutter_plugins/enum/image_type.dart';
import 'package:shengyu_flutter_plugins/init.dart';

import 'image_utils.dart';

/// 本地资源图片加载
class LoadAssetImage extends StatelessWidget {
  const LoadAssetImage(
      this.image, {
        super.key,
        this.width,
        this.height,
        this.cacheWidth,
        this.cacheHeight,
        this.fit,
        this.format = ImageFormat.png,
        this.color,
      });

  final String image;
  final double? width;
  final double? height;
  final int? cacheWidth;
  final int? cacheHeight;
  final BoxFit? fit;
  final ImageFormat format;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      ImageUtils.getImgPath(image, format: format),
      height: height,
      width: width,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
      fit: fit,
      color: color,
      excludeFromSemantics: true,
      errorBuilder: (_, __, ___) {
        return _buildDefaultImage();
      },
    );
  }
}

Widget _buildDefaultImage() {
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: ImageUtils.getAssetImage(ShengYuGlobalManager().defaultNetWorkImage, packageName: 'shengyu_flutter_plugins'),
        fit: BoxFit.fill,
      ),
    ),
  );
}