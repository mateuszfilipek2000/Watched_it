import 'package:watched_it_getx/app/data/models/movie/similar_media.dart';

class SimilarMovies {
  SimilarMovies({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory SimilarMovies.fromJson(Map<String, dynamic> json) => SimilarMovies(
        page: json["page"],
        results: List<SimilarMovie>.from(
            json["results"].map((x) => SimilarMovie.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  final int page;
  final List<SimilarMovie> results;
  final int totalPages;
  final int totalResults;
}

class SimilarMovie extends SimilarMedia {
  SimilarMovie({
    required this.adult,
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
    required this.video,
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

  factory SimilarMovie.fromJson(Map<String, dynamic> json) => SimilarMovie(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        releaseDate: DateTime.parse(json["release_date"]),
        posterPath: json["poster_path"],
        popularity: json["popularity"].toDouble(),
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"],
        voteCount: json["vote_count"],
      );

  final bool adult;
  //final String? backdropPath;
  //final List<int> genreIds;
  //final int id;
  //final String originalLanguage;
  //final String originalTitle;
  //final String overview;
  //final DateTime releaseDate;
  //final String? posterPath;
  //final double popularity;
  //final String title;
  final bool video;
  //final int voteAverage;
  //final int voteCount;
}
