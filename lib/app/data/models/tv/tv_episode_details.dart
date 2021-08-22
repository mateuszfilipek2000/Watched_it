class TvEpisodeDetails {
  TvEpisodeDetails({
    required this.airDate,
    required this.crew,
    required this.episodeNumber,
    required this.guestStars,
    required this.name,
    required this.overview,
    required this.id,
    this.productionCode,
    required this.seasonNumber,
    this.stillPath,
    required this.voteAverage,
    required this.voteCount,
  });

  final DateTime airDate;
  final List<Crew> crew;
  final int episodeNumber;
  final List<GuestStar> guestStars;
  final String name;
  final String overview;
  final int id;
  final String? productionCode;
  final int seasonNumber;
  final String? stillPath;
  final double voteAverage;
  final int voteCount;

  factory TvEpisodeDetails.fromJson(Map<String, dynamic> json) =>
      TvEpisodeDetails(
        airDate: DateTime.parse(json["air_date"]),
        crew: List<Crew>.from(json["crew"].map((x) => Crew.fromJson(x))),
        episodeNumber: json["episode_number"],
        guestStars: List<GuestStar>.from(
            json["guest_stars"].map((x) => GuestStar.fromJson(x))),
        name: json["name"],
        overview: json["overview"],
        id: json["id"],
        productionCode: json["production_code"],
        seasonNumber: json["season_number"],
        stillPath: json["still_path"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );
}

class Crew {
  Crew({
    required this.id,
    required this.creditId,
    required this.name,
    required this.department,
    required this.job,
    this.profilePath,
  });

  final int id;
  final String creditId;
  final String name;
  final String department;
  final String job;
  final String? profilePath;

  factory Crew.fromJson(Map<String, dynamic> json) => Crew(
        id: json["id"],
        creditId: json["credit_id"],
        name: json["name"],
        department: json["department"],
        job: json["job"],
        profilePath: json["profile_path"] == null ? null : json["profile_path"],
      );
}

class GuestStar {
  GuestStar({
    required this.id,
    required this.name,
    required this.creditId,
    required this.character,
    required this.order,
    this.profilePath,
  });

  final int id;
  final String name;
  final String creditId;
  final String character;
  final int order;
  final String? profilePath;

  factory GuestStar.fromJson(Map<String, dynamic> json) => GuestStar(
        id: json["id"],
        name: json["name"],
        creditId: json["credit_id"],
        character: json["character"],
        order: json["order"],
        profilePath: json["profile_path"],
      );
}
