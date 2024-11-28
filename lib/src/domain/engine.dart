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

  /// If [ensureSolvable] is `true`,
  /// [SolveGameBox] will solve the generated [Box].
  ///
  /// The solving process might be computationally expensive, but will guarantee
  /// that each generated [Box] has at least `1` possible solution.
  ///
  /// The generator algorithm is reliable enough that it doesnt acctually need
  /// to be double checked, consider setting [ensureSolvable] to `false` to
  /// optimize generation delta time.
  Future<Game> generateGame({bool ensureSolvable = false}) async {
    assert(_hasInit == true, _initErrorMessage);

    final box = BoxGenerator(dictionary: _dictionary!).generate();

    final solutions = <List<String>>[];

    if (ensureSolvable) {
      solutions.addAll(SolveGameBox(box, _dictionary!).solve());

      if (solutions.isEmpty) {
        return generateGame(ensureSolvable: ensureSolvable);
      }
    }

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
