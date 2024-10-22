import 'package:encaixado_engine/src/domain/entities/box.dart';

class Solution {
  final bool isValid;
  final List<String> words;

  Solution._({required this.words, required this.isValid});

  factory Solution.validate(List<String> wordSequence, Box box) {
    final solutionLetters =
        (wordSequence.join().split('').toSet().toList()..sort()).join();

    bool validity = true;

    for (String l in box.letterBox) {
      if (!solutionLetters.contains(l)) {
        validity = false;
        break;
      }
    }

    return Solution._(words: wordSequence.sublist(1), isValid: validity);
  }
}
