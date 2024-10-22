import 'package:encaixado_engine/src/domain/entities/box.dart';
import 'package:test/test.dart';

void main() {
  test('should return available letters', () {
    final box = Box.fromString('abc def ghi jkl');
    final expected = 'abcdefghijkl';

    final response = box.letterBox.join();

    expect(response, expected);
  });

  test('should return unavailable letters', () {
    final box = Box.fromString('abc def ghi jkl');
    final expected = 'mnopqrstuvwxyz';

    final response = box.unavailableLetters;

    expect(response, expected);
  });

  group('testing `isValidBox`', () {
    test('should throw exception if empty', () {
      expect(() => Box.fromString(''), throwsException);
    });
    test('should throw exception if box.length is not 15', () {
      expect(() => Box.fromString('abababab'), throwsException);
      expect(() => Box.fromString('ababababsadsadasdasdasdg'), throwsException);
    });
    test('should throw exception if box contains more than words and spaces',
        () {
      expect(() => Box.fromString('abc def ghi jk6'), throwsException);
      expect(() => Box.fromString('abc def ghi-jkl'), throwsException);
    });
    test('should throw exception if spacing is incorrect', () {
      expect(() => Box.fromString('abcd ef ghi jkl'), throwsException);
    });
    test('should throw exception if n of letters is incorrect', () {
      expect(() => Box.fromString('               '), throwsException);
      expect(() => Box.fromString('abcdefghijklmno'), throwsException);
    });
    test('should throw exception if n of spaces is incorrect', () {
      expect(() => Box.fromString('               '), throwsException);
      expect(() => Box.fromString('abcdefghijklmno'), throwsException);
    });
    test('should not throw exception for a valid box', () {
      expect(() => Box.fromString('abc def ghi jkl'), returnsNormally);
    });
    test('should not match case', () {
      expect(() => Box.fromString('ABC DEF GHI JKL'), returnsNormally);
    }); //
  });
}