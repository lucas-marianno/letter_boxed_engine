import 'package:encaixado_engine/src/engine/box.dart';
import 'package:encaixado_engine/src/engine/finders/solution.dart';
import 'package:test/test.dart';

void main() {
  group('testing `isSolution`', () {
    test('should return false if not solution', () {
      final box = Box.fromString('abc def ghi jkl');
      final possibleSolution = ['alfa'];

      final response = Solution.validate(possibleSolution, box);

      expect(response.isValid, false);
    });

    test('should return true if is solution', () {
      final box = Box.fromString('abc def ghi jkl');
      final possibleSolution = ['abcdefghijkl'];

      final response = Solution.validate(possibleSolution, box);

      expect(response.isValid, true);
    });
  });

  group('testing `usedLetters`', () {
    test('should return the letters used by a possible solution', () {
      final box = Box.fromString('abc def ghi jkl');
      final possibleSolution = ['alfa', 'beta', 'gama'];
      final usedLetters = 'abefglmt';

      final response = Solution.validate(possibleSolution, box);

      expect(response.usedLetters, usedLetters);
    });

    test('should return the letters not used by a possible solution', () {
      final box = Box.fromString('abc def ghi jkl');
      final possibleSolution = ['alfa', 'beta', 'gama'];
      final unUsedLetters = 'cdhijk';

      final response = Solution.validate(possibleSolution, box);

      expect(response.unUsedLetters, unUsedLetters);
    });
  });
}
