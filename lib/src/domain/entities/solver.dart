import 'package:encaixado_engine/src/extensions/stdout_extension.dart';
import 'package:encaixado_engine/src/data/load_dictionary.dart';
import 'package:encaixado_engine/src/domain/entities/box.dart';
import 'package:encaixado_engine/src/domain/usecases/filters.dart';
import 'package:encaixado_engine/src/domain/entities/solution.dart';
import 'package:encaixado_engine/src/domain/usecases/sorters.dart';
import 'package:encaixado_engine/src/extensions/string_extension.dart';

class LetterBoxSolver {
  final Box box;
  late final int maxSolutions;
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

  Future<List<Solution>> findSolutions() async {
    if (!hasInitialized) await _init();

    stdout.clear();
    stdout.writeln('looking for solutions...');

    final sw = Stopwatch()..start();
    final solutions = <Solution>[];
    final queue = <List<String>>[
      ['']
    ];

    while (queue.isNotEmpty &&
        solutions.length < maxSolutions &&
        sw.elapsedMilliseconds < _timeout.inMilliseconds) {
      final current = queue.removeAt(0);

      final currentSolution = Solution.validate(current, box);

      if (!currentSolution.isValid) {
        for (String word in _wordlist.where((w) {
          final lastChar = current.last.lastChar;
          if (lastChar == '') return true;
          return w[0] == lastChar;
        })) {
          queue.add(current + [word]);
        }
      } else {
        solutions.add(currentSolution);

        stdout.clear();
        stdout.writeln('found ${solutions.length} solutions');
      }
    }
    sw.stop();

    return solutions;
  }
}
