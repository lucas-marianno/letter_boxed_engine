import 'package:letter_boxed_engine/letter_boxed_engine.dart';
import 'package:letter_boxed_engine/src/data/load_data_assets.dart';

Future<List<Game>> loadGames(GameLanguage language) async {
  final games = <Game>[];
  final loadedGameData = await loadDataAssets('games.json');

  (loadedGameData[language.name] as Map<String, dynamic>).forEach((box, s) {
    games.add(Game(
      box: Box(fromString: box),
      language: language,
      nOfSolutions: s,
    ));
  });

  return games;
}
