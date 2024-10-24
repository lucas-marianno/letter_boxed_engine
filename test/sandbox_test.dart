import 'package:encaixado_engine/src/data/load_dictionary.dart';
import 'package:encaixado_engine/src/extensions/string_extension.dart';
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
    final dictionary =
        await loadDictionary('assets/en_dictionary_valid_words_only.json');

    final queue = <List<String>>[];
    queue.addAll([
      for (String w1 in dictionary)
        for (String w2 in dictionary.where((w) => w.startsWith(w1.lastChar)))
          // for (String w3 in dictionary.where((w) => w.startsWith(w2.lastChar)))
          [w1, w2]
    ]);

    print(queue.length);
  });
}
