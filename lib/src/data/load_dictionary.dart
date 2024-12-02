import 'package:flutter/foundation.dart';
import 'package:letter_boxed_engine/src/data/load_data_assets.dart';
import 'package:letter_boxed_engine/src/domain/entities/game_language.dart';

/// Loads and returns a dictionary containing only unique unique words sorted
/// in order of most unique characters.
Future<List<String>> loadDictionary(GameLanguage language) async {
  final rawData =
      await loadDataAssets('${language.name}_valid_words_only.json');

  return compute(_processDictionary, rawData);
}

List<String> _processDictionary(Map<String, dynamic> rawData) =>
    rawData.keys.toSet().toList()
      ..sort((a, b) {
        int aLen = a.runes.toSet().length;
        int bLen = b.runes.toSet().length;

        return bLen.compareTo(aLen);
      });
