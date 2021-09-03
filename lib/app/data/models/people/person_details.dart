class PersonDetails {
  PersonDetails({
    this.birthday,
    required this.knownForDepartment,
    this.deathday,
    required this.id,
    required this.name,
    required this.alsoKnownAs,
    required this.gender,
    required this.biography,
    required this.popularity,
    this.placeOfBirth,
    this.profilePath,
    required this.adult,
    required this.imdbId,
    this.homepage,
  });

  final DateTime? birthday;
  final String knownForDepartment;
  final DateTime? deathday;
  final int id;
  final String name;
  final List<String> alsoKnownAs;
  final int gender;
  final String biography;
  final double popularity;
  final String? placeOfBirth;
  final String? profilePath;
  final bool adult;
  final String? imdbId;
  final String? homepage;

  factory PersonDetails.fromJson(Map<String, dynamic> json) => PersonDetails(
        birthday:
            json["birthday"] == null ? null : DateTime.parse(json["birthday"]),
        knownForDepartment: json["known_for_department"],
        deathday:
            json["deathday"] == null ? null : DateTime.parse(json["deathday"]),
        id: json["id"],
        name: json["name"],
        alsoKnownAs: List<String>.from(json["also_known_as"].map((x) => x)),
        gender: json["gender"],
        biography: json["biography"],
        popularity: json["popularity"].toDouble(),
        placeOfBirth:
            json["place_of_birth"] == null ? null : json["place_of_birth"],
        profilePath: json["profile_path"] == null ? null : json["profile_path"],
        adult: json["adult"],
        imdbId: json["imdb_id"],
        homepage: json["homepage"] == null ? null : json["homepage"],
      );
}
