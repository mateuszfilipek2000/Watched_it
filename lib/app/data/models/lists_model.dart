class Lists {
  Lists({
    required this.id,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory Lists.fromJson(Map<String, dynamic> json) => Lists(
        id: json["id"],
        page: json["page"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  final int id;
  final int page;
  final List<Result> results;
  final int totalPages;
  final int totalResults;
}

class Result {
  Result({
    required this.description,
    required this.favoriteCount,
    required this.id,
    required this.itemCount,
    required this.iso6391,
    required this.listType,
    required this.name,
    required this.posterPath,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        description: json["description"],
        favoriteCount: json["favorite_count"],
        id: json["id"],
        itemCount: json["item_count"],
        iso6391: json["iso_639_1"],
        listType: listTypeValues[json["list_type"]] as ListType,
        name: json["name"],
        posterPath: json["poster_path"] == null ? null : json["poster_path"],
      );

  final String description;
  final int favoriteCount;
  final int id;
  final int itemCount;
  final String iso6391;
  final ListType listType;
  final String name;
  final String posterPath;
}

enum ListType { MOVIE }

Map<String, ListType> listTypeValues = {"movie": ListType.MOVIE};
