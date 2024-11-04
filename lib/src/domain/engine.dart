import 'package:letter_boxed_engine/letter_boxed_engine.dart';
import 'package:letter_boxed_engine/src/data/load_dictionary.dart';
import 'package:letter_boxed_engine/src/extensions/string_extension.dart';

class Engine {
  final GameLanguage language;
  List<String>? _dictionary;
  late BoxGenerator _generateBox;

  Engine(this.language) {
    init();
  }

  Future<void> init() async {
    _dictionary = await loadDictionary(language);
    _generateBox = BoxGenerator(dictionary: _dictionary!);
  }

  Future<Game> generateGame() async {
    if (_dictionary == null || _dictionary!.isEmpty) await init();

    final box = _generateBox.generate();
    final solutions = SolveGameBox(box, _dictionary!).solve();

    if (solutions.isEmpty) return generateGame();

    return Game(box: box, language: language, solutions: solutions);
  }

  bool validateWord(String word, Box box) {
    if (word.contains(box.denied)) return false;
    if (!_dictionary!.contains(word)) return false;
    return true;
  }

  bool validateSolution(List<String> solution, Box box) {
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
