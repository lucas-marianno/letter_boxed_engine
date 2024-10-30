import 'dart:math';

import 'package:letter_boxed_engine/encaixado.dart';
import 'package:letter_boxed_engine/src/domain/entities/game_box.dart';

class GameGenerator {
  // generate box | random pick 12 letters
  // solve for box
  // define how many solutions are acceptable
  // store game into json file
  static const _alpha = 'abcdefghijlmnopqrstuvxz';

  Set<String> _genRandomLetters() {
    Set<String> letters = {};
    while (letters.length < 12) {
      final rnd = Random().nextInt(_alpha.length - 1);
      letters.add(_alpha[rnd]);
    }

    return letters;
  }

  Box _genBox() {
    while (true) {
      final box = Box.fromString(_genRandomLetters().join());

      for (String side in box.letterBox) {
        if (!(side.contains('q') && side.contains('u'))) return box;
      }
    }
  }

  /// Returns `null` if no solution is found under 10s
  Future<GameBox?> genGameFromRandom(Set<String> dictionary) async {
    final sw = Stopwatch()..start();

    List<List<String>> solutions = [];
    late Box box;
    int wordCount = 2;

    while (solutions.isEmpty && sw.elapsedMilliseconds < 10000) {
      box = _genBox();

      final solver = LetterBoxSolver(box, dictionary);
      while (solutions.isEmpty && wordCount <= 4) {
        solutions = await solver.findSolutions(withLength: wordCount);
        wordCount++;
      }
      print(
          'found ${solutions.length} solutions for box "$box" with length up to ${wordCount - 1}');
      wordCount = 2;
    }

    if (solutions.isEmpty) return null;

    return GameBox(box, [
      solutions.where((s) => s.length == 1).length,
      solutions.where((s) => s.length == 2).length,
      solutions.where((s) => s.length == 3).length,
      solutions.where((s) => s.length == 4).length,
    ]);
  }
}
