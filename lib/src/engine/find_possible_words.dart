import 'package:encaixado_engine/src/data/load_dictionary.dart';
import 'package:encaixado_engine/src/engine/box.dart';
import 'package:encaixado_engine/src/engine/filters/filters.dart';

Future<Set<String>> findPossibleWords(
  Box box, {
  String? startsWith,
  String? endsWith,
  String? contains,
}) async {
  final wordList = await loadDictionary(
      r'C:\Users\42670\Desktop\Git Clones\Meus\Encaixado\assets\en_dictionary.json');

  filterByLength(wordList, 3);

  filterByAvailableLetters(wordList, box);

  print('found ${wordList.length} words');

  if (startsWith != null && startsWith.isNotEmpty) {
    filterByStartingLetter(wordList, startsWith);
    print('filtered to ${wordList.length} words starting with "$startsWith"');
  }
  if (endsWith != null && endsWith.isNotEmpty) {
    filterByEndingLetter(wordList, endsWith);
    print('filtered to ${wordList.length} words ending with "$endsWith"');
    print('\n$wordList');
  }
  if (contains != null && contains.isNotEmpty) {
    filterByContainingLetter(wordList, contains);
    print('filtered to ${wordList.length} containing "$contains"');
  }

  return wordList;
}
