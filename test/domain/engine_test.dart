import 'package:letter_boxed_engine/letter_boxed_engine.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  final engine = LetterBoxedEngine(GameLanguage.pt);
  await engine.init();

  test('Should generate a game', () async {
    final game = await engine.generateGame(ensureSolvable: true);

    expect(game.nOfSolutions > 0, true,
        reason: 'game ${game.box} doesn\'t have a solution');

    print(game);
    print(game.sampleSolutions);
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
