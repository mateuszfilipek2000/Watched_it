class TvSeasonDetails {
  TvSeasonDetails({
    required this.id,
    required this.airDate,
    required this.episodes,
    required this.name,
    required this.overview,
    this.posterPath,
    required this.seasonNumber,
  });

  final String id;
  final DateTime airDate;
  final List<Episode> episodes;
  final String name;
  final String overview;
  final String? posterPath;
  final int seasonNumber;

  factory TvSeasonDetails.fromJson(Map<String, dynamic> json) =>
      TvSeasonDetails(
        id: json["_id"],
        airDate: DateTime.parse(json["air_date"]),
        episodes: List<Episode>.from(
            json["episodes"].map((x) => Episode.fromJson(x))),
        name: json["name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
      );
}

class Episode {
  Episode({
    required this.airDate,
    required this.episodeNumber,
    required this.crew,
    required this.guestStars,
    required this.id,
    required this.name,
    required this.overview,
    required this.productionCode,
    required this.seasonNumber,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount,
  });

  final DateTime airDate;
  final int episodeNumber;
  final List<Crew> crew;
  final List<GuestStars> guestStars;
  final int id;
  final String name;
  final String overview;
  final String productionCode;
  final int seasonNumber;
  final String stillPath;
  final double voteAverage;
  final int voteCount;

  factory Episode.fromJson(Map<String, dynamic> json) => Episode(
        airDate: DateTime.parse(json["air_date"]),
        episodeNumber: json["episode_number"],
        crew: List<Crew>.from(json["crew"].map((x) => Crew.fromJson(x))),
        guestStars: List<GuestStars>.from(
            json["guest_stars"].map((x) => GuestStars.fromJson(x))),
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        productionCode: json["production_code"],
        seasonNumber: json["season_number"],
        stillPath: json["still_path"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );
}

class Crew {
  Crew({
    required this.department,
    required this.job,
    required this.creditId,
    this.adult,
    this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    this.profilePath,
    required this.order,
    required this.character,
  });

  final String department;
  final String job;
  final String creditId;
  final bool? adult;
  final int? gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final int order;
  final String character;

  factory Crew.fromJson(Map<String, dynamic> json) => Crew(
        department: json["department"] == null ? null : json["department"],
        job: json["job"] == null ? null : json["job"],
        creditId: json["credit_id"],
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"].toDouble(),
        profilePath: json["profile_path"] == null ? null : json["profile_path"],
        order: json["order"] == null ? null : json["order"],
        character: json["character"] == null ? null : json["character"],
      );
}

class GuestStars {
  GuestStars({
    required this.credit_id,
    required this.order,
    required this.character,
    required this.adult,
    this.gender,
    required this.id,
    required this.known_for_department,
    required this.name,
    required this.original_name,
    required this.popularity,
    this.profile_path,
  });

  factory GuestStars.fromJson(Map<String, dynamic> json) => GuestStars(
        credit_id: json["credit_id"],
        order: json["order"],
        character: json["character"],
        adult: json["adult"],
        id: json["id"],
        known_for_department: json["known_for_department"],
        name: json["name"],
        original_name: json["original_name"],
        popularity: json["popularity"],
      );

  final String credit_id;
  final int order;
  final String character;
  final bool adult;
  final int? gender;
  final int id;
  final String known_for_department;
  final String name;
  final String original_name;
  final double popularity;
  final String? profile_path;
}
