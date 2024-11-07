import 'package:flutter_test/flutter_test.dart';
import 'package:letter_boxed_engine/letter_boxed_engine.dart';
import 'package:letter_boxed_engine/src/data/load_games.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('should load existing games', () async {
    final games = await loadGames(GameLanguage.pt);

    print(games);
  });
}
