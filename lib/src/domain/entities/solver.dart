import 'dart:async';

import 'package:encaixado_engine/src/extensions/stdout_extension.dart';
import 'package:encaixado_engine/src/domain/entities/box.dart';
import 'package:encaixado_engine/src/domain/usecases/filters.dart';
import 'package:encaixado_engine/src/domain/usecases/sorters.dart';
import 'package:encaixado_engine/src/extensions/string_extension.dart';

class LetterBoxSolver {
  final Box box;
  final int maxSolutions;
  final int wordCount;
  final Set<String> dictionary;
  late List<String> _wordlist;

  LetterBoxSolver(
    this.box,
    this.dictionary, {
    this.maxSolutions = 10,
    this.wordCount = 2,
  }) {
    assert(wordCount > 0 && wordCount < 5);
    _init();
  }

  Future<List<List<String>>> findSolutions() async {
    stdout.clear();
    stdout.writeln('looking for solutions...');

    final queue = <List<String>>[];

    _populateWithSingleWords(queue);

    print('found ${queue.length} single word solutions');
    if (wordCount <= 1) return queue;

    _populateWith2words(queue);

    print('found ${queue.length} solutions with 2 words');

    if (wordCount <= 2) return queue;

    _populateWith3words(queue);
    _filterSolutionsAndRemoveFromWordList(queue);

    print('found ${queue.length} solutions with 3 words');

    // highly demanding 4 word sequence
    if (wordCount <= 3) return queue;
    print('looking for solutions with 4 words');

    _populateWith4words(queue);
    _filterSolutionsAndRemoveFromWordList(queue);

    print('found ${queue.length} solutions with 4 words');

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
        for (String w2 in _wordlist.where((w) => w.startsWith(w1.lastChar)))
          [w1, w2]
    ]);
    _filterSolutionsAndRemoveFromWordList(queue);
  }

  void _populateWith3words(List<List<String>> queue) {
    queue.addAll([
      for (String w1 in _wordlist)
        for (String w2 in _wordlist.where((w) => w.startsWith(w1.lastChar)))
          for (String w3 in _wordlist.where((w) => w.startsWith(w2.lastChar)))
            [w1, w2, w3]
    ]);
    _filterSolutionsAndRemoveFromWordList(queue);
  }

  void _populateWith4words(List<List<String>> queue) {
    queue.addAll([
      for (String w1 in _wordlist)
        for (String w2 in _wordlist.where((w) => w.startsWith(w1.lastChar)))
          for (String w3 in _wordlist.where((w) => w.startsWith(w2.lastChar)))
            for (String w4 in _wordlist.where((w) => w.startsWith(w3.lastChar)))
              [w1, w2, w3, w4]
    ]);
    _filterSolutionsAndRemoveFromWordList(queue);
  }

  void _filterSolutionsAndRemoveFromWordList(List<List<String>> queue) {
    print('wordlist size: ${_wordlist.length}');
    queue.retainWhere((s) {
      final strSolution = s.join().split('').toSet();
      if (strSolution.length > 11) {
        for (String word in s) {
          _wordlist.remove(word);
        }
        // strSolution.remove(strSolution.last);
        // for (var char in strSolution) {
        //   _wordlist.removeWhere((w) => w.contains(char));
        // }

        return true;
      }
      return false;
    });
    print('wordlist size: ${_wordlist.length}');
  }

  void _init() {
    print('loaded dictionary with ${dictionary.length} words');
    final filter = Filter(wordlist: dictionary, box: box);
    filter.byBox();
    filter.byAvailableLetters();
    _wordlist = sortByMostUniqueLetters(dictionary);
    print('filtered to ${_wordlist.length} box valid words');
  }
}
