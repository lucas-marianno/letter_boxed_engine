import 'dart:convert';
import 'dart:io';

Future<Set<String>> loadDictionary([String? path]) async {
  path ??= '../../../assets/en_popular_valid_words_only.json';

  late Map<String, dynamic> data;
  try {
    final file = File(path);
    data = jsonDecode(await file.readAsString()) as Map<String, dynamic>;
  } catch (e) {
    final file = File('assets/en_popular_valid_words_only.json');
    data = jsonDecode(await file.readAsString()) as Map<String, dynamic>;
  }
  final dictionary = data.keys.toSet();

  print('loaded dictionary with ${dictionary.length} valid words');
  return dictionary;
}

void filterByLength(Set<String> wordlist, int minLength) {
  wordlist.retainWhere((word) => word.length >= minLength);
}

void filterByRepeatedSequentialLetters(Set<String> wordList) {
  wordList.removeWhere((word) => word.contains(RegExp(r'(\w)\1')));
}
