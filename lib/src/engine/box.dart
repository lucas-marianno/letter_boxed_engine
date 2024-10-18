import 'package:encaixado_engine/src/engine/validators/validators.dart';

class Box {
  final String top;
  final String left;
  final String right;
  final String bottom;

  static const _alpha = 'abcdefghijklmnopqrstuvwxyz';
  late final String _unavailable;

  Box(this.top, this.left, this.right, this.bottom)
      : assert(top.length == 3),
        assert(left.length == 3),
        assert(right.length == 3),
        assert(bottom.length == 3) {
    _unavailable = _alpha
        .split('')
        .where((letter) => !availableLetters.contains(letter))
        .join();
  }

  factory Box.fromString(String string) {
    validateBox(string);
    final b = string.split(' ');
    return Box(b[0], b[1], b[2], b[3]);
  }

  String get availableLetters => top + left + right + bottom;

  String get unavailableLetters => _unavailable;
}
