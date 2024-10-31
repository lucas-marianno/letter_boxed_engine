// ignore_for_file: curly_braces_in_flow_control_structures

class Box {
  /// Each element in [letterBox] represents a box side containing `3` letters.
  final List<String> letterBox;

  /// The `12` unique `a-z` letters that are present the box (not in order).
  late final String availableLetters;

  /// The `14` unique `a-z` letters that **are not** present in the box (not in order).
  late final String unavailableLetters;

  Box._(this.letterBox) {
    availableLetters = letterBox.join().split('').toSet().join();
    unavailableLetters = 'abcdefghijklmnopqrstuvwxyz'
        .split('')
        .toSet()
        .where((letter) => !availableLetters.contains(letter))
        .join();
  }

  /// Creates a new [Box] object from a given string. Example: `'abc def ghi jkl'`
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

  /// Returns a String representation of the given [Box]. Example: `'abc def ghi jkl'`
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

  /// Returns a [Pattern] that matches any strings not allowed in [letterBox]. **Not case sensitive**
  ///
  /// It takes the box sides into consideration.
  ///
  /// Example box: `'abc def ghi jkl'`
  /// ```
  ///      A B C
  ///     D     G
  ///     E     H
  ///     F     I
  ///      J K L
  ///
  /// 'BELA' // allowed
  /// 'BELLA' // not allowed - uses repeated sequencial letters
  /// 'BAD' // not allowed - uses adjacent letters
  /// 'ALPHA' // not allowed - uses letters not contained in the box
  /// ```
  Pattern denied() {
    final az = '[^a-z]';
    final repeatedSequencial = r'(\w)\1';
    final unavailable = '[$unavailableLetters]';
    String adjacent = '';

    for (var boxSide in letterBox) {
      final a = boxSide[0];
      final b = boxSide[1];
      final c = boxSide[2];

      adjacent += '$a$b|$b$a|$a$c|$c$a|$b$c|$c$b|';
    }
    final r = '$az|$repeatedSequencial|$unavailable|$adjacent';

    return RegExp(r.substring(0, r.length - 1), caseSensitive: false);
  }
}
