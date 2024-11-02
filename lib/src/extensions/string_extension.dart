extension StringExtension on String {
  String get lastChar {
    if (isEmpty) return '';
    return String.fromCharCode(runes.last);
  }

  String insert(int index, String string) {
    return (split('')..insert(index, string)).join();
  }
}
