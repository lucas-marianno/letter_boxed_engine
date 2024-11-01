import 'package:letter_boxed_engine/src/domain/entities/game_language.dart';
import 'package:letter_boxed_engine/src/letter_boxed_engine_base.dart';

class Game {
  Game(
      {required this.box, required this.language, required this.solutionCount});

  final Box box;
  final GameLanguage language;

  /// [solutionCount] is the number of possible solutions for [Box], where
  /// the `index` is the wordcount of the solution.
  ///
  /// Example:
  /// [solutionCount] = `[0,27,359]`
  ///
  /// it means that there are `0` 1 word solutions, `27` 2 word solutions, and
  /// `359` 3 word solutions and so on.
  final List<int>? solutionCount;
}
