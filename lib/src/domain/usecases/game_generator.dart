import 'dart:math';

import 'package:letter_boxed_engine/src/data/load_dictionary.dart';
import 'package:letter_boxed_engine/src/domain/entities/box.dart';
import 'package:letter_boxed_engine/src/domain/entities/game.dart';
import 'package:letter_boxed_engine/src/domain/entities/game_language.dart';
import 'package:letter_boxed_engine/src/domain/usecases/solve_game.dart';

class GenerateGame {
  Future<Game?> call(GameLanguage language) async {
    final dictionary = await loadDictionary(language);
    final sw = Stopwatch()..start();

    List<List<String>> solutions = [];
    late Box box;
    int wordCount = 2;

    while (solutions.isEmpty && sw.elapsedMilliseconds < 10000) {
      box = _genBox();

      final solver = SolveGameBox(box, dictionary);
      while (solutions.isEmpty && wordCount <= 4) {
        solutions = await solver.call(withLength: wordCount);
        wordCount++;
      }
      print(
          'found ${solutions.length} solutions for box "$box" with length up to ${wordCount - 1}');
      wordCount = 2;
    }

    if (solutions.isEmpty) return null;

    return Game(box: box, language: language, solutionCount: [
      solutions.where((s) => s.length == 1).length,
      solutions.where((s) => s.length == 2).length,
      solutions.where((s) => s.length == 3).length,
      solutions.where((s) => s.length == 4).length,
    ]);
  }

  Set<String> _genRandomLetters() {
    final a = 'abcdefghijlmnopqrstuvxz';

    Set<String> letters = {};

    while (letters.length < 12) {
      final rnd = Random().nextInt(a.length - 1);
      letters.add(a[rnd]);
    }

    return letters;
  }

  Box _genBox() {
    while (true) {
      final box = Box(fromString: _genRandomLetters().join());

      for (String side in box.letterBox) {
        if (!(side.contains('q') && side.contains('u'))) return box;
      }
    }
  }
}
