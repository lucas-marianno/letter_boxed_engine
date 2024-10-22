import 'package:encaixado_engine/src/data/load_dictionary.dart';
import 'package:encaixado_engine/src/engine/box.dart';
import 'package:encaixado_engine/src/engine/filters/filters.dart';

Future<Set<String>> findPossibleWords(
  Box box, {
  String? startsWith,
  String? endsWith,
  String? mustContain,
  String? mustNotContain,
}) async {
  final wordList = await loadDictionary();

  filterByAvailableLetters(wordList, box);
  filterByBox(wordList, box);

  print('found ${wordList.length} words');

  if (startsWith != null && startsWith.isNotEmpty) {
    filterByStartingLetter(wordList, startsWith);
    print('filtered to ${wordList.length} words starting with "$startsWith"');
  }
  if (endsWith != null && endsWith.isNotEmpty) {
    filterByEndingLetter(wordList, endsWith);
    print('filtered to ${wordList.length} words ending with "$endsWith"');
  }
  if (mustContain != null && mustContain.isNotEmpty) {
    filterByMustContain(wordList, mustContain);
    print('filtered to ${wordList.length} words containing "$mustContain"');
  }
  if (mustNotContain != null && mustNotContain.isNotEmpty) {
    filterByMustContain(wordList, mustNotContain);
    print(
        'filtered to ${wordList.length} words that don\'t contain "$mustNotContain"');
  }

  return wordList;
}
