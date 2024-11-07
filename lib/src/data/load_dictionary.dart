import 'package:letter_boxed_engine/src/data/load_data_assets.dart';
import 'package:letter_boxed_engine/src/domain/entities/game_language.dart';

/// Loads and returns a dictionary containing only unique unique words sorted
/// in order of most unique characters.
Future<List<String>> loadDictionary(GameLanguage language) async {
  // final path =
  //     'packages/letter_boxed_engine/assets/${language.name}_valid_words_only.json';
  // final s = await rootBundle.loadString(path);

  // final data = jsonDecode(s) as Map<String, dynamic>;

  final data = await loadDataAssets('${language.name}_valid_words_only.json');
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
