import '../entities/box.dart';

class Filter {
  final Set<String> wordlist;
  final Box? box;

  Filter({required this.wordlist, this.box});

  void byAvailableLetters() {
    wordlist.retainWhere((word) => isValidWord(word));
  }

  void byStartingLetter(String startsWith) {
    if (startsWith.isEmpty) return;
    assert(startsWith.length == 1);

    wordlist.retainWhere((word) => word[0] == startsWith);
  }

  void byEndingLetter(String endsWith) {
    assert(endsWith.length == 1);

    wordlist.retainWhere((word) => word[word.length - 1] == endsWith);
  }

  /// [mustContain] 1 or more letters.
  ///
  /// If more than one letters are inserted, it will filter only words that
  /// contain all the letters.
  ///
  /// Example:
  ///
  /// ```Dart
  /// final wordList = <String>{'abacate', 'berinjela', 'buceta', 'animal'};
  /// final mustContain = 'al';
  ///
  /// filterByContainingLetter(wordList, mustContain);
  ///
  /// print(wordList); // {'berinjela', 'animal'};
  ///
  /// ```
  void byMustContain(String mustContain) {
    assert(!mustContain.contains(RegExp('[^a-z]')), 'enter only a-z letters');

    mustContain.split('').forEach((l) {
      wordlist.retainWhere((word) => word.contains(l));
    });
  }

  void byMustNotContain(String mustNotContain) {
    assert(
        !mustNotContain.contains(RegExp('[^a-z]')), 'enter only a-z letters');

    mustNotContain.split('').forEach((l) {
      wordlist.removeWhere((word) => word.contains(l));
    });
  }

  /// Filters out repeated sequential letters.
  ///
  /// Example:
  ///
  /// ```Dart
  /// final wordList = <String>{'alpha', 'all', 'access', 'animal'};
  ///
  /// filterByRepeatedSequentialLetters(wordList);
  ///
  /// print(wordList); // {'alpha', 'animal'}
  ///
  /// ```
  void byRepeatedSequentialLetters() {
    wordlist.removeWhere((word) => word.contains(RegExp(r'(\w)\1')));
  }

  void byBox() {
    assert(box != null);
    box.toString().split(' ').forEach((side) {
      byAdjacentLetters(side);
    });
  }

  void byAdjacentLetters(String boxSide) {
    assert(!boxSide.contains(RegExp('[^a-z]')), 'enter only a-z letters');
    assert(boxSide.length == 3);

    String a = boxSide[0];
    String b = boxSide[1];
    String c = boxSide[2];

    final r = '($a$b|$b$a|$a$c|$c$a|$b$c|$c$b)';

    wordlist.removeWhere((word) => word.contains(RegExp(r)));
  }

  bool isValidWord(String word) {
    final r = box?.unavailableLetters.split('').join('|');

    return !word.contains(RegExp('[$r]'));
  }
}
