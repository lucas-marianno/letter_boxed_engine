import 'package:encaixado_engine/src/engine/box.dart';

class Solution {
  final bool isValid;
  final Box box;
  final String usedLetters;
  final List<String> words;
  late final String unUsedLetters;

  Solution._({
    required this.words,
    required this.isValid,
    required this.usedLetters,
    required this.box,
  }) {
    unUsedLetters = box.availableLetters
        .split('')
        .where((letter) => !usedLetters.contains(letter))
        .join();
  }

  factory Solution.validate(List<String> wordSequence, Box box) {
    final boxLetters = box.availableLetters.split('');
    final solutionLetters =
        (wordSequence.join().split('').toSet().toList()..sort()).join();

    for (String l in boxLetters) {
      if (!solutionLetters.contains(l)) {
        return Solution._(
          words: wordSequence,
          isValid: false,
          usedLetters: solutionLetters,
          box: box,
        );
      }
    }

    return Solution._(
      words: wordSequence,
      isValid: true,
      usedLetters: solutionLetters,
      box: box,
    );
  }

  int get distance => unUsedLetters.length;

  @override
  String toString() => 'words: $words | '
      'box: $box | '
      'isValid: $isValid | '
      'usedLetters: $usedLetters | '
      'unUsedLetters: $unUsedLetters | '
      'distance: $distance';
}
