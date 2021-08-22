class Videos {
  Videos({
    required this.id,
    required this.results,
  });

  final int id;
  final List<Result> results;

  factory Videos.fromJson(Map<String, dynamic> json) => Videos(
        id: json["id"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );
}

class Result {
  Result({
    required this.iso6391,
    required this.iso31661,
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.publishedAt,
    required this.id,
  });

  final String iso6391;
  final String iso31661;
  final String name;
  final String key;
  final String site;
  final int size;
  final String type;
  final bool official;
  final DateTime publishedAt;
  final String id;

  String? getVideoLink() {
    if (this.site == "YouTube")
      return "https://www.youtube.com/watch?v=${this.key}";
    else if (this.site == "Vimeo")
      return "https://vimeo.com/${this.key}";
    else {
      return null;
    }
  }

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        iso6391: json["iso_639_1"],
        iso31661: json["iso_3166_1"],
        name: json["name"],
        key: json["key"],
        site: json["site"],
        size: json["size"],
        type: json["type"],
        official: json["official"],
        publishedAt: DateTime.parse(json["published_at"]),
        id: json["id"],
      );
}
