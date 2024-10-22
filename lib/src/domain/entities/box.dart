// ignore_for_file: curly_braces_in_flow_control_structures

class Box {
  final List<String> letterBox;
  late final String availableLetters;
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
    _validate(string);
    return Box._(string.split(' '));
  }

  @override
  String toString() => letterBox.join(' ');

  static void _validate(String box) {
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
}
