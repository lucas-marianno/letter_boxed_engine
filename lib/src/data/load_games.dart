import 'package:flutter/foundation.dart';
import 'package:letter_boxed_engine/letter_boxed_engine.dart';
import 'package:letter_boxed_engine/src/data/load_data_assets.dart';

Future<List<Game>> loadGames(GameLanguage language) async {
  final rawGameData = await loadDataAssets('games.json');

  return compute(_processGameData, [rawGameData, language.name]);
}

List<Game> _processGameData(List input) {
  final rawData = input[0] as Map<String, dynamic>;
  final language = input[1] as String;

  final games = <Game>[];
  (rawData[language] as Map<String, dynamic>).forEach((box, s) {
    games.add(Game(
      box: Box(fromString: box),
      language: GameLanguage.fromString(language),
      solution: List<String>.from(s),
    ));
  });

  return games;
}
