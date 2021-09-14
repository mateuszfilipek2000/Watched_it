abstract class SimilarMedia {
  SimilarMedia({
    this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    this.releaseDate,
    required this.overview,
    this.posterPath,
    required this.popularity,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
  });

  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final DateTime? releaseDate;
  final String overview;
  final String? posterPath;
  final double? popularity;
  final String title;
  final double? voteAverage;
  final int voteCount;

  // String getDashedDate() {
  //   return "${releaseDate.year}-${releaseDate.month}-${releaseDate.day}";
  // }
}
