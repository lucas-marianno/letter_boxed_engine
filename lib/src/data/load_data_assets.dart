import 'dart:convert';
import 'package:flutter/services.dart';

/// Loads an `.json` file from the assets folder
///
/// example: [fileName] = `pt_valid_words_only.json`
Future<Map<String, dynamic>> loadDataAssets(String fileName) async {
  final path = 'packages/letter_boxed_engine/assets/$fileName';
  final byteData = await rootBundle.load(path);

  final buffer = byteData.buffer.asUint8List();

  final decoder = JsonDecoder();

  return decoder.convert(utf8.decode(buffer));
}
