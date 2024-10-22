// ignore_for_file: curly_braces_in_flow_control_structures

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
    validateBox('$top $left $right $bottom');
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

  static void validateBox(String? box) {
    if (box == null) throw Exception('"$box" is `null`');
    if (box.isEmpty) throw Exception('"$box" is `empty`');
    if (box.length != 15)
      throw Exception('"$box" should be exactly 15 characters long.\n');
    if (box.toLowerCase().contains(RegExp(r'[^a-z\s]')))
      throw Exception(
          '"$box" contains characters that are not allowed (letters and spaces only)');
    if (box.split('').where((c) => c == ' ').length != 3)
      throw Exception('"$box" should contain exactly 3 spaces');
    if (box.split('').where((c) => c != ' ').length != 12)
      throw Exception('"$box" should contain exactly 12 letters');
    if (box[3] != ' ')
      throw Exception('\nspacing is incorrect\n$box\n   ^           \n');
    if (box[7] != ' ')
      throw Exception('\nspacing is incorrect\n$box\n       ^       \n');
    if (box[11] != ' ')
      throw Exception('\nspacing is incorrect\n$box\n           ^   \n');
    if (box.split('').toSet().length != 13)
      throw Exception('"$box" should not contain repeated letters');
  }

  @override
  String toString() => '$top $left $right $bottom';
}
