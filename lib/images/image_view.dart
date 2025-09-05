import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shengyu_flutter_plugins/images/image_utils.dart';
import 'package:shengyu_flutter_plugins/init.dart';

class ImageView extends StatelessWidget {
  final String? type;
  final String image;
  final double? width;
  final double? height;
  final BoxFit? fit;

  const ImageView.asset(asset, {super.key, this.width, this.height, this.fit}) : type = 'asset', image = asset ?? '';

  const ImageView.network(url, {super.key, this.width, this.height, this.fit}) : type = 'network', image = url ?? '';

  @override
  Widget build(BuildContext context) {
    Widget imageV;
    if (type == 'network') {
      imageV = CachedNetworkImage(
        imageUrl: image,
        width: width,
        height: height,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: imageProvider, fit: fit),
          ),
        ),
        progressIndicatorBuilder: (BuildContext context, String url, progress) {
          return Center(child: CircularProgressIndicator(strokeWidth: 2.0));
        },
        errorWidget: (context, error, stacktrace) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ImageUtils.getAssetImage(ShengYuGlobalManager().defaultNetWorkImage, packageName: 'shengyu_flutter_plugins'),
              fit: fit,
            ),
          ),
        ),
      );
    } else if (type == 'asset') {
      imageV = Image.asset(
        image,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stacktrace) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: ImageUtils.getAssetImage(ShengYuGlobalManager().defaultNetWorkImage), fit: fit),
          ),
        ),
      );
    } else {
      imageV = Container();
    }

    return imageV;
  }
}
