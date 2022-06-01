import 'dart:io';
import 'dart:typed_data';

import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ImageShare {
  static Future<String> saveImage(Uint8List image) async {
    final result = await ImageGallerySaver.saveImage(
      image,
      name: DateTime.now().toString(),
      isReturnImagePathOfIOS: true
    );
    return result['filePath'] ?? '';
  }

  static Future<bool> shareImage(Uint8List image) async {
    Directory tempDir = await getTemporaryDirectory();
    String filePath = tempDir.path + '/${DateTime.now().toString()}.jpeg';
    File file = File(filePath);
    await file.writeAsBytes(image.toList());
    final result = await Share.shareFilesWithResult([filePath]);
    await file.delete();
    return result.status == ShareResultStatus.success;
  }
}