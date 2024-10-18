import 'package:encaixado_engine/src/data/load_dictionary.dart';
import 'package:encaixado_engine/src/engine/box.dart';
import 'package:encaixado_engine/src/engine/filters/filters.dart';
import 'package:test/test.dart';

void main() {
  test('should remove all words with 3 letters or less', () {
    final wordSet = <String>{'a', 'ab', 'abc', 'abcd'};
    final expected = <String>{'abc', 'abcd'};

    final result = filterLength(wordSet, 3);

    expect(result, expected);
  });

  test('should remove all words that contain unavailable letters', () {
    final box = Box('abc', 'def', 'ghi', 'jkl');
    final wordlist = <String>{'a', 'd', 'g', 'j', 'm', 'z'};
    final expected = <String>{'a', 'd', 'g', 'j'};

    final result = filterAvailableLetters(wordlist, box);

    expect(result, expected);
  });

  test(
      'should remove all words that contain unavailable letters'
      ' (large data set)', () async {
    final box = Box('abc', 'def', 'ghi', 'jkl');
    final wordlist = await loadDictionary('assets/en_dictionary.json');
    final initialLength = wordlist.length;

    final result = filterAvailableLetters(wordlist, box);

    print('initial length: $initialLength');
    print('final length: ${result.length}');

    expect(result.length < initialLength, true);
  });
}
