class AccountStates {
  AccountStates({
    this.id,
    required this.favourite,
    required this.rated,
    required this.watchlist,
  });
  factory AccountStates.fromJson(Map<String, dynamic> json) => AccountStates(
        id: json["id"],
        favourite: json["favorite"],
        rated: json["rated"] is bool ? null : json["rated"]["value"],
        watchlist: json["watchlist"],
      );

  final int? id;
  final bool favourite;
  final double? rated;
  final bool watchlist;
}
