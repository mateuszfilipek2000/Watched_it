import 'package:watched_it_getx/app/data/models/similar_media.dart';

class SimilarTvShows {
  SimilarTvShows({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  final int page;
  final List<SimilarTv> results;
  final int totalPages;
  final int totalResults;

  factory SimilarTvShows.fromJson(Map<String, dynamic> json) => SimilarTvShows(
        page: json["page"],
        results: List<SimilarTv>.from(
            json["results"].map((x) => SimilarTv.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}

class SimilarTv extends SimilarMedia {
  SimilarTv({
    required this.originCountry,
    String? backdropPath,
    required List<int> genreIds,
    required int id,
    required String originalLanguage,
    required String originalTitle,
    required String overview,
    required DateTime releaseDate,
    String? posterPath,
    required double popularity,
    required String title,
    required double voteAverage,
    required int voteCount,
  }) : super(
          id: id,
          backdropPath: backdropPath,
          genreIds: genreIds,
          originalLanguage: originalLanguage,
          originalTitle: originalTitle,
          releaseDate: releaseDate,
          overview: overview,
          posterPath: posterPath,
          popularity: popularity,
          title: title,
          voteAverage: voteAverage,
          voteCount: voteCount,
        );

  //final String? backdropPath;
  //final DateTime releaseDate;
  //final List<int> genreIds;
  //final int id;
  //final String originalLanguage;
  //final String originalTitle;
  //final String overview;
  final List<String> originCountry;
  //final String? posterPath;
  //final double popularity;
  //final String title;
  //final double voteAverage;
  //final int voteCount;

  factory SimilarTv.fromJson(Map<String, dynamic> json) => SimilarTv(
        backdropPath: json["backdrop_path"],
        releaseDate: DateTime.parse(json["first_air_date"]),
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_name"],
        overview: json["overview"],
        originCountry:
            List<String>.from(json["origin_country"].map((x) => x.toString())),
        posterPath: json["poster_path"],
        popularity: json["popularity"].toDouble(),
        title: json["name"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );
}
