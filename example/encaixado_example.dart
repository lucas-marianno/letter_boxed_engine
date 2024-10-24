import 'package:encaixado_engine/encaixado.dart';
import 'package:encaixado_engine/src/data/load_dictionary.dart';

void main() async {
  final b = 'ift cgp las uro';
  final box = Box.fromString(b);

  final ptbr =
      await loadDictionary('assets/pt_dictionary_valid_words_only.json');

  final solver = LetterBoxSolver(box, ptbr, wordCount: 3);

  final solutions = await solver.findSolutions();

  for (var solution in solutions) {
    // print(solution);
  }
}
