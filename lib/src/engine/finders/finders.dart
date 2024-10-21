import 'package:encaixado_engine/src/engine/box.dart';

/// will return as
/// ```Dart
/// List<List<String>> solutions = [
///     ['abc', 'fgdfg'], // solution 1
///     ['sdfd', 'sdgdfg', 'ghi'], // solution 2
///   ];
/// ```
List<List<String>>? findSolutions(
  List<String> wordlist,
  Box box, [
  String previous = '',
]) {
  List<List<String>> solutions = [];

  for (String word in wordlist) {
    final possibleSolution = '$previous|$word';
    if (isSolution(possibleSolution, box)) {
      solutions.add(possibleSolution.split('|'));
    }
  }

  if (solutions.isNotEmpty) return solutions;
  if (previous.split('|').length >= 6) return null;

  for (String word in wordlist) {
    final sublist = wordlist.where((w) => isNext(word, w)).toList();
    sublist.remove(word);
    final possibleSolutions = findSolutions(sublist, box, '$previous|$word');
    if (possibleSolutions != null) solutions.addAll(possibleSolutions);

    if (solutions.length >= 100) return solutions;
  }

  return solutions;
}

bool isNext(String prev, String next) => prev.runes.last == next.runes.first;

List<List<String>> breadthFirstFinder(List<String> wordlist, Box box,
    [String previousWord = '']) {
  // the list must be ordered from longest word with most unique characters to shortest

  // the list must contain only words that can be written with the letter box

  // track used letters

  // go through each word and check if they use all letters

  // if no word use all 12, pick up the word that uses the most, and redo the
  // search with only the words that start with the previous word last letter

  // go through each word and check if the word sequence use all letters

  // if it doesnt, rinse and reapeat until it finds a sequence that uses all 12
  // or the word sequence reaches 6 words total

  final temp = wordlist.where((word) => isSolution('$previousWord|$word', box));

  if (temp.isNotEmpty) {
    print('found some solutions...');
    final result = <List<String>>[];
    final currentSequence = previousWord.split('|');

    for (String word in temp) {
      result.add([...currentSequence, word]);
    }

    return result;
  } else {
    for (String word in wordlist) {
      print('going deeper with "$word"...');
      breadthFirstFinder(
        wordlist.where((w) => w.runes.first == word.runes.last).toList(),
        box,
        word,
      );
    }
  }
  return [];
}

/// returns true if word provided uses all twelve letters in box
bool isSolution(String word, Box box) {
  final letters = box.availableLetters.split('');

  for (var l in letters) {
    if (!word.contains(l)) break;
    if (l == letters.last) return true;
  }

  return false;
}
