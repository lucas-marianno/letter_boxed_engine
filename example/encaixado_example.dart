import 'package:letter_boxed_engine/letter_boxed_engine.dart';
import 'package:letter_boxed_engine/src/data/load_dictionary.dart';

void main() async {
  final a = 'ift cgp las urh';
  final box = Box(fromString: a);

  final ptbr = await loadDictionary(GameLanguage.pt);

  final solver = SolveGameBox(box, ptbr);

  final solution = solver.solve();

  print(solution);
}
