import 'package:letter_boxed_engine/src/data/load_dictionary.dart';
import 'package:letter_boxed_engine/src/letter_boxed_engine_base.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  final dictionary = await loadDictionary(GameLanguage.en);
  group('testing `LetterBoxSolver`', () {
    final box = Box(fromString: 'igh fym oea lpr');
    final oneSolution = ['polygraph', 'hamper', 'relief'];

    test('should find at least one valid solution in under 20 seconds',
        () async {
      final solver = SolveGameBox(box, dictionary);

      final solutions = solver.solve(withLength: 3);

      expect(solutions, isNotEmpty);
      expect(solutions[0], isNotEmpty);
      expect(solutions[0].join(), oneSolution.join());
    });

    test('should find 5 solutions in under 30s', () async {
      final solver = SolveGameBox(box, dictionary, maxSolutions: 5);
      final sw = Stopwatch()..start();
      final solutions = solver.solve(withLength: 3);

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
