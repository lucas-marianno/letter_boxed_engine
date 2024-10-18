import 'package:encaixado_engine/src/engine/validators/validators.dart';

import '../box.dart';

Set<String> filterLength(Set<String> wordlist, int minLength) {
  return wordlist.where((word) => word.length >= minLength).toSet();
}

Set<String> filterAvailableLetters(Set<String> wordlist, Box box) {
  return wordlist.where((word) => isValidWord(word, box)).toSet();
}
