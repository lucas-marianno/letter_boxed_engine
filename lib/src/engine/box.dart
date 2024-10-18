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

  String get availableLetters => top + left + right + bottom;

  String get unavailableLetters => _unavailable;
}
