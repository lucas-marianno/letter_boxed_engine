import 'package:encaixado_engine/extensions/stdout_extension.dart';
import 'package:encaixado_engine/src/engine/box.dart';
import 'package:encaixado_engine/src/engine/solver/solver.dart';

void main() async {
  stdout.clear();
  stdout.writeln(
      "Let's find some possible words that might solve today's Letter Boxed.\n\n"
      "First, write down today's letter box according to the example:\n"
      "Example: 'abc def ghi jkl' (where it represents top-left-right-bottom respectively)\n\n"
      " A B C \n"
      "D     G\n"
      "E     H\n"
      "F     I\n"
      " J K L \n"
      "\nEnter Letter Box ('abc def ghi jkl'): \n");

  String? input = stdin.readLineSync();
  bool keepLoop() =>
      input?.toLowerCase() != 'q' && input?.toLowerCase() != 'quit';
  Box? box;

  do {
    while (box == null && keepLoop()) {
      try {
        box = Box.fromString(input!);
        stdout.clear();
        break;
      } catch (e) {
        stdout.clear();
        stdout.writeln(e);
        stdout.writeln(
            " Use the format: 'abc def ghi jkl' (separated by `spaces`)\n\n"
            "Enter 'q' to quit\n\n"
            "\nEnter Letter Box: \n");
        input = stdin.readLineSync();
      }
    }

    await solver(box!);
    box = null;
    stdout.writeln(
        '\n(write a new `letter box` to find solutions | `q` to quit)\n');
    input = stdin.readLineSync();
  } while (keepLoop());
}
