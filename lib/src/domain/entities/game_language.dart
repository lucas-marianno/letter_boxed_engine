enum GameLanguage {
  pt,
  en;

  factory GameLanguage.fromString(String language) {
    language = language.toLowerCase();

    switch (language) {
      case 'pt':
        return pt;
      case 'en':
        return en;
      default:
        throw Exception(
          '"$language" is not a valid game language'
          'valid languages are: ${GameLanguage.values}',
        );
    }
  }

  @override
  String toString() => name;
}
