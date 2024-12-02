import 'package:letter_boxed_engine/src/domain/entities/box.dart';
import 'package:letter_boxed_engine/src/extensions/string_extension.dart';

class SolveGameBox {
  final Box box;
  late final List<String> _dict;

  SolveGameBox(this.box, List<String> dictionary) {
    _dict = dictionary.where((w) => !w.contains(box.denied)).toList();
  }

  List<String>? solve([int minLength = 1, int maxLength = 5]) {
    assert(minLength < maxLength);

    final sw = Stopwatch()..start();

    final queue = _dict.map((w) => [w]).toList();

    while (queue.isNotEmpty &&
        queue.first.length <= maxLength &&
        sw.elapsed.inSeconds < 2) {
      final current = queue.first;

      if (current.join().charCount == 12) {
        if (current.length >= minLength) {
          return current;
        }
        queue.removeAt(0);
      } else {
        _dict.where((w) => _shouldAddWord(current, w)).forEach((w) {
          queue.add(current + [w]);
        });

        queue.removeAt(0);

        // sorts the queue by most unique letters first
        queue.sort((a, b) {
          int aCount = a.join().charCount;
          int bCount = b.join().charCount;
          return bCount.compareTo(aCount);
        });
      }
    }

    return null;
  }

  bool _shouldAddWord(List<String> current, String nextWord) {
    if (!nextWord.startsWith(current.last.lastChar)) return false;
    // if (current.contains(nextWord)) return false;

    final nextSolution = current + [nextWord];
    final currentCount = current.join().charCount;
    final nextCount = nextSolution.join().charCount;

    if (nextCount <= currentCount) return false;
    if (nextCount > 12) return false;

    return true;
  }
}
