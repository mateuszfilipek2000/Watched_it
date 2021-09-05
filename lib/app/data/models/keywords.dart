class Keywords {
  Keywords({
    this.id,
    required this.keywords,
  });
  factory Keywords.fromJson(Map<String, dynamic> json) => Keywords(
        id: json["id"],
        keywords: List<KeyWord>.from(
            json["keywords"].map((i) => KeyWord.fromJson(i))),
      );
  factory Keywords.fromAggregatedJson(Map<String, dynamic> json) => Keywords(
        id: json["id"],
        keywords:
            List<KeyWord>.from(json["results"].map((i) => KeyWord.fromJson(i))),
      );
  final int? id;
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
