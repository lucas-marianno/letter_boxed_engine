import 'package:letter_boxed_engine/src/data/load_dictionary.dart';
import 'package:letter_boxed_engine/src/letter_boxed_engine_base.dart';
import 'package:test/test.dart';

main() {
  test('sandbox', skip: true, () async {
    final dictionary = await loadDictionary(GameLanguage.pt);

    final box = Box(fromString: 'faz nim rod uvl');
    final solver = SolveGameBox(box, dictionary);

    final solutions = solver.solve();

    print('found ${solutions.length} solutions:');

    for (var s in solutions) {
      print(s);
    }
  });
}
