import 'package:letter_boxed_engine/src/letter_boxed_engine_base.dart';

class Game {
  final Box box;
  final GameLanguage language;
  final List<List<String>> solutions;
  Game({required this.box, required this.language, required this.solutions});

  @override
  String toString() {
    return '${language.name} | $box | ${solutions.length} solutions';
  }
}
