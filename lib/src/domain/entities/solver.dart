import 'dart:async';

import 'package:encaixado_engine/src/extensions/stdout_extension.dart';
import 'package:encaixado_engine/src/data/load_dictionary.dart';
import 'package:encaixado_engine/src/domain/entities/box.dart';
import 'package:encaixado_engine/src/domain/usecases/filters.dart';
import 'package:encaixado_engine/src/domain/usecases/sorters.dart';
import 'package:encaixado_engine/src/extensions/string_extension.dart';

class LetterBoxSolver {
  final Box box;
  final int maxSolutions;
  final bool enable4Words;
  late List<String> _wordlist;

  LetterBoxSolver(
    this.box, {
    this.maxSolutions = 10,
    this.enable4Words = false,
  });

  Future<List<List<String>>> findSolutions() async {
    await _init();

    stdout.clear();
    stdout.writeln('looking for solutions...');

    final queue = <List<String>>[
      for (String w1 in _wordlist)
        for (String w2 in _wordlist.where((w) => w.startsWith(w1.lastChar)))
          for (String w3 in _wordlist.where((w) => w.startsWith(w2.lastChar)))
            [w1, w2, w3]
    ];

    print('wordlist length: ${_wordlist.length}');
    queue.retainWhere((s) {
      if (s.join().split('').toSet().length > 11) {
        for (String word in s) {
          _wordlist.remove(word);
        }
        return true;
      }
      return false;
    });
    print('found ${queue.length} solutions with 3 words');

    if (!enable4Words) return queue;
    print('looking for solutions with 4 words');

    queue.addAll([
      for (String w1 in _wordlist)
        for (String w2 in _wordlist.where((w) => w.startsWith(w1.lastChar)))
          for (String w3 in _wordlist.where((w) => w.startsWith(w2.lastChar)))
            for (String w4 in _wordlist.where((w) => w.startsWith(w3.lastChar)))
              [w1, w2, w3, w4]
    ]);

    queue.retainWhere((s) {
      if (s.join().split('').toSet().length > 11) {
        for (String word in s) {
          _wordlist.remove(word);
        }
        return true;
      }
      return false;
    });

    print('found ${queue.length} solutions with 4 words');

    return queue;
  }

  Future<void> _init() async {
    final dictionary = await loadDictionary();
    final filter = Filter(wordlist: dictionary, box: box);
    filter.byBox();
    filter.byAvailableLetters();
    _wordlist = sortByMostUniqueLetters(dictionary);
  }
}
