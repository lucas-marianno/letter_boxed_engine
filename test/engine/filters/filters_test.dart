import 'package:encaixado_engine/src/data/load_dictionary.dart';
import 'package:encaixado_engine/src/engine/box.dart';
import 'package:encaixado_engine/src/engine/filters/filters.dart';
import 'package:test/test.dart';

void main() {
  test('should remove all words with 3 letters or less', () {
    final wordSet = <String>{'a', 'ab', 'abc', 'abcd'};
    final expected = <String>{'abc', 'abcd'};

    filterByLength(wordSet, 3);

    expect(wordSet, expected);
  });

  test('should remove all words that contain unavailable letters', () {
    final box = Box('abc', 'def', 'ghi', 'jkl');
    final wordlist = <String>{'a', 'd', 'g', 'j', 'm', 'z'};
    final expected = <String>{'a', 'd', 'g', 'j'};

    filterByAvailableLetters(wordlist, box);

    expect(wordlist, expected);
  });

  test(
      'should remove all words that contain unavailable letters'
      ' (large data set)', () async {
    final box = Box('abc', 'def', 'ghi', 'jkl');
    final wordlist = await loadDictionary('assets/en_dictionary.json');

    final initialLength = wordlist.length;

    print('initial length:${wordlist.length}');

    filterByAvailableLetters(wordlist, box);

    print('final length: ${wordlist.length}');

    expect(wordlist.length < initialLength, true);
  });

  group('testing `filterByStartingLetter`', () {
    test('should filter words that starts with "A"', () {
      final wordList = <String>{'abacate', 'berinjela', 'buceta', 'animal'};
      final expectedA = <String>{'abacate', 'animal'};

      filterByStartingLetter(wordList, 'a');

      expect(wordList, expectedA);
    });
    test('should filter words that starts with "B"', () {
      final wordList = <String>{'abacate', 'berinjela', 'buceta', 'animal'};
      final expectedB = <String>{'berinjela', 'buceta'};

      filterByStartingLetter(wordList, 'b');

      expect(wordList, expectedB);
    });

    test('should filter out everything (empty wordlist)', () {
      final wordList = <String>{'abacate', 'berinjela', 'buceta', 'animal'};

      filterByStartingLetter(wordList, 'a');
      filterByStartingLetter(wordList, 'b');

      expect(wordList, isEmpty);
    });
  });

  group('testing `filterByEndingLetter`', () {
    test('should filter words ending with "a"', () {
      final wordList = <String>{'abacate', 'berinjela', 'buceta', 'animal'};
      final expected = <String>{'berinjela', 'buceta'};

      filterByEndingLetter(wordList, 'a');

      expect(wordList, expected);
    });

    test('should filter words ending with "l"', () {
      final wordList = <String>{'abacate', 'berinjela', 'buceta', 'animal'};
      final expected = <String>{'animal'};

      filterByEndingLetter(wordList, 'l');

      expect(wordList, expected);
    });
  });
  group('testing `filterByMustContain`', () {
    test('should filter words that contains "t"', () {
      final wordList = <String>{'abacate', 'berinjela', 'buceta', 'animal'};
      final expected = <String>{'abacate', 'buceta'};

      filterByMustContain(wordList, 't');

      expect(wordList, expected);
    });
    test('should filter words that contains "al"', () {
      final wordList = <String>{'abacate', 'berinjela', 'buceta', 'animal'};
      final expected = <String>{'berinjela', 'animal'};
      final mustContain = 'al';

      filterByMustContain(wordList, mustContain);

      expect(wordList, expected);
    });
  });
  group('testing `filterByMustNotContain`', () {
    test('should filter words that dont contain "t"', () {
      final wordList = <String>{'abacate', 'berinjela', 'buceta', 'animal'};
      final expected = <String>{'berinjela', 'animal'};

      filterByMustNotContain(wordList, 't');

      expect(wordList, expected);
    });
    test('should filter words that dont contain "jl"', () {
      final wordList = <String>{'abacate', 'berinjela', 'buceta', 'animal'};
      final expected = <String>{'abacate', 'buceta'};
      final mustContain = 'jl';

      filterByMustNotContain(wordList, mustContain);

      expect(wordList, expected);
    });
  });

  group('testing `filterByConsecutiveLetters`', () {
    test('should filter out all words containing repeated sequential letters',
        () {
      final wordList = <String>{'alpha', 'all', 'access', 'animal'};
      final expected = <String>{'alpha', 'animal'};

      filterByRepeatedSequentialLetters(wordList);

      expect(wordList, expected);
    });
  });

  test('should filter out adjacent letters', () {
    final wordList = <String>{
      'ab',
      'ba',
      'ac',
      'ca',
      'bc',
      'cb',
      'banana',
      'abacate',
      'ambidec',
    };
    final expected = <String>{'ambidec'};

    filterAdjacentLetters(wordList, 'abc');

    expect(wordList, expected);
  });
}
