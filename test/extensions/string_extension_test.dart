import 'package:flutter_test/flutter_test.dart';
import 'package:letter_boxed_engine/src/extensions/string_extension.dart';

void main() {
  test('should return the count of unique characters', () {
    expect('banana'.charCount, 3);
    expect('monkey'.charCount, 6);
    expect('macaco'.charCount, 4);
  });
}
