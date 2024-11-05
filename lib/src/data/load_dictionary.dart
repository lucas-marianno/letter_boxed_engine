import 'dart:convert';
import 'dart:io';

import 'package:letter_boxed_engine/src/domain/entities/game_language.dart';

/// Loads and returns a dictionary containing only unique unique words sorted
/// in order of most unique characters.
Future<List<String>> loadDictionary(GameLanguage language) async {
  final uri = 'lib/assets/${language.name}_valid_words_only.json';

  final file = File(uri);
  final data = jsonDecode(await file.readAsString()) as Map<String, dynamic>;
  final dictionary = data.keys.toSet();

  return dictionary.toList()
    ..sort((a, b) {
      int aLen = a.runes.toSet().length;
      int bLen = b.runes.toSet().length;

      return bLen.compareTo(aLen);
    });
}


// void filterByLength(Set<String> wordlist, int minLength) {
//   wordlist.retainWhere((word) => word.length >= minLength);
// }

// void filterByRepeatedSequentialLetters(Set<String> wordList) {
//   wordList.removeWhere((word) => word.contains(RegExp(r'(\w)\1')));
// }
