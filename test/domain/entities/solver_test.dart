import 'package:letter_boxed_engine/src/data/load_dictionary.dart';
import 'package:letter_boxed_engine/src/domain/entities/box.dart';
import 'package:letter_boxed_engine/src/domain/entities/solver.dart';
import 'package:test/test.dart';

void main() async {
  final dictionary =
      await loadDictionary('assets/en_popular_valid_words_only.json');
  group('testing `LetterBoxSolver`', () {
    final box = Box.fromString('igh fym oea lpr');
    final oneSolution = ['polygraph', 'holier', 'reform'];

    test('should find at least one valid solution in under 20 seconds',
        () async {
      final solver = LetterBoxSolver(box, dictionary);

      final solutions = await solver.findSolutions(withLength: 3);

      expect(solutions, isNotEmpty);
      expect(solutions[0], isNotEmpty);
      expect(solutions[0].join(), oneSolution.join());
    });

    test('should find 5 solutions in under 30s', () async {
      final solver = LetterBoxSolver(box, dictionary, maxSolutions: 5);
      final sw = Stopwatch()..start();
      final solutions = await solver.findSolutions(withLength: 3);

      final ms = (sw..stop()).elapsedMilliseconds;
      expect(ms <= 30000, true,
          reason: '${solutions.length} solutions in $ms ms');
      print('found ${solutions.length} solutions in $ms ms');
      expect(solutions, isNotEmpty);
      expect(solutions[0], isNotEmpty);
      expect(solutions[0].join(), oneSolution.join());
    });
  });
}
