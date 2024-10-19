import 'dart:io';

import 'package:encaixado_engine/src/engine/box.dart';
import 'package:encaixado_engine/src/engine/find_possible_words.dart';
import 'package:encaixado_engine/src/engine/validators/validators.dart';

import 'package:encaixado_engine/src/extensions.dart';

void main() async {
  stdout.clear();
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

  String? input = stdin.readLineSync();
  bool keepLoop() =>
      input?.toLowerCase() != 'q' && input?.toLowerCase() != 'quit';
  String box = '';

  do {
    while (box.isEmpty && keepLoop()) {
      try {
        validateBox(input);
        box = input!;
        stdout.clear();
      } catch (e) {
        box = '';
        stdout.clear();
        stdout.writeln(e);
        stdout.writeln(
            " Use the format: 'abc def ghi jkl' (separated by `spaces`)\n\n"
            "Enter 'q' to quit\n\n"
            "\nEnter Letter Box: \n");
        input = stdin.readLineSync();
      }
    }

    stdout.writeln('\nFiltering...\n(`enter` to skip | `q` to quit)\n\n');
    stdout.writeln('Starts with (`enter` to skip)');
    final startsWith = stdin.readLineSync();
    stdout.writeln('Ends with (`enter` to skip)');
    final endsWith = stdin.readLineSync();
    stdout.writeln('Must contain (one or more letters) (`enter` to skip)');
    final mustContain = stdin.readLineSync();
    stdout.writeln('Must NOT contain (one or more letters) (`enter` to skip)');
    final mustNotContain = stdin.readLineSync();

    final wordList = await findPossibleWords(
      Box.fromString(box),
      startsWith: startsWith,
      endsWith: endsWith,
      mustContain: mustContain,
      mustNotContain: mustNotContain,
    );

    stdout.writeln(sortByMostUniqueLetters(wordList));
    stdout.writeln('\n(`enter` to continue | `q` to quit)\n');
    input = stdin.readLineSync();
  } while (keepLoop());
}

Iterable<String> sortByMostUniqueLetters(Set<String> wordList) {
  return wordList.toList()
    ..sort((a, b) {
      int aLen = a.runes.toSet().length;
      int bLen = b.runes.toSet().length;

      return bLen.compareTo(aLen);
    });
}
