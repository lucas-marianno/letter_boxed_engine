import 'package:letter_boxed_engine/src/data/load_dictionary.dart';
import 'package:letter_boxed_engine/src/domain/entities/box.dart';
import 'package:letter_boxed_engine/src/domain/usecases/filters.dart';
import 'package:letter_boxed_engine/src/letter_boxed_engine_base.dart';
import 'package:test/test.dart';

void main() {
  test('should remove all words that contain unavailable letters', () {
    final box = Box(fromString: 'abc def ghi jkl');
    final wordlist = <String>['a', 'd', 'g', 'j', 'm', 'z'];
    final expected = <String>['a', 'd', 'g', 'j'];

    Filter(wordlist: wordlist, box: box).byAvailableLetters();

    expect(wordlist, expected);
  });

  test(
      'should remove all words that contain unavailable letters'
      ' (large data set)', () async {
    final box = Box(fromString: 'abc def ghi jkl');
    final wordlist = await loadDictionary(GameLanguage.en);

    final initialLength = wordlist.length;

    print('initial length:${wordlist.length}');

    Filter(wordlist: wordlist, box: box).byAvailableLetters();

    print('final length: ${wordlist.length}');

    expect(wordlist.length < initialLength, true);
  });

  test('should filter out adjacent letters', () {
    final wordList = <String>[
      'ab',
      'ba',
      'ac',
      'ca',
      'bc',
      'cb',
      'banana',
      'abacate',
      'ambidec',
    ];
    final expected = <String>['ambidec'];

    Filter(wordlist: wordList).byAdjacentLetters('abc');

    expect(wordList, expected);
  });

  test('should filter out words that dont fit box', () {
    final box = Box(fromString: 'abc def ghi jkl');
    final wordlist = ['abel', 'defi', 'gala', 'lake'];
    final expected = ['gala', 'lake'];

    Filter(wordlist: wordlist, box: box).byBox();

    expect(wordlist, expected);
  });

  group('testing `isValidWord`', () {
    test('should return true for words containing only valid letters', () {
      final box = Box(fromString: 'abc def ghi jkl');
      final validWord = 'abcdalk';

      final validResult = Filter(wordlist: [], box: box).isValidWord(validWord);

      expect(validResult, true);
    });

    test('should return false for words containing invalid letters', () {
      final box = Box(fromString: 'abc def ghi jkl');
      final invalidWord = 'abcz';

      final invalidResult =
          Filter(wordlist: [], box: box).isValidWord(invalidWord);

      expect(invalidResult, false);
    });
  });
}
