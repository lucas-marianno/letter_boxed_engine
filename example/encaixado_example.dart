import 'package:encaixado_engine/encaixado.dart';

void main() async {
  final box = Box.fromString('igh fym oea lpr');
  final solver =
      LetterBoxSolver(box, timeout: Duration(seconds: 20), maxSolutions: 10);

  final solutions = await solver.findSolutions();

  print('found ${solutions.length} solutions:');
  for (var solution in solutions) {
    print(solution);
  }
}
