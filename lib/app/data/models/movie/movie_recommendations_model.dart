class MovieRecommendations {
  MovieRecommendations({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieRecommendations.fromJson(Map<String, dynamic> json) =>
      MovieRecommendations(
        page: json["page"],
        results: List<RecommendedMovie>.from(
            json["results"].map((x) => RecommendedMovie.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  final int page;
  final List<RecommendedMovie> results;
  final int totalPages;
  final int totalResults;
}

class RecommendedMovie {
  RecommendedMovie({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.releaseDate,
    required this.posterPath,
    required this.popularity,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory RecommendedMovie.fromJson(Map<String, dynamic> json) =>
      RecommendedMovie(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        releaseDate: json["release_date"] == null || json["release_date"] == ""
            ? null
            : DateTime.parse(json["release_date"]),
        posterPath: json["poster_path"],
        popularity:
            json["popularity"] == null ? null : json["popularity"].toDouble(),
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"] == null
            ? null
            : json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  final bool adult;
  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final DateTime? releaseDate;
  final String? posterPath;
  final double? popularity;
  final String title;
  final bool video;
  final double? voteAverage;
  final int? voteCount;
}
