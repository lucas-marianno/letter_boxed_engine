// ignore_for_file: curly_braces_in_flow_control_structures

class Box {
  /// Each element in [letterBox] represents a box side containing `3` letters.
  final List<String> letterBox;

  /// The `12` unique `a-z` letters that are present the box.
  late final String availableLetters;

  /// The `14` unique `a-z` letters that **are not** present in the box.
  late final String unavailableLetters;

  Box._(this.letterBox) {
    availableLetters = letterBox.join().split('').toSet().join();
    unavailableLetters = 'abcdefghijklmnopqrstuvwxyz'
        .split('')
        .toSet()
        .where((letter) => !availableLetters.contains(letter))
        .join();
  }

  factory Box.fromString(String string) {
    string = string.replaceAll(' ', '');
    _validate(string);

    return Box._([
      string.substring(0, 3),
      string.substring(3, 6),
      string.substring(6, 9),
      string.substring(9, 12),
    ]);
  }

  static void _validate(String box) {
    if (box.isEmpty) throw Exception('"$box" is `empty`');
    if (box.toLowerCase().contains(RegExp(r'[^a-z]')))
      throw Exception('"$box" ([a-z] letters and spaces only)');
    if (box.length != 12)
      throw Exception('"$box" should contain exactly 12 letters');
    if (box.split('').toSet().length != 12)
      throw Exception('"$box" should not contain repeated letters');
  }

  @override
  String toString() => letterBox.join(' ');

  @override
  bool operator ==(Object other) {
    if (other is! Box) return false;
    if (other.toString() != toString()) return false;

    return true;
  }

  @override
  int get hashCode => letterBox.hashCode;
}
