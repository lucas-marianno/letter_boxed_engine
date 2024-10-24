import 'package:encaixado_engine/src/data/load_dictionary.dart';
import 'package:test/test.dart';

main() {
  test('sandbox', () async {
    //
    final brDict =
        await loadDictionary('assets/pt_dictionary_valid_words_only.json');

    print('loaded ${brDict.length} pt br words');

    filterByLength(brDict, 3);
    filterByRepeatedSequentialLetters(brDict);

    final lowercase = {for (String w in brDict) w.toLowerCase()};

    print('filtered brDict to ${brDict.length} valid words');
    print('lowercase: ${lowercase.length} valid words');

    String longest = '';
    for (String word in brDict) {
      if (word.length > longest.length) {
        longest = word;
      }
    }

    print('longest word is: $longest');
  });

  test('test name', () async {
    final brDict =
        await loadDictionary('assets/pt_dictionary_valid_words_only.json');

    print('loaded ${brDict.length} pt br words');

    final solutions = brDict.where((s) => s.split('').toSet().length > 11);

    print('found ${solutions.length} single word solutions');
    print(solutions.toList());
  });
}
