import 'dart:async';

import 'package:letter_boxed_engine/src/domain/entities/box.dart';
import 'package:letter_boxed_engine/src/domain/usecases/filters.dart';
import 'package:letter_boxed_engine/src/domain/usecases/sorters.dart';
import 'package:letter_boxed_engine/src/extensions/string_extension.dart';

class LetterBoxSolver {
  final Box box;
  final int maxSolutions;
  final Set<String> dictionary;
  late List<String> _wordlist;

  LetterBoxSolver(
    this.box,
    this.dictionary, {
    this.maxSolutions = 10,
  }) {
    _init();
  }

  Future<List<List<String>>> findSolutions({int withLength = 2}) async {
    assert(withLength > 0 && withLength < 5);
    print('looking for solutions...');

    final queue = <List<String>>[];

    _populateWithSingleWords(queue);

    if (withLength <= 1 || _wordlist.isEmpty) return queue;

    _populateWith2words(queue);

    if (withLength <= 2 || _wordlist.isEmpty) return queue;

    _populateWith3words(queue);

    // highly demanding 4 word sequence
    if (withLength <= 3 || _wordlist.isEmpty) return queue;

    _populateWith4words(queue);

    return queue;
  }

  void _populateWithSingleWords(List<List<String>> queue) {
    queue.addAll([
      for (var s in _wordlist) [s]
    ]);
    _filterSolutionsAndRemoveFromWordList(queue);
  }

  void _populateWith2words(List<List<String>> queue) {
    queue.addAll([
      for (String w1 in _wordlist)
        for (String w2 in _wordlist
            .where((w) => w.startsWith(w1.lastChar) && _isSolution([w1, w])))
          [w1, w2]
    ]);
    _filterSolutionsAndRemoveFromWordList(queue);
  }

  void _populateWith3words(List<List<String>> queue) {
    queue.addAll([
      for (String w1 in _wordlist)
        for (String w2 in _wordlist.where((w) => w.startsWith(w1.lastChar)))
          for (String w3 in _wordlist.where(
              (w) => w.startsWith(w2.lastChar) && _isSolution([w1, w2, w])))
            [w1, w2, w3]
    ]);
    _filterSolutionsAndRemoveFromWordList(queue);
  }

  void _populateWith4words(List<List<String>> queue) {
    queue.addAll([
      for (String w1 in _wordlist)
        for (String w2 in _wordlist.where((w) => w.startsWith(w1.lastChar)))
          for (String w3 in _wordlist.where((w) => w.startsWith(w2.lastChar)))
            for (String w4 in _wordlist.where((w) =>
                w.startsWith(w3.lastChar) && _isSolution([w1, w2, w3, w])))
              [w1, w2, w3, w4]
    ]);
    _filterSolutionsAndRemoveFromWordList(queue);
  }

  bool _isSolution(List<String> w) => w.join().split('').toSet().length > 11;

  void _filterSolutionsAndRemoveFromWordList(List<List<String>> queue) {
    queue.retainWhere((s) {
      final strSolution = s.join().split('').toSet();
      if (strSolution.length > 11) {
        for (String word in s) {
          _wordlist.remove(word);
        }

        return true;
      }
      return false;
    });
  }

  void _init() {
    final filter = Filter(wordlist: dictionary, box: box);
    filter.byBox();
    filter.byAvailableLetters();
    _wordlist = sortByMostUniqueLetters(dictionary);
  }
}
