class SimilarTvShows {
  SimilarTvShows({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  final int page;
  final List<Result> results;
  final int totalPages;
  final int totalResults;

  factory SimilarTvShows.fromJson(Map<String, dynamic> json) => SimilarTvShows(
        page: json["page"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}

class Result {
  Result({
    this.backdropPath,
    required this.firstAirDate,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.originCountry,
    this.posterPath,
    required this.popularity,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
  });

  final String? backdropPath;
  final DateTime firstAirDate;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final List<String> originCountry;
  final String? posterPath;
  final double popularity;
  final String name;
  final double voteAverage;
  final int voteCount;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        backdropPath: json["backdrop_path"],
        firstAirDate: DateTime.parse(json["first_air_date"]),
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"],
        originCountry:
            List<String>.from(json["origin_country"].map((x) => x.toString())),
        posterPath: json["poster_path"],
        popularity: json["popularity"].toDouble(),
        name: json["name"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );
}
