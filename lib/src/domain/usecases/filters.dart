import '../entities/box.dart';

class Filter {
  final List<String> wordlist;
  final Box? box;

  Filter({required this.wordlist, this.box});

  void byAvailableLetters() {
    wordlist.retainWhere((word) => isValidWord(word));
  }

  void byBox() {
    assert(box != null);
    box.toString().split(' ').forEach((side) {
      byAdjacentLetters(side);
    });
  }

  void byAdjacentLetters(String boxSide) {
    assert(!boxSide.contains(RegExp('[^a-z]')), 'enter only a-z letters');
    assert(boxSide.length == 3);

    String a = boxSide[0];
    String b = boxSide[1];
    String c = boxSide[2];

    final r = '($a$b|$b$a|$a$c|$c$a|$b$c|$c$b)';

    wordlist.removeWhere((word) => word.contains(RegExp(r)));
  }

  bool isValidWord(String word) {
    final r = box?.unavailableLetters.split('').join('|');

    return !word.contains(RegExp('[$r]'));
  }
}
