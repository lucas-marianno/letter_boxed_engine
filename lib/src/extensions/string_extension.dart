extension StringExtension on String {
  String get lastChar {
    if (isEmpty) return '';
    return String.fromCharCode(runes.last);
  }
}
