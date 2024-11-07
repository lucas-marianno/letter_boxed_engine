import 'package:flutter_test/flutter_test.dart';
import 'package:letter_boxed_engine/src/data/load_dictionary.dart';
import 'package:letter_boxed_engine/src/letter_boxed_engine_base.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('should load an asset and return a Set<String>', () async {
    final loaded = await loadDictionary(GameLanguage.pt);

    expect(loaded, isA<List<String>>());
    expect(loaded, isNotEmpty);
  });
}
