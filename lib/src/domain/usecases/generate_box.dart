import 'dart:math';

import 'package:letter_boxed_engine/src/domain/entities/box.dart';
import 'package:letter_boxed_engine/src/extensions/string_extension.dart';

class BoxGenerator {
  final List<String> dictionary;

  BoxGenerator({required this.dictionary});

  Box generate() {
    List<String> futureBox = ['', '', '', ''];
    String seed = dictionary[Random().nextInt(dictionary.length - 1)];
    List<String> usedWords = [];

    while (futureBox.join().length < 12) {
      for (int i = 0; i < seed.length; i++) {
        if (futureBox.join().contains(seed[i])) {
          for (int j = 0; j < futureBox.length; j++) {
            final s = futureBox[j];
            if (i > 0 && s.contains(seed[i]) && s.contains(seed[i - 1])) {
              futureBox[j] = s.replaceFirst(seed[i], '');
              i--;
            }
          }
        } else {
          for (int j = 0; j < 4; j++) {
            if (futureBox[j].length < 3 &&
                !futureBox[j].contains(seed[max(i - 1, 0)])) {
              futureBox[j] += seed[i];
              break;
            }
          }
        }
      }

      if (futureBox.join().length == 12) break;

      usedWords.add(seed);

      final newSeed = _genNewSeed(usedWords, futureBox);

      if (newSeed == null) return generate();

      seed = newSeed;
    }
    return Box(fromString: futureBox.join(' '));
  }

  String? _genNewSeed(List<String> usedWords, List<String> futureBox) {
    final tempDict = dictionary.where((w) {
      return w.startsWith(usedWords.last.lastChar) &&
          w.contains(RegExp('[^${futureBox.join()}]')) &&
          (usedWords.join() + w).split('').toSet().length <= 12 &&
          _fitsTempBox(w, futureBox);
    });

    if (tempDict.isEmpty) return null;

    return tempDict.elementAt(Random().nextInt(tempDict.length - 1));
  }

  bool _fitsTempBox(String w, List<String> futureBox) {
    for (String side in futureBox) {
      if (!_checkBySide(w, side)) return false;
    }

    return true;
  }

  bool _checkBySide(String w, String boxSide) {
    if (boxSide.length == 3) {
      String a = boxSide[0];
      String b = boxSide[1];
      String c = boxSide[2];

      final r = '$a$b|$b$a|$a$c|$c$a|$b$c|$c$b';

      if (w.contains(RegExp(r))) return false;
    } else if (boxSide.length == 2) {
      String a = boxSide[0];
      String b = boxSide[1];

      final r = '$a$b|$b$a';

      if (w.contains(RegExp(r))) return false;
    }

    return true;
  }
}
