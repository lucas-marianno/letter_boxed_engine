import 'package:letter_boxed_engine/src/domain/entities/box.dart';
import 'package:letter_boxed_engine/src/domain/usecases/filters.dart';
import 'package:letter_boxed_engine/src/extensions/string_extension.dart';

class SolveGameBox {
  final Box box;
  late final List<String> _dictionary;
  final int maxSolutions;
  late final List<String> _wordlist;

  SolveGameBox(this.box, List<String> dictionary, {this.maxSolutions = 10}) {
    _dictionary = [...dictionary];
    final filter = Filter(wordlist: _dictionary, box: box);
    filter.byBox();
    filter.byAvailableLetters();
    _wordlist = [..._dictionary];
  }

  List<List<String>> solve({int withLength = 2}) {
    assert(withLength > 0 && withLength < 5);

    final queue = <List<String>>[];

    _populateWithSingleWords(queue);

    if (withLength <= 1 || _wordlist.isEmpty) return queue;

    _populateWith2words(queue);

    if (withLength <= 2 || _wordlist.isEmpty) return queue;

    _populateWith3words(queue);

    // highly demanding 4 word sequence
    if (withLength <= 3 || _wordlist.isEmpty) return queue;

    _populateWith4words(queue);

    return queue;
  }

  void _populateWithSingleWords(List<List<String>> queue) {
    queue.addAll([
      for (var s in _wordlist) [s]
    ]);
    _filterSolutionsAndRemoveFromWordList(queue);
  }

  void _populateWith2words(List<List<String>> queue) {
    queue.addAll([
      for (String w1 in _wordlist)
        for (String w2 in _wordlist
            .where((w) => w.startsWith(w1.lastChar) && _isSolution([w1, w])))
          [w1, w2]
    ]);
    _filterSolutionsAndRemoveFromWordList(queue);
  }

  void _populateWith3words(List<List<String>> queue) {
    queue.addAll([
      for (String w1 in _wordlist)
        for (String w2 in _wordlist.where((w) => w.startsWith(w1.lastChar)))
          for (String w3 in _wordlist.where(
              (w) => w.startsWith(w2.lastChar) && _isSolution([w1, w2, w])))
            [w1, w2, w3]
    ]);
    _filterSolutionsAndRemoveFromWordList(queue);
  }

  void _populateWith4words(List<List<String>> queue) {
    queue.addAll([
      for (String w1 in _wordlist)
        for (String w2 in _wordlist.where((w) => w.startsWith(w1.lastChar)))
          for (String w3 in _wordlist.where((w) => w.startsWith(w2.lastChar)))
            for (String w4 in _wordlist.where((w) =>
                w.startsWith(w3.lastChar) && _isSolution([w1, w2, w3, w])))
              [w1, w2, w3, w4]
    ]);
    _filterSolutionsAndRemoveFromWordList(queue);
  }

  bool _isSolution(List<String> w) => w.join().split('').toSet().length > 11;

  void _filterSolutionsAndRemoveFromWordList(List<List<String>> queue) {
    queue.retainWhere((s) {
      final strSolution = s.join().split('').toSet();
      if (strSolution.length > 11) {
        for (String word in s) {
          _wordlist.remove(word);
        }

        return true;
      }
      return false;
    });
  }
}
