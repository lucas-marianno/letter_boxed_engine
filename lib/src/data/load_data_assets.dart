import 'dart:convert';
import 'package:flutter/services.dart';

/// Loads an `.json` file from the assets folder
///
/// sample [fileName] = `pt_valid_words_only.json`
Future<Map<String, dynamic>> loadDataAssets(String fileName) async {
  final path = 'packages/letter_boxed_engine/assets/$fileName';
  final data = await rootBundle.loadString(path);

  return jsonDecode(data) as Map<String, dynamic>;
}
