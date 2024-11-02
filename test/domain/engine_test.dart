import 'package:letter_boxed_engine/letter_boxed_engine.dart';
import 'package:letter_boxed_engine/src/domain/engine.dart';
import 'package:test/test.dart';

void main() {
  test('Should generate 10 games', () async {
    final engine = Engine(GameLanguage.pt);
    await engine.init();

    for (var i = 0; i < 10; i++) {
      final game = await engine.generateGame();
      print(game);
    }
  });
}
