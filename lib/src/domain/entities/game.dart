import 'dart:math';

import 'package:letter_boxed_engine/src/letter_boxed_engine_base.dart';

class Game {
  final Box box;
  final GameLanguage language;

  /// the first 10 possible solutions to the given [box]
  late final List<List<String>>? sampleSolutions;
  final int nOfSolutions;
  Game({
    required this.box,
    required this.language,
    required this.nOfSolutions,
    List<List<String>>? solutions,
  }) {
    sampleSolutions = solutions?.sublist(0, min(0, solutions.length));
  }

  @override
  String toString() {
    return '$Game($box | $nOfSolutions solutions in ${language.name})';
  }
}
