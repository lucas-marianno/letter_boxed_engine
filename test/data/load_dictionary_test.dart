import 'package:letter_boxed_engine/src/data/load_dictionary.dart';
import 'package:test/test.dart';

void main() {
  test('should load an asset and return a Set<String>', () async {
    final loaded = await loadDictionary('assets/en_dictionary.json');

    expect(loaded, isA<Set<String>>());
    expect(loaded, isNotEmpty);
  });
}
