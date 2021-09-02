class PersonTvCredits {
  PersonTvCredits({
    required this.cast,
    required this.crew,
    required this.id,
  });

  final List<Cast> cast;
  final List<Crew> crew;
  final int? id;

  factory PersonTvCredits.fromJson(Map<String, dynamic> json) =>
      PersonTvCredits(
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromJson(x))),
        crew: List<Crew>.from(json["crew"].map((x) => Crew.fromJson(x))),
        id: json["id"],
      );
}

class Cast {
  Cast({
    required this.creditId,
    required this.originalName,
    required this.id,
    required this.genreIds,
    required this.character,
    required this.name,
    this.posterPath,
    required this.voteCount,
    required this.voteAverage,
    required this.popularity,
    required this.episodeCount,
    required this.originalLanguage,
    required this.firstAirDate,
    this.backdropPath,
    required this.overview,
    required this.originCountry,
  });

  final String creditId;
  final String originalName;
  final int id;
  final List<int> genreIds;
  final String character;
  final String name;
  final String? posterPath;
  final int voteCount;
  final double voteAverage;
  final double popularity;
  final int episodeCount;
  final String originalLanguage;
  final String? firstAirDate;
  final String? backdropPath;
  final String overview;
  final List<String> originCountry;

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        creditId: json["credit_id"],
        originalName: json["original_name"],
        id: json["id"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        character: json["character"] == null ? null : json["character"],
        name: json["name"],
        posterPath: json["poster_path"] == null ? null : json["poster_path"],
        voteCount: json["vote_count"],
        voteAverage: json["vote_average"].toDouble(),
        popularity: json["popularity"].toDouble(),
        episodeCount: json["episode_count"],
        originalLanguage: json["original_language"],
        firstAirDate: json["first_air_date"],
        backdropPath:
            json["backdrop_path"] == null ? null : json["backdrop_path"],
        overview: json["overview"],
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
      );
}

class Crew {
  Crew({
    required this.creditId,
    required this.originalName,
    required this.id,
    required this.genreIds,
    required this.name,
    this.posterPath,
    required this.voteCount,
    required this.voteAverage,
    required this.popularity,
    required this.episodeCount,
    required this.originalLanguage,
    required this.firstAirDate,
    this.backdropPath,
    required this.overview,
    required this.originCountry,
    required this.department,
    required this.job,
  });

  final String creditId;
  final String originalName;
  final int id;
  final List<int> genreIds;
  final String name;
  final String? posterPath;
  final int voteCount;
  final double voteAverage;
  final double popularity;
  final int? episodeCount;
  final String originalLanguage;
  final String? firstAirDate;
  final String? backdropPath;
  final String overview;
  final List<String> originCountry;
  final String department;
  final String job;

  factory Crew.fromJson(Map<String, dynamic> json) => Crew(
        creditId: json["credit_id"],
        originalName: json["original_name"],
        id: json["id"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        name: json["name"],
        posterPath: json["poster_path"] == null ? null : json["poster_path"],
        voteCount: json["vote_count"],
        voteAverage: json["vote_average"].toDouble(),
        popularity: json["popularity"].toDouble(),
        episodeCount: json["episode_count"],
        originalLanguage: json["original_language"],
        firstAirDate: json["first_air_date"],
        backdropPath:
            json["backdrop_path"] == null ? null : json["backdrop_path"],
        overview: json["overview"],
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
        department: json["department"] == null ? null : json["department"],
        job: json["job"] == null ? null : json["job"],
      );
}
