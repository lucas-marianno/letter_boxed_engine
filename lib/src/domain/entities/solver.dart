import 'dart:async';

import 'package:encaixado_engine/src/extensions/stdout_extension.dart';
import 'package:encaixado_engine/src/data/load_dictionary.dart';
import 'package:encaixado_engine/src/domain/entities/box.dart';
import 'package:encaixado_engine/src/domain/usecases/filters.dart';
// import 'package:encaixado_engine/src/domain/entities/solution.dart';
import 'package:encaixado_engine/src/domain/usecases/sorters.dart';
import 'package:encaixado_engine/src/extensions/string_extension.dart';

class LetterBoxSolver {
  final Box box;
  late final int maxSolutions;
  final _solutions = <List<String>>[];
  final _sw = Stopwatch();
  late final Duration _timeout;
  late List<String> _wordlist;

  bool hasInitialized = false;

  LetterBoxSolver(this.box, {Duration? timeout, this.maxSolutions = 10}) {
    _timeout = timeout ?? Duration(seconds: 10);
    _init();
  }

  Future<void> _init() async {
    final dictionary = await loadDictionary();
    final filter = Filter(wordlist: dictionary, box: box);
    filter.byBox();
    filter.byAvailableLetters();
    _wordlist = sortByMostUniqueLetters(dictionary);
    hasInitialized = true;
  }

  Future<List<List<String>>> findSolutions() async {
    if (!hasInitialized) await _init();

    _sw.start();
    stdout.clear();
    stdout.writeln('looking for solutions...');

    final queue = <List<String>>[
      ['']
    ];

    while (queue.isNotEmpty && !_reachedMaxSolutions() && !_hasTimedOut()) {
      final current = queue.removeAt(0);

      if (!_isSolution(current)) {
        final startLetter = current.last.lastChar;

        if (startLetter.isEmpty) {
          for (String word in _wordlist) {
            queue.add([word]);
          }
        } else {
          final nextList = _wordlist.where((w) => w.startsWith(startLetter));

          for (String word in nextList) {
            queue.add(current + [word]);
          }
        }
      } else {
        _solutions.add(current);

        stdout.clear();
        stdout.writeln('found ${_solutions.length} solutions');
      }
    }

    return _solutions;
  }

  bool _reachedMaxSolutions() => _solutions.length > maxSolutions;

  bool _hasTimedOut() => _sw.elapsedMilliseconds > _timeout.inMilliseconds;

  bool _isSolution(List<String> wordSequence) {
    final solutionLetters = wordSequence.join().split('').toSet();

    for (String l in box.availableLetters.split('')) {
      if (!solutionLetters.contains(l)) return false;
    }

    return true;
  }
}
