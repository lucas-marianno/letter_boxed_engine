List<String> sortByMostUniqueLetters(Set<String> wordList) {
  return wordList.toList()
    ..sort((a, b) {
      int aLen = a.runes.toSet().length;
      int bLen = b.runes.toSet().length;

      return bLen.compareTo(aLen);
    });
}
