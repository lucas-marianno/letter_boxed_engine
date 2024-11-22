import 'package:letter_boxed_engine/letter_boxed_engine.dart';
import 'package:letter_boxed_engine/src/data/load_dictionary.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('should generate 10 playable games', skip: true, () async {
    final dict = await loadDictionary(GameLanguage.pt);
    final gameGen = BoxGenerator(dictionary: dict);

    for (var i = 0; i < 10; i++) {
      final box = gameGen.generate();

      final solver = SolveGameBox(box, dict);

      final solutions = solver.solve();

      expect(solutions, isNotEmpty);
      print('generated a game with ${solutions.length} solutions: $box');
    }
  });
}
