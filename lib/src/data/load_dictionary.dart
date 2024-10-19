import 'dart:convert';
import 'dart:io';

Future<Set<String>> loadDictionary([String? path]) async {
  path ??= '../../../assets/en_dictionary.json';

  final file = File(path);

  final data = jsonDecode(await file.readAsString()) as Map<String, dynamic>;

  final wordlist = data.keys.toSet();
  return wordlist;
}
