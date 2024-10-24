import 'package:encaixado_engine/src/data/load_dictionary.dart';
import 'package:encaixado_engine/src/domain/entities/box.dart';
import 'package:encaixado_engine/src/domain/usecases/filters.dart';
import 'package:test/test.dart';

void main() {
  test('should remove all words that contain unavailable letters', () {
    final box = Box.fromString('abc def ghi jkl');
    final wordlist = <String>{'a', 'd', 'g', 'j', 'm', 'z'};
    final expected = <String>{'a', 'd', 'g', 'j'};

    Filter(wordlist: wordlist, box: box).byAvailableLetters();

    expect(wordlist, expected);
  });

  test(
      'should remove all words that contain unavailable letters'
      ' (large data set)', () async {
    final box = Box.fromString('abc def ghi jkl');
    final wordlist = await loadDictionary('assets/en_dictionary.json');

    final initialLength = wordlist.length;

    print('initial length:${wordlist.length}');

    Filter(wordlist: wordlist, box: box).byAvailableLetters();

    print('final length: ${wordlist.length}');

    expect(wordlist.length < initialLength, true);
  });

  group('testing `filterByStartingLetter`', () {
    test('should filter words that starts with "A"', () {
      final wordList = <String>{'abacate', 'berinjela', 'buceta', 'animal'};
      final expectedA = <String>{'abacate', 'animal'};

      Filter(wordlist: wordList).byStartingLetter('a');

      expect(wordList, expectedA);
    });
    test('should filter words that starts with "B"', () {
      final wordList = <String>{'abacate', 'berinjela', 'buceta', 'animal'};
      final expectedB = <String>{'berinjela', 'buceta'};

      Filter(wordlist: wordList).byStartingLetter('b');

      expect(wordList, expectedB);
    });

    test('should filter out everything (empty wordlist)', () {
      final wordList = <String>{'abacate', 'berinjela', 'buceta', 'animal'};

      Filter(wordlist: wordList).byStartingLetter('a');
      Filter(wordlist: wordList).byStartingLetter('b');

      expect(wordList, isEmpty);
    });
  });

  group('testing `filterByEndingLetter`', () {
    test('should filter words ending with "a"', () {
      final wordList = <String>{'abacate', 'berinjela', 'buceta', 'animal'};
      final expected = <String>{'berinjela', 'buceta'};

      Filter(wordlist: wordList).byEndingLetter('a');

      expect(wordList, expected);
    });

    test('should filter words ending with "l"', () {
      final wordList = <String>{'abacate', 'berinjela', 'buceta', 'animal'};
      final expected = <String>{'animal'};

      Filter(wordlist: wordList).byEndingLetter('l');

      expect(wordList, expected);
    });
  });
  group('testing `filterByMustContain`', () {
    test('should filter words that contains "t"', () {
      final wordList = <String>{'abacate', 'berinjela', 'buceta', 'animal'};
      final expected = <String>{'abacate', 'buceta'};

      Filter(wordlist: wordList).byMustContain('t');

      expect(wordList, expected);
    });
    test('should filter words that contains "al"', () {
      final wordList = <String>{'abacate', 'berinjela', 'buceta', 'animal'};
      final expected = <String>{'berinjela', 'animal'};
      final mustContain = 'al';

      Filter(wordlist: wordList).byMustContain(mustContain);

      expect(wordList, expected);
    });
  });
  group('testing `filterByMustNotContain`', () {
    test('should filter words that dont contain "t"', () {
      final wordList = <String>{'abacate', 'berinjela', 'buceta', 'animal'};
      final expected = <String>{'berinjela', 'animal'};

      Filter(wordlist: wordList).byMustNotContain('t');

      expect(wordList, expected);
    });
    test('should filter words that dont contain "jl"', () {
      final wordList = <String>{'abacate', 'berinjela', 'buceta', 'animal'};
      final expected = <String>{'abacate', 'buceta'};
      final mustContain = 'jl';

      Filter(wordlist: wordList).byMustNotContain(mustContain);

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

    Filter(wordlist: wordList).byAdjacentLetters('abc');

    expect(wordList, expected);
  });

  test('should filter out words that dont fit box', () {
    final box = Box.fromString('abc def ghi jkl');
    final wordlist = {'abel', 'defi', 'gala', 'lake'};
    final expected = {'gala', 'lake'};

    Filter(wordlist: wordlist, box: box).byBox();

    expect(wordlist, expected);
  });

  group('testing `isValidWord`', () {
    test('should return true for words containing only valid letters', () {
      final box = Box.fromString('abc def ghi jkl');
      final validWord = 'abcdalk';

      final validResult = Filter(wordlist: {}, box: box).isValidWord(validWord);

      expect(validResult, true);
    });

    test('should return false for words containing invalid letters', () {
      final box = Box.fromString('abc def ghi jkl');
      final invalidWord = 'abcz';

      final invalidResult =
          Filter(wordlist: {}, box: box).isValidWord(invalidWord);

      expect(invalidResult, false);
    });
  });
}
