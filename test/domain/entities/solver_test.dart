import 'package:letter_boxed_engine/src/data/load_dictionary.dart';
import 'package:letter_boxed_engine/src/letter_boxed_engine_base.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('testing Solver 2.0', () {
    late List<String> dict;
    setUpAll(() async {
      dict = await loadDictionary(GameLanguage.pt);
    });
    test('a', () {
      print('test started');
      final box = Box(fromString: "mla hce osq utr");
      final solver2 = SolveGameBox(box, dict);

      final s = solver2.solve(1, 10);

      print("Solução encontrada: $s");
    });
  });
}
