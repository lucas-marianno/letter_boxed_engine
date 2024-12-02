import 'package:flutter/foundation.dart';
import 'package:letter_boxed_engine/letter_boxed_engine.dart';
import 'package:letter_boxed_engine/src/data/load_data_assets.dart';

Future<List<Game>> loadGames(GameLanguage language) async {
  final rawGameData = await loadDataAssets('games.json');

  return compute(_processGameData,
      {'rawGameData': rawGameData, 'language': language.name});
}

List<Game> _processGameData(Map<String, dynamic> input) {
  final language = input['language'] as String;
  final rawGameData = input['rawGameData'] as Map<String, dynamic>;

  final games = <Game>[];
  (rawGameData[language] as Map<String, dynamic>).forEach((box, s) {
    games.add(Game(
      box: Box(fromString: box),
      language: GameLanguage.fromString(language),
      nOfSolutions: s,
    ));
  });

  return games;
}
