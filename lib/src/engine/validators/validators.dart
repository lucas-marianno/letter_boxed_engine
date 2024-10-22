import 'package:encaixado_engine/src/engine/box.dart';

bool isValidWord(String word, Box box) {
  final r = box.unavailableLetters.split('').map((e) => '$e|').join();

  return !word.contains(RegExp('[$r]'));
}
