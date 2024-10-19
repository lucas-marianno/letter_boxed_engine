import 'package:encaixado_engine/src/engine/validators/validators.dart';

import '../box.dart';

void filterByLength(Set<String> wordlist, int minLength) {
  wordlist.retainWhere((word) => word.length >= minLength);
}

void filterByAvailableLetters(Set<String> wordlist, Box box) {
  wordlist.retainWhere((word) => isValidWord(word, box));
}

void filterByStartingLetter(Set<String> wordList, String startsWith) {
  assert(startsWith.length == 1);

  wordList.retainWhere((word) => word[0] == startsWith);
}

void filterByEndingLetter(Set<String> wordList, String endsWith) {
  assert(endsWith.length == 1);

  wordList.retainWhere((word) => word[word.length - 1] == endsWith);
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
///
void filterByMustContain(Set<String> wordList, String mustContain) {
  assert(!mustContain.contains(RegExp('[^a-z]')), 'enter only a-z letters');

  mustContain.split('').forEach((l) {
    wordList.retainWhere((word) => word.contains(l));
  });
}

void filterByMustNotContain(Set<String> wordList, String mustNotContain) {
  assert(!mustNotContain.contains(RegExp('[^a-z]')), 'enter only a-z letters');

  mustNotContain.split('').forEach((l) {
    wordList.removeWhere((word) => word.contains(l));
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
void filterByRepeatedSequentialLetters(Set<String> wordList) {
  wordList.removeWhere((word) => word.contains(RegExp(r'(\w)\1')));
}

void filterByBox(Set<String> wordList, Box box) {
  filterAdjacentLetters(wordList, box.top);
  filterAdjacentLetters(wordList, box.left);
  filterAdjacentLetters(wordList, box.right);
  filterAdjacentLetters(wordList, box.bottom);
}

void filterAdjacentLetters(Set<String> wordList, String boxSide) {
  assert(!boxSide.contains(RegExp('[^a-z]')), 'enter only a-z letters');
  assert(boxSide.length == 3);

  String a = boxSide[0];
  String b = boxSide[1];
  String c = boxSide[2];

  final r = '($a$b|$b$a|$a$c|$c$a|$b$c|$c$b)';

  wordList.removeWhere((word) => word.contains(RegExp(r)));
}
