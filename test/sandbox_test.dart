import 'package:letter_boxed_engine/src/data/load_dictionary.dart';
import 'package:letter_boxed_engine/src/letter_boxed_engine_base.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('sandbox', skip: false, () async {
    final dictionary = await loadDictionary(GameLanguage.pt);
    final box = Box(fromString: 'cnr ota iep mus');

    final solver = SolveGameBox(box, dictionary);

    final solution = solver.solve();

    print(solution);
  });
}
