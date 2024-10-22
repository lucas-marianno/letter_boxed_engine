import 'package:encaixado_engine/extensions/stdout_extension.dart';
import 'package:encaixado_engine/src/data/load_dictionary.dart';
import 'package:encaixado_engine/src/engine/box.dart';
import 'package:encaixado_engine/src/engine/filters/filters.dart';
import 'package:encaixado_engine/src/engine/finders/solution.dart';
import 'package:encaixado_engine/src/engine/sorter/sorters.dart';

solver(Box box) async {
  stdout.clear();
  final dictionary = await loadDictionary();

  filterByBox(dictionary, box);
  filterByAvailableLetters(dictionary, box);
  final wordlist = sortByMostUniqueLetters(dictionary);

  final queue = <List<String>>[
    ['']
  ];
  final solutions = <Solution>[];

  final sw = Stopwatch();
  sw.start();

  while (queue.isNotEmpty &&
      solutions.length < 100 &&
      sw.elapsedMilliseconds < 10000) {
    final current = queue.removeAt(0);
    final currentSolution = Solution.validate(current, box);

    if (!currentSolution.isValid) {
      for (String word in wordlist) {
        queue.add(current + [word]);
      }
    } else {
      solutions.add(currentSolution);
      stdout.clearLineAndWrite(
          '${solutions.length} solutions (${sw.elapsedMilliseconds}ms)');
    }
  }

  stdout.writeln(
      '\nFound ${solutions.length} solutions in ${sw.elapsedMilliseconds} ms for "$box"');
  for (Solution s in solutions) {
    stdout.writeln(s.words);
  }
}
