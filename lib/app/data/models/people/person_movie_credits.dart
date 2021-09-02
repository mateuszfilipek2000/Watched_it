class PersonMovieCredits {
  PersonMovieCredits({
    required this.cast,
    required this.crew,
    required this.id,
  });

  final List<Cast> cast;
  final List<Crew> crew;
  final int? id;

  factory PersonMovieCredits.fromJson(Map<String, dynamic> json) =>
      PersonMovieCredits(
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromJson(x))),
        crew: List<Crew>.from(json["crew"].map((x) => Crew.fromJson(x))),
        id: json["id"],
      );
}

class Cast {
  Cast({
    required this.character,
    required this.creditId,
    required this.releaseDate,
    required this.voteCount,
    required this.video,
    required this.adult,
    required this.voteAverage,
    required this.title,
    required this.genreIds,
    required this.originalLanguage,
    required this.originalTitle,
    required this.popularity,
    required this.id,
    required this.backdropPath,
    required this.overview,
    required this.posterPath,
  });

  final String character;
  final String creditId;
  final DateTime? releaseDate;
  final int voteCount;
  final bool video;
  final bool adult;
  final double voteAverage;
  final String title;
  final List<int> genreIds;
  final String originalLanguage;
  final String originalTitle;
  final double popularity;
  final int id;
  final String? backdropPath;
  final String overview;
  final String? posterPath;

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        character: json["character"] == null ? null : json["character"],
        creditId: json["credit_id"],
        releaseDate: json["release_date"] == null || json["release_date"] == ""
            ? null
            : DateTime.parse(json["release_date"]),
        voteCount: json["vote_count"],
        video: json["video"],
        adult: json["adult"],
        voteAverage: json["vote_average"].toDouble(),
        title: json["title"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        popularity: json["popularity"].toDouble(),
        id: json["id"],
        backdropPath:
            json["backdrop_path"] == null ? null : json["backdrop_path"],
        overview: json["overview"],
        posterPath: json["poster_path"] == null ? null : json["poster_path"],
      );
}

class Crew {
  Crew({
    required this.creditId,
    required this.releaseDate,
    required this.voteCount,
    required this.video,
    required this.adult,
    required this.voteAverage,
    required this.title,
    required this.genreIds,
    required this.originalLanguage,
    required this.originalTitle,
    required this.popularity,
    required this.id,
    required this.backdropPath,
    required this.overview,
    required this.posterPath,
    required this.department,
    required this.job,
  });

  final String creditId;
  final DateTime? releaseDate;
  final int voteCount;
  final bool video;
  final bool adult;
  final double voteAverage;
  final String title;
  final List<int> genreIds;
  final String originalLanguage;
  final String originalTitle;
  final double popularity;
  final int id;
  final String? backdropPath;
  final String overview;
  final String? posterPath;
  final String department;
  final String job;

  factory Crew.fromJson(Map<String, dynamic> json) => Crew(
        creditId: json["credit_id"],
        releaseDate: json["release_date"] == null || json["release_date"] == ""
            ? null
            : DateTime.parse(json["release_date"]),
        voteCount: json["vote_count"],
        video: json["video"],
        adult: json["adult"],
        voteAverage: json["vote_average"].toDouble(),
        title: json["title"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        popularity: json["popularity"].toDouble(),
        id: json["id"],
        backdropPath:
            json["backdrop_path"] == null ? null : json["backdrop_path"],
        overview: json["overview"],
        posterPath: json["poster_path"] == null ? null : json["poster_path"],
        department: json["department"],
        job: json["job"],
      );
}
