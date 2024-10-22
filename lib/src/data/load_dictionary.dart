import 'dart:convert';
import 'dart:io';

import 'package:encaixado_engine/src/engine/filters/filters.dart';

Future<Set<String>> loadDictionary([String? path]) async {
  path ??= '../../../assets/popular.json';

  late Map<String, dynamic> data;
  try {
    final file = File(path);
    data = jsonDecode(await file.readAsString()) as Map<String, dynamic>;
  } catch (e) {
    final file = File('assets/popular.json');
    data = jsonDecode(await file.readAsString()) as Map<String, dynamic>;
  }

  final dictionary = data.keys.toSet();

  // TODO: The following filters can be hardcoded in the release version to provide better optimization
  filterByLength(dictionary, 3);
  filterByRepeatedSequentialLetters(dictionary);

  return dictionary;
}
