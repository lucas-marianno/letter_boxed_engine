import 'package:encaixado_engine/src/engine/box.dart';
import 'package:test/test.dart';

void main() {
  test('should return available letters', () {
    final box = Box('abc', 'def', 'ghi', 'jkl');
    final expected = 'abcdefghijkl';

    final response = box.availableLetters;

    expect(response, expected);
  });

  test('should return unavailable letters', () {
    final box = Box('abc', 'def', 'ghi', 'jkl');
    final expected = 'mnopqrstuvwxyz';

    final response = box.unavailableLetters;

    expect(response, expected);
  });

  group('testing `isValidBox`', () {
    test('should return false if box is null', () {
      expect(() => Box.validateBox(null), throwsException);
    });
    test('should return false if box is empty', () {
      expect(() => Box.validateBox(''), throwsException);
    });
    test('should return false if box.length is not 15', () {
      expect(() => Box.validateBox('abababab'), throwsException);
      expect(() => Box.validateBox('ababababsadsadasdasdasdasdasdasdasd'),
          throwsException);
    });
    test(
        'should return false if box contains anything other than words and spaces',
        () {
      expect(() => Box.validateBox('abc def ghi jk6'), throwsException);
      expect(() => Box.validateBox('abc def ghi-jkl'), throwsException);
    });
    test('should return false spacing is incorrect', () {
      expect(() => Box.validateBox('abcd ef ghi jkl'), throwsException);
    });
    test('should return false if n of letters is incorrect', () {
      expect(() => Box.validateBox('               '), throwsException);
      expect(() => Box.validateBox('abcdefghijklmno'), throwsException);
    });
    test('should return false if n of spaces is incorrect', () {
      expect(() => Box.validateBox('               '), throwsException);
      expect(() => Box.validateBox('abcdefghijklmno'), throwsException);
    });
    test('should return true for a valid box (should not match case)', () {
      expect(() => Box.validateBox('abc def ghi jkl'), returnsNormally);
      expect(() => Box.validateBox('ABC DEF GHI JKL'), returnsNormally);
    }); //                    '123456789012345'
  });
}
