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
}
