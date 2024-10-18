// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:encaixado_engine/src/engine/box.dart';

bool isValidWord(String word, Box box) {
  final r = box.unavailableLetters.split('').map((e) => '$e|').join();

  return !word.contains(RegExp('[$r]'));
}

void validateBox(String? box) {
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
  // TODO: add validation for unique letters only
}
