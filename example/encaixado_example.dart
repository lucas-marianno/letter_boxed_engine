import 'package:letter_boxed_engine/encaixado.dart';
import 'package:letter_boxed_engine/src/data/load_dictionary.dart';

void main() async {
  final a = 'ift cgp las urh';
  final box = Box.fromString(a);

  final ptbr =
      await loadDictionary('assets/pt_dictionary_valid_words_only.json');

  final solver = LetterBoxSolver(box, ptbr);

  final solutions = await solver.findSolutions(withLength: 4);

  for (var solution in solutions) {
    print(solution);
  }
}
