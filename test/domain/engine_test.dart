import 'dart:math';

import 'package:letter_boxed_engine/letter_boxed_engine.dart';
import 'package:test/test.dart';

void main() async {
  final engine = Engine(GameLanguage.pt);
  await engine.init();

  test('Should generate a game', () async {
    final game = await engine.generateGame();

    expect(game.solutions.isNotEmpty, true,
        reason: 'game ${game.box} doesn\'t have a solution');

    print(game);
    print(game.solutions.sublist(0, min(10, game.solutions.length)));
  });

  test('Should generate 10 games', () async {
    final games = <Game>[];
    for (var i = 0; i < 10; i++) {
      final game = await engine.generateGame();

      expect(game.solutions.isNotEmpty, true,
          reason: 'game ${game.box} doesn\'t have a solution');
      games.add(game);
    }

    expect(games.length, 10);
  });

  group('testing `validateWord`', () {
    final box = Box(fromString: 'rsa onm uie cbv');
    test('should return false for a word that doesnt fit box', () {
      expect(engine.validateWord('word', box), false);
      expect(engine.validateWord('casal', box), false);
      expect(engine.validateWord('suborno', box), false);
      expect(engine.validateWord('submarino', box), false);
    });

    test(
        'should return false for a word that fits box but doesnt exist in dictionary',
        () {
      expect(engine.validateWord('vanir', box), false);
      expect(engine.validateWord('rouc', box), false);
    });
    test('should return `true` for a word that fits box and dict', () {
      // TODO
      expect(engine.validateWord('ruminacoes', box), true);
      expect(engine.validateWord('subornavam', box), true);
      expect(engine.validateWord('escrever', box), true);
    });
  });

  group('testing `validateSolution`', () {
    final box = Box(fromString: 'rsa onm uie cbv');
    test('should return false if it doesnt use all letters in box', () {
      final s1 = <String>['subscreviam'];
      final s2 = <String>['minerios'];

      expect(engine.validateSolution(s1, box), false);
      expect(engine.validateSolution(s2, box), false);
    });

    test('should return false if word order is wrong', () {
      final s1 = <String>['subscreviam', 'ruminacoes'];
      final s2 = <String>['minerios', 'encubavam'];

      expect(engine.validateSolution(s1, box), false);
      expect(engine.validateSolution(s2, box), false);
    });

    test('should return true if it is a valid solution', () {
      final s1 = <String>['ruminacoes', 'subscreviam'];
      final s2 = <String>['encubavam', 'minerios'];
      final s3 = <String>['nunca', 'absorveriam'];
      final s4 = <String>['mansos', 'subscrevia'];

      expect(engine.validateSolution(s1, box), true);
      expect(engine.validateSolution(s2, box), true);
      expect(engine.validateSolution(s3, box), true);
      expect(engine.validateSolution(s4, box), true);
    });
  });
}