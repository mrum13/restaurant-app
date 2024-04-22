import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

Future<String> downloadAndSaveImage({required String url, required String title, required  String subtitle}) async {
  final response = await http.get(Uri.parse(url));
  final bytes = response.bodyBytes;

  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/$title-$subtitle.png';
  final file = File(filePath);

  await file.writeAsBytes(bytes);

  return filePath;
}

Future<bool> deleteImage({required String title, required String subtitle}) async {
  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/$title-$subtitle.png';
  final file = File(filePath);

  if (await file.exists()) {
    await file.delete();
    debugPrint('Gambar berhasil dihapus.');
    return true;
  } else {
    debugPrint('File tidak ditemukan.');
    return false;
  }
}

Future<String> openImage({required String title, required String subtitle}) async {
  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/$title-$subtitle.png';

  return filePath;
}