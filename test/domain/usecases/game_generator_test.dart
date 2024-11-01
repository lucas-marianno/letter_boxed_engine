import 'package:letter_boxed_engine/src/domain/entities/game_language.dart';
import 'package:letter_boxed_engine/src/domain/usecases/game_generator.dart';
import 'package:test/test.dart';

void main() {
  test('should generate a playable game in less than 1000ms', skip: true,
      () async {
    final gameGen = GenerateGame();

    final game = await gameGen(GameLanguage.pt);

    expect(game, isNotNull, reason: 'didn\'t generate a valid game');
  });
}
