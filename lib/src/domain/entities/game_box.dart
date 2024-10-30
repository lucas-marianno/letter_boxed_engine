import 'package:letter_boxed_engine/encaixado.dart';

class GameBox {
  final Box box;

  /// [solutionCount] is the number of possible solutions for [box], where
  /// the `index` is the wordcount of the solution.
  ///
  /// Example:
  /// [solutionCount] = `[0,27,359]`
  ///
  /// it means that there are `0` 1 word solutions, `27` 2 word solutions, and
  /// `359` 3 word solutions and so on.
  final List<int> solutionCount;

  GameBox(this.box, this.solutionCount);

  @override
  String toString() => '$box | $solutionCount';

  @override
  bool operator ==(Object other) {
    if (other is! GameBox) return false;
    return other.box == box;
  }

  @override
  int get hashCode => Object.hash(box, solutionCount);
}
