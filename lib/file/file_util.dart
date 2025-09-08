import 'dart:io';
import 'dart:math';

import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shengyu_flutter_plugins/enum/file_type.dart';

class FileUtil {
  FileUtil._internal();

  static Future<bool> isExitFile(String path) async {
    return await File(path).exists();
  }

  // 创建文件
  static Future<String> createTempFile({required String dir, required String name, bool deleteOld = false}) async {
    return createFile(
      filePath: await getFilePath(dir: dir, name: name),
      deleteOld: deleteOld,
    );
  }

  // 创建文件
  static Future<String> createFile({required String filePath, bool deleteOld = false}) async {
    File file = File(filePath);
    if (!(await file.exists())) {
      file.create();
    } else if (deleteOld) {
      await file.delete();
      await file.create();
    }
    return file.path;
  }

  static Future<String> getFilePath({required String dir, required String name}) async {
    final storage = (Platform.isAndroid ? await getExternalStorageDirectory() : await getTemporaryDirectory());
    var realDir = dir.isEmpty ? storage!.path : '${storage!.path}/$dir';
    Directory directory = Directory(realDir);
    if (!(await directory.exists())) {
      directory.create(recursive: true);
    }
    File file = File('${directory.path}/$name');
    return file.path;
  }

  // 删除文件
  static deleteFile(String filePath) async {
    File file = File(filePath);
    await file.delete();
  }

  // 格式话输出字节大小
  static String formatBytes(bytes, decimals) {
    if (bytes == 0) return '0';
    var k = 1024,
        dm = decimals <= 0 ? 0 : decimals,
        sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'],
        i = (log(bytes) / log(k)).floor();
    return (((bytes / pow(k, i)).toStringAsFixed(dm)) + ' ' + sizes[i]);
  }

  static ResType getResType(String path) {
    final mimeType = lookupMimeType(path) ?? '';
    if (mimeType.contains('image/')) {
      return ResType.image;
    }

    if (mimeType.contains('audio/')) {
      return ResType.audio;
    }

    if (mimeType.contains('video/')) {
      return ResType.video;
    }

    return ResType.file;
  }
}
