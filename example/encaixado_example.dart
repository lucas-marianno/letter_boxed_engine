import 'package:encaixado_engine/encaixado.dart';

void main() async {
  'ipw unt sea jrc';
  final box = Box.fromString('abc def ghi jkl');
  final solver = LetterBoxSolver(box, enable4Words: true);

  final solutions = await solver.findSolutions();

  for (var solution in solutions) {
    print(solution);
  }
}
