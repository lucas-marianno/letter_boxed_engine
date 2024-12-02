extension StringExtension on String {
  String get lastChar {
    if (isEmpty) return '';
    return String.fromCharCode(runes.last);
  }

  int get charCount {
    return split('').toSet().length;
  }

  String insert(int index, String string) {
    return (split('')..insert(index, string)).join();
  }
}
