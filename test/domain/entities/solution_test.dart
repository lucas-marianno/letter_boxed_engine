import 'package:encaixado_engine/src/data/load_dictionary.dart';
import 'package:encaixado_engine/src/domain/entities/box.dart';
import 'package:encaixado_engine/src/domain/entities/solution.dart';
import 'package:encaixado_engine/src/domain/usecases/filters.dart';
import 'package:encaixado_engine/src/domain/usecases/sorters.dart';
import 'package:test/test.dart';

void main() {
  test('test ', () async {
    final dictionary = await loadDictionary();
    final box = Box.fromString('igh fym lpr oea');
    final filter = Filter(wordlist: dictionary, box: box);
    filter.byBox();
    filter.byAvailableLetters();

    filter.byStartingLetter('e');
    filter.byMustContain('');

    final wordlist = sortByMostUniqueLetters(dictionary);

    print(wordlist);
  });

  test('should return false if not solution', () {
    final box = Box.fromString('abc def ghi jkl');
    final possibleSolution = ['alfa', 'fil'];

    final response = Solution.validate(possibleSolution, box);

    expect(response.isValid, false);
  });

  test('should return true if is solution', () {
    final box = Box.fromString('abc def ghi jkl');
    final possibleSolution = ['abcdef', 'ghijkl'];

    final response = Solution.validate(possibleSolution, box);

    expect(response.isValid, true);
  });
  test('should return true if is solution (real puzzle)', () {
    final box = Box.fromString('igh fym oea lpr');

    final possibleSolution = ['foliage', 'ephemeral', 'lye'];

    final response = Solution.validate(possibleSolution, box);

    expect(response.isValid, true);
  });
}
