import 'package:encaixado_engine/src/data/load_dictionary.dart';
import 'package:encaixado_engine/src/engine/box.dart';
import 'package:encaixado_engine/src/engine/filters/filters.dart';

Future<Set<String>> findPossibleWords(Box box) async {
  final wordlist = await loadDictionary('assets/en_dictionary.json');
  return filterAvailableLetters(filterLength(wordlist, 3), box);
}
