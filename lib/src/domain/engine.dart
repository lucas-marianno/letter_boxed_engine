import 'dart:math';

import 'package:letter_boxed_engine/letter_boxed_engine.dart';
import 'package:letter_boxed_engine/src/data/load_dictionary.dart';
import 'package:letter_boxed_engine/src/data/load_games.dart';
import 'package:letter_boxed_engine/src/extensions/string_extension.dart';

const _initErrorMessage =
    '`.init()` must be called before `LetterBoxedEngine` can be used';

/// Provides an easy access to the main package functionalities.
///
/// Don't forget to add `WidgetsFlutterBinding.ensureInitialized();` to main.dart
class LetterBoxedEngine {
  final GameLanguage language;
  List<String>? _dictionary;
  bool _hasInit = false;

  LetterBoxedEngine(this.language);

  Future<void> init() async {
    _dictionary = await loadDictionary(language);
    _hasInit = true;
  }

  Future<Game> generateGame() async {
    assert(_hasInit == true, _initErrorMessage);

    final box = BoxGenerator(dictionary: _dictionary!).generate();
    final solutions = SolveGameBox(box, _dictionary!).solve();

    if (solutions.isEmpty) return generateGame();

    return Game(
      box: box,
      language: language,
      nOfSolutions: solutions.length,
      solutions: solutions,
    );
  }

  Future<Game> loadRandomGame() async {
    final games = await loadGames(language);
    final rnd = Random().nextInt(games.length - 1);

    return games[rnd];
  }

  bool validateWord(String word, Box box) {
    assert(_hasInit == true, _initErrorMessage);

    if (word.contains(box.denied)) return false;
    if (!_dictionary!.contains(word)) return false;
    return true;
  }

  bool validateSolution(List<String> solution, Box box) {
    assert(_hasInit == true, _initErrorMessage);

    for (var i = 0; i < solution.length; i++) {
      // validate each word
      if (!validateWord(solution[i], box)) return false;

      // validate word sequence
      if (i > 0) {
        final previousWord = solution[i - 1];
        final currentWord = solution[i];
        if (!currentWord.startsWith(previousWord.lastChar)) return false;
      }
    }

    // validate letters used
    final usedLetters = (solution.join().split('')..sort()).toSet().join();
    if (usedLetters.length != 12) return false;
    if (usedLetters != box.availableLetters) return false;

    return true;
  }
}
