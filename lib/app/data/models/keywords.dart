class KeyWords {
  KeyWords({
    required this.id,
    required this.keywords,
  });
  factory KeyWords.fromJson(Map<String, dynamic> json) => KeyWords(
        id: json["id"],
        keywords: List<KeyWord>.from(
            json["keywords"].map((i) => KeyWord.fromJson(i))),
      );
  final int id;
  final List<KeyWord> keywords;
}

class KeyWord {
  KeyWord({
    required this.id,
    required this.name,
  });
  factory KeyWord.fromJson(Map<String, dynamic> json) => KeyWord(
        id: json["id"],
        name: json["name"],
      );

  final int id;
  final String name;
}
