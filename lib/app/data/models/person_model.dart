// To parse this JSON data, do
//
//     final person = personFromJson(jsonString);
import 'dart:convert';

Person personFromJson(String str) => Person.fromJson(json.decode(str));

class Person {
  Person({
    this.birthday,
    this.knownForDepartment,
    this.deathday,
    this.id,
    this.name,
    this.alsoKnownAs,
    this.gender,
    this.biography,
    this.popularity,
    this.placeOfBirth,
    this.profilePath,
    this.adult,
    this.imdbId,
    this.homepage,
  });

  final DateTime? birthday;
  final String? knownForDepartment;
  final dynamic deathday;
  final int? id;
  final String? name;
  final List<String>? alsoKnownAs;
  final int? gender;
  final String? biography;
  final double? popularity;
  final String? placeOfBirth;
  final String? profilePath;
  final bool? adult;
  final String? imdbId;
  final dynamic homepage;

  factory Person.fromJson(Map<String, dynamic> json) => Person(
        birthday: DateTime.parse(json["birthday"]),
        knownForDepartment: json["known_for_department"],
        deathday: json["deathday"],
        id: json["id"],
        name: json["name"],
        alsoKnownAs: List<String>.from(json["also_known_as"].map((x) => x)),
        gender: json["gender"],
        biography: json["biography"],
        popularity: json["popularity"].toDouble(),
        placeOfBirth: json["place_of_birth"],
        profilePath: json["profile_path"],
        adult: json["adult"],
        imdbId: json["imdb_id"],
        homepage: json["homepage"],
      );
}
