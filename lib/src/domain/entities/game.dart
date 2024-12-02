import 'package:letter_boxed_engine/src/letter_boxed_engine_base.dart';

class Game {
  final Box box;
  final GameLanguage language;
  final List<String> solution;

  Game({
    required this.box,
    required this.language,
    required this.solution,
  });

  @override
  String toString() =>
      '$Game($box | solvable with ${solution.length} words in "${language.name}")';
}
