import 'package:encaixado_engine/src/engine/box.dart';
import 'package:encaixado_engine/src/engine/finders/finders.dart';
import 'package:test/test.dart';

void main() {
  group('testing `doesUseAllLetters`', () {
    test(
        'should return `false` if a string doesnt contains all 12 letters in box',
        () {
      final box = Box.fromString('abc def ghi jkl');
      final word = 'abc';

      final result = isSolution(word, box);

      expect(result, false);
    });

    test('should return `true` if a string contains all 12 letters in box', () {
      final box = Box.fromString('abc def ghi jkl');
      final word = 'abcdefghijkl';

      final result = isSolution(word, box);

      expect(result, true);
    });
  });
}
