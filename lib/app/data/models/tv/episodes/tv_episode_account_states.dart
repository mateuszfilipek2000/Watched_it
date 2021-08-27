class TvEpisodeAccountStates {
  TvEpisodeAccountStates({
    this.id,
    this.rated,
  });
  final int? id;
  final double? rated;

  factory TvEpisodeAccountStates.fromJson(Map<String, dynamic> json) =>
      TvEpisodeAccountStates(
        id: json["id"],
        rated: json["rated"] == null || json["rated"] == false
            ? null
            : json["rated"],
      );
}
