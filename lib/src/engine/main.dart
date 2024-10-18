import 'dart:io';

import 'package:encaixado_engine/src/engine/validators/validators.dart';

void main() {
  stdout.writeln(
      "Let's find some possible words that might solve today's Letter Boxed.\n\n"
      "First, write down today's letter box according to the example:\n"
      "Example: 'abc def ghi jkl' (where it represents top-left-right-bottom respectively)\n\n"
      " A B C \n"
      "D     G\n"
      "E     H\n"
      "F     I\n"
      " J K L \n"
      "\nEnter Letter Box ('abc def ghi jkl'): \n");

  // Read input from the user
  String? box = stdin.readLineSync();
  bool isValid = false;
  while (!isValid && box != 'q') {
    try {
      validateBox(box);
      isValid = true;
    } catch (e) {
      stdout.write('\x1B[2J\x1B[0;0H');
      stdout.writeln(e);
      stdout.writeln(
          " Use the format: 'abc def ghi jkl' (separated by `spaces`)\n\n"
          "Enter 'q' to quit\n\n"
          "\nEnter Letter Box: \n");
      box = stdin.readLineSync();
    }
  }
}
