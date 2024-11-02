import 'package:letter_boxed_engine/letter_boxed_engine.dart';
import 'package:letter_boxed_engine/src/data/load_dictionary.dart';

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
    if (_dictionary == null) await init();

    final box = _generateBox.generate();
    final solutions = SolveGameBox(box, _dictionary!).solve();

    if (solutions.isEmpty) return generateGame();

    return Game(box: box, language: language, solutions: solutions);
  }
}
