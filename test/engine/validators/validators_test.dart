import 'package:encaixado_engine/src/engine/box.dart';
import 'package:encaixado_engine/src/engine/validators/validators.dart';
import 'package:test/test.dart';

void main() {
  group('testing `isValidWord`', () {
    test('should return true for words containing only valid letters', () {
      final box = Box('abc', 'def', 'ghi', 'jkl');
      final validWord = 'abcdalk';

      final validResult = isValidWord(validWord, box);

      expect(validResult, true);
    });

    test('should return false for words containing invalid letters', () {
      final box = Box('abc', 'def', 'ghi', 'jkl');
      final invalidWord = 'abcz';

      final invalidResult = isValidWord(invalidWord, box);

      expect(invalidResult, false);
    });
  });
}
