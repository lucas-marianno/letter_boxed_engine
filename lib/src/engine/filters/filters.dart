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

void filterByContainingLetter(Set<String> wordList, String contains) {
  assert(contains.isNotEmpty);
  assert(!contains.contains(RegExp('[^a-z]')), 'enter only a-z letters');

  contains.split('').map((l) => '$l|');
  wordList.retainWhere((word) => word.contains(contains));

  wordList.retainWhere((word) => word[word.length - 1] == contains);
}
