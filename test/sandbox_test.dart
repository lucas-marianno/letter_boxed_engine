import 'package:letter_boxed_engine/src/data/load_dictionary.dart';
import 'package:letter_boxed_engine/src/letter_boxed_engine_base.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('sandbox', skip: true, () async {
    final dictionary = await loadDictionary(GameLanguage.pt);
    final box = Box(fromString: 'cnr ota iep mus');

    final solver = SolveGameBox(box, dictionary);

    final solution = solver.solve();

    print(solution);
  });

  test('Generate Games', skip: true, () async {
    final engine = LetterBoxedEngine(GameLanguage.pt);
    await engine.init();

    for (var i = 0; i < 300; i++) {
      final game = await engine.generateGame();

      print('"${game.box}": ${game.solution.map((s) => '"$s"').toList()},');
    }
  });
}
