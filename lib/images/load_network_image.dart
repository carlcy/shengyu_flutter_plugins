import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shengyu_flutter_plugins/init.dart';

import 'image_utils.dart';

/// 网络图片加载
class LoadNetWorkImage extends StatelessWidget {
  const LoadNetWorkImage(
    this.image, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.format = ImageFormat.png,
    this.cacheWidth,
    this.cacheHeight,
    this.errorWidget,
    this.progressIndicatorBuilder,
  });

  final LoadingErrorWidgetBuilder? errorWidget;
  final ProgressIndicatorBuilder? progressIndicatorBuilder;
  final String image;
  final double? width;
  final double? height;
  final BoxFit fit;
  final ImageFormat format;
  final int? cacheWidth;
  final int? cacheHeight;

  @override
  Widget build(BuildContext context) {
    if (image.isNotEmpty || image.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: image,
        progressIndicatorBuilder:
            progressIndicatorBuilder ??
            (BuildContext context, String url, progress) {
              return Center(child: CircularProgressIndicator(strokeWidth: 2.0));
            },
        errorWidget: errorWidget ?? (_, __, ___) => _buildDefaultImage(),
        width: width,
        height: height,
        fit: fit,
        memCacheWidth: cacheWidth,
        memCacheHeight: cacheHeight,
      );
    } else {
      return _buildDefaultImage();
    }
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
