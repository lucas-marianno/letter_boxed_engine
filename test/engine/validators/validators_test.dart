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

  group('testing `isValidBox`', () {
    test('should return false if box is null', () {
      expect(() => validateBox(null), throwsException);
    });
    test('should return false if box is empty', () {
      expect(() => validateBox(''), throwsException);
    });
    test('should return false if box.length is not 15', () {
      expect(() => validateBox('abababab'), throwsException);
      expect(() => validateBox('ababababsadsadasdasdasdasdasdasdasd'),
          throwsException);
    });
    test(
        'should return false if box contains anything other than words and spaces',
        () {
      expect(() => validateBox('abc def ghi jk6'), throwsException);
      expect(() => validateBox('abc def ghi-jkl'), throwsException);
    });
    test('should return false spacing is incorrect', () {
      expect(() => validateBox('abcd ef ghi jkl'), throwsException);
    });
    test('should return false if n of letters is incorrect', () {
      expect(() => validateBox('               '), throwsException);
      expect(() => validateBox('abcdefghijklmno'), throwsException);
    });
    test('should return false if n of spaces is incorrect', () {
      expect(() => validateBox('               '), throwsException);
      expect(() => validateBox('abcdefghijklmno'), throwsException);
    });
    test('should return true for a valid box (should not match case)', () {
      expect(() => validateBox('abc def ghi jkl'), returnsNormally);
      expect(() => validateBox('ABC DEF GHI JKL'), returnsNormally);
    }); //                    '123456789012345'
  });
}
