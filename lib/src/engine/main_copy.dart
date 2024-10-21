import 'dart:io';

import 'package:encaixado_engine/src/data/load_dictionary.dart';
import 'package:encaixado_engine/src/engine/box.dart';
import 'package:encaixado_engine/src/engine/filters/filters.dart';
import 'package:encaixado_engine/src/engine/finders/finders.dart';
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
  String boxLetters = '';

  do {
    while (boxLetters.isEmpty && keepLoop()) {
      try {
        validateBox(input);
        boxLetters = input!;
        stdout.clear();
      } catch (e) {
        boxLetters = '';
        stdout.clear();
        stdout.writeln(e);
        stdout.writeln(
            " Use the format: 'abc def ghi jkl' (separated by `spaces`)\n\n"
            "Enter 'q' to quit\n\n"
            "\nEnter Letter Box: \n");
        input = stdin.readLineSync();
      }
    }

    stdout.clear();
    final wordList = await loadDictionary();
    final box = Box.fromString(boxLetters);

    stdout.writeln('loaded dictionary containing ${wordList.length} words');

    filterByLength(wordList, 3);
    filterByRepeatedSequentialLetters(wordList);

    filterByAvailableLetters(wordList, box);
    filterByBox(wordList, box);

    stdout.writeln('found ${wordList.length} words that fit "box"');

    final sortedWords = sortByMostUniqueLetters(wordList).toList();

    final possibleSolutions = findSolutions(sortedWords, box);
    stdout.writeln(
      'found ${possibleSolutions?.length} possible solutions:\n\n'
      '$possibleSolutions\n\n',
    );

    stdout.writeln('\n(`enter` to continue | `q` to quit)\n');
    input = stdin.readLineSync();
  } while (keepLoop());
}

List<String> sortByMostUniqueLetters(Set<String> wordList) {
  return wordList.toList()
    ..sort((a, b) {
      int aLen = a.runes.toSet().length;
      int bLen = b.runes.toSet().length;

      return bLen.compareTo(aLen);
    });
}
