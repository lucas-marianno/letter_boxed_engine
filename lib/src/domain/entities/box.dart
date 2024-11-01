// ignore_for_file: curly_braces_in_flow_control_structures

class Box {
  Box({required String fromString}) {
    final s = fromString.replaceAll(' ', '');
    _validate(s);

    letterBox = [
      s.substring(0, 3),
      s.substring(3, 6),
      s.substring(6, 9),
      s.substring(9, 12),
    ];

    availableLetters = letterBox.join().split('').toSet().join();
    unavailableLetters = 'abcdefghijklmnopqrstuvwxyz'
        .split('')
        .toSet()
        .where((letter) => !availableLetters.contains(letter))
        .join();

    _setDeniedPattern();
  }

  /// Each element in [letterBox] represents a box side containing `3` letters.
  ///
  /// `['abc','def','ghi','jkl']`
  late final List<String> letterBox;

  /// The `12` unique `a-z` letters that are present the box (not in order).
  late final String availableLetters;

  /// The `14` unique `a-z` letters that **are not** present in the box (not in order).
  late final String unavailableLetters;

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
  /// 'ALFA' // allowed
  /// 'ALFA 1' // not allowed - uses characters that are not `a-z`
  /// 'BELA' // allowed
  /// 'BELLA' // not allowed - uses repeated sequencial letters
  /// 'BAD' // not allowed - uses adjacent letters
  /// 'ALPHA' // not allowed - uses letters not contained in the box
  /// ```
  late final Pattern denied;

  static void _validate(String box) {
    if (box.isEmpty) throw Exception('"$box" is `empty`');
    if (box.toLowerCase().contains(RegExp(r'[^a-z]')))
      throw Exception('"$box" ([a-z] letters and spaces only)');
    if (box.length != 12)
      throw Exception('"$box" should contain exactly 12 letters');
    if (box.split('').toSet().length != 12)
      throw Exception('"$box" should not contain repeated letters');
  }

  void _setDeniedPattern() {
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

    denied = RegExp(r.substring(0, r.length - 1), caseSensitive: false);
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
}
