import 'package:watched_it_getx/app/data/models/tv/episodes/tv_episode_details.dart';

class TvSeasonDetails {
  TvSeasonDetails({
    required this.id,
    required this.airDate,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.tvSeasonDetailsId,
    this.posterPath,
    required this.seasonNumber,
  });

  final String id;
  final DateTime? airDate;
  final List<Episode> episodes;
  final String name;
  final String overview;
  final int tvSeasonDetailsId;
  final String? posterPath;
  final int seasonNumber;

  factory TvSeasonDetails.fromJson(Map<String, dynamic> json) =>
      TvSeasonDetails(
        id: json["_id"],
        airDate: (json["air_date"] == null) || (json["air_date"] == "")
            ? null
            : DateTime.parse(json["air_date"]),
        episodes: List<Episode>.from(
            json["episodes"].map((x) => Episode.fromJson(x))),
        name: json["name"],
        overview: json["overview"],
        tvSeasonDetailsId: json["id"],
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

  final DateTime? airDate;
  final int episodeNumber;
  final List<Crew> crew;
  final List<GuestStar> guestStars;
  final int id;
  final String name;
  final String overview;
  final String productionCode;
  final int seasonNumber;
  final String? stillPath;
  final double voteAverage;
  final int voteCount;

  factory Episode.fromJson(Map<String, dynamic> json) => Episode(
        airDate: json["air_date"] == null || json["air_date"] == ""
            ? null
            : DateTime.parse(json["air_date"]),
        episodeNumber: json["episode_number"],
        crew: List<Crew>.from(json["crew"].map((x) => Crew.fromJson(x))),
        guestStars: List<GuestStar>.from(
            json["guest_stars"].map((x) => GuestStar.fromJson(x))),
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
    this.department,
    this.job,
    required this.creditId,
    this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    this.profilePath,
    this.order,
    this.character,
  });

  final String? department;
  final String? job;
  final String creditId;
  final bool? adult;
  final int? gender;
  final int? id;
  final String? knownForDepartment;
  final String? name;
  final String? originalName;
  final double? popularity;
  final String? profilePath;
  final int? order;
  final String? character;

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
        popularity:
            json["popularity"] == null ? null : json["popularity"].toDouble(),
        profilePath: json["profile_path"] == null ? null : json["profile_path"],
        order: json["order"] == null ? null : json["order"],
        character: json["character"] == null ? null : json["character"],
      );
}
