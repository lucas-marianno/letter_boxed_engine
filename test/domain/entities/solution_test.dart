import 'package:encaixado_engine/src/domain/entities/box.dart';
import 'package:encaixado_engine/src/domain/entities/solution.dart';
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
}
