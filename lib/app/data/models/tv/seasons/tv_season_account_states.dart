class TvSeasonAccountStates {
  TvSeasonAccountStates({
    required this.id,
    required this.episodeRatings,
  });

  final int? id;
  final List<EpisodeRating> episodeRatings;

  factory TvSeasonAccountStates.fromJson(Map<String, dynamic> json) =>
      TvSeasonAccountStates(
        id: json["id"],
        episodeRatings: List<EpisodeRating>.from(
            json["results"].map((x) => EpisodeRating.fromJson(x))),
      );
}

class EpisodeRating {
  EpisodeRating({
    required this.id,
    required this.episodeNumber,
    required this.rated,
  });

  final int id;
  final int episodeNumber;
  final double? rated;

  factory EpisodeRating.fromJson(Map<String, dynamic> json) => EpisodeRating(
        id: json["id"],
        episodeNumber: json["episode_number"],
        rated: json["rated"] == false ? null : json["rated"]["value"],
      );
}
