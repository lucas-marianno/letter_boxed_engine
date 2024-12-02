import 'package:letter_boxed_engine/letter_boxed_engine.dart';
import 'package:letter_boxed_engine/src/data/load_dictionary.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late final List<String> dict;
  setUpAll(() async {
    dict = await loadDictionary(GameLanguage.pt);
  });

  test('should generate a playable game', () async {
    final gameGen = BoxGenerator(dictionary: dict);

    final box = gameGen.generate();

    final solution = SolveGameBox(box, dict).solve(1, 10);

    expect(solution, isNotNull);
    expect(solution, isNotEmpty);
    print('"$box": $solution,');
  });
  test('should generate playable games at least 90% of the times',
      skip: 'this is a time expensive test', () async {
    final gameGen = BoxGenerator(dictionary: dict);

    Map<Box, int?> games = {};
    for (var i = 0; i < 10; i++) {
      final box = gameGen.generate();

      final solver = SolveGameBox(box, dict);

      final solution = solver.solve();

      games.addAll({box: solution?.length});
    }
    final nOfGames = games.entries.length;
    final nOfSolvable = games.values.where((v) => v != null).length;
    final percentage = nOfSolvable / nOfGames;

    final reason =
        'Found $nOfSolvable solvable games out of $nOfGames generated games. '
        'Reliability: ${percentage * 100}%';

    expect(percentage >= 0.9, true, reason: reason);
    print(reason);
  });
}
