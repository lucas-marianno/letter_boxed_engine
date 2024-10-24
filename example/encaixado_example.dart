import 'package:encaixado_engine/encaixado.dart';
import 'package:encaixado_engine/src/data/load_dictionary.dart';

void main() async {
  'ipw unt sea jrc';
  final box = Box.fromString('ift cgp las uro');
  final dictionary =
      await loadDictionary('assets/pt_dictionary_valid_words_only.json');
  final solver = LetterBoxSolver(box, dictionary);

  final solutions = await solver.findSolutions();

  for (var solution in solutions) {
    print(solution);
  }
}
