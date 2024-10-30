import 'package:letter_boxed_engine/src/data/load_dictionary.dart';
import 'package:letter_boxed_engine/src/domain/entities/game_generator.dart';
import 'package:test/test.dart';

void main() {
  test('should generate a playable game in less than 1000ms', () async {
    final gameGen = GameGenerator();
    final dictionary =
        await loadDictionary('assets/pt_dictionary_valid_words_only.json');

    final game = await gameGen.genGameFromRandom(dictionary);

    expect(game, isNotNull, reason: 'didn\'t generate a valid game');
  });
}
