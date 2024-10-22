import 'dart:io';

import 'package:encaixado_engine/extensions/string_extension.dart';
import 'package:encaixado_engine/src/data/load_dictionary.dart';
import 'package:encaixado_engine/src/engine/box.dart';
import 'package:encaixado_engine/src/engine/filters/filters.dart';
import 'package:encaixado_engine/src/engine/find_possible_words.dart';
import 'package:encaixado_engine/src/engine/finders/solution.dart';
import 'package:encaixado_engine/src/engine/main.dart';
import 'package:test/test.dart';

void main() {
  test('bfs', () async {
    final dictionary = await loadDictionary();
    final box = Box.fromString('nis umb vea lco');
    filterByBox(dictionary, box);
    filterByAvailableLetters(dictionary, box);
    final wordlist = sortByMostUniqueLetters(dictionary);

    final queue = <List<String>>[
      [''],
      wordlist,
    ];
    final checked = <Solution>[];

    print(queue);

    while (queue.isNotEmpty || checked.length < 10) {
      final current = Solution.validate(queue.removeAt(0), box);
      print(current);

      if (current.isValid) checked.add(current);

      queue.add(wordlist.where((w) {
        if (w.isEmpty || current.words.isEmpty) return false;

        return w[0] == current.words.last.lastChar;
      }).toList());
    }

    print(checked.where((s) => s.isValid));
  });
  test('test name', () async {
    final box = Box.fromString('nis umb vea lco');
    final dictionary = await loadDictionary();

    filterByBox(dictionary, box);
    filterByAvailableLetters(dictionary, box);

    final wordlist = sortByMostUniqueLetters(dictionary);

    List<Solution> topSolutions = [];

    void findSolutions(List<String> wordSequence) {
      final avaliableWords = [...wordlist];
      if (wordSequence.isNotEmpty) {
        avaliableWords
            .retainWhere((word) => word[0] == wordSequence.last.lastChar);
      }

      // print(avaliableWords);

      for (String word in avaliableWords) {
        final solution = Solution.validate([...wordSequence, word], box);

        if (solution.isValid) {
          topSolutions.add(solution);
          topSolutions.sort((a, b) => a.words.length.compareTo(b.words.length));
        }

        if (topSolutions.length > 100) topSolutions.removeLast();
      }
    }

    findSolutions([]);
    if (topSolutions.isEmpty) {
      for (String word in wordlist) {
        findSolutions([word]);
      }
      if (topSolutions.isEmpty) {}
    }

    print('\n${topSolutions.length} solutions found:');
    for (Solution s in topSolutions) {
      print(s);
    }
  });
}
