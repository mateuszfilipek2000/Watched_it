import 'package:watched_it_getx/app/data/enums/media_type.dart';
import 'package:watched_it_getx/app/data/models/minimal_media.dart';

class MovieCredits {
  MovieCredits({
    required this.id,
    required this.cast,
    required this.crew,
  });

  factory MovieCredits.fromJson(Map<String, dynamic> json) => MovieCredits(
        id: json["id"],
        cast: List<Cast>.from(json["cast"].map((i) => Cast.fromJson(i))),
        crew: List<Crew>.from(json["crew"].map((i) => Crew.fromJson(i))),
      );

  final int? id;
  final List<Cast> cast;
  final List<Crew> crew;
}

class Cast {
  Cast({
    required this.adult,
    this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    this.profilePath,
    required this.castID,
    required this.character,
    required this.creditID,
    required this.order,
  });

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"],
        profilePath: json["profile_path"],
        creditID: json["credit_id"],
        castID: json["cast_id"],
        character: json["character"],
        order: json["order"],
      );

  final bool adult;
  final int? gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final int castID;
  final String character;
  final String creditID;
  final int order;
}

class Crew {
  Crew({
    this.department,
    required this.adult,
    this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    this.profilePath,
    required this.creditID,
    this.job,
  });

  factory Crew.fromJson(Map<String, dynamic> json) => Crew(
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"],
        profilePath: json["profile_path"],
        creditID: json["credit_id"],
        department: json["department"],
        job: json["job"],
      );

  final bool adult;
  final int? gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final String? department;
  final String creditID;
  final String? job;
}
