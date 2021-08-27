import 'package:watched_it_getx/app/data/enums/media_type.dart';
import 'package:watched_it_getx/app/data/models/image_model.dart';
import 'package:watched_it_getx/app/shared_widgets/poster_listview/poster_listview_object.dart';

class TvEpisodeCredit {
  TvEpisodeCredit({
    required this.cast,
    required this.crew,
    required this.guestStars,
    required this.id,
  });

  final List<Cast> cast;
  final List<Crew> crew;
  final List<TvGuestStar> guestStars;
  final int? id;

  List<PosterListviewObject> getPosterListviewObjectsFromCast() =>
      cast.map((person) => person.getPosterListViewObject()).toList();

  List<PosterListviewObject> getPosterListviewObjectsFromCrew() =>
      crew.map((person) => person.getPosterListViewObject()).toList();

  List<PosterListviewObject> getPosterListviewObjectsFromGuestStars() =>
      guestStars.map((person) => person.getPosterListViewObject()).toList();

  factory TvEpisodeCredit.fromJson(Map<String, dynamic> json) =>
      TvEpisodeCredit(
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromJson(x))),
        crew: List<Crew>.from(json["crew"].map((x) => Crew.fromJson(x))),
        guestStars: List<TvGuestStar>.from(
            json["guest_stars"].map((x) => TvGuestStar.fromJson(x))),
        id: json["id"],
      );
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
    required this.character,
    required this.creditId,
    required this.order,
  });

  final bool adult;
  final int? gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final String character;
  final String creditId;
  final int order;

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"].toDouble(),
        profilePath: json["profile_path"] == null ? null : json["profile_path"],
        character: json["character"],
        creditId: json["credit_id"],
        order: json["order"],
      );

  PosterListviewObject getPosterListViewObject() => PosterListviewObject(
        id: id,
        mediaType: MediaType.person,
        title: name,
        subtitle: character,
        imagePath: profilePath == null || profilePath == ""
            ? null
            : ImageUrl.getProfileImageUrl(url: profilePath as String),
      );
}

class Crew {
  Crew({
    required this.adult,
    this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    this.profilePath,
    required this.creditId,
    required this.department,
    required this.job,
  });

  final bool adult;
  final int? gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final String creditId;
  final String department;
  final String job;

  factory Crew.fromJson(Map<String, dynamic> json) => Crew(
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"].toDouble(),
        profilePath: json["profile_path"] == null ? null : json["profile_path"],
        creditId: json["credit_id"],
        department: json["department"],
        job: json["job"],
      );
  PosterListviewObject getPosterListViewObject() => PosterListviewObject(
        id: id,
        mediaType: MediaType.person,
        title: name,
        subtitle: department,
        imagePath: profilePath == null || profilePath == ""
            ? null
            : ImageUrl.getProfileImageUrl(url: profilePath as String),
      );
}

class TvGuestStar {
  TvGuestStar({
    required this.adult,
    this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    this.profilePath,
    required this.creditId,
    this.order,
    required this.characterName,
  });

  final bool adult;
  final int? gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final String creditId;
  final int? order;
  final String? characterName;

  factory TvGuestStar.fromJson(Map<String, dynamic> json) => TvGuestStar(
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"].toDouble(),
        profilePath: json["profile_path"] == null ? null : json["profile_path"],
        creditId: json["credit_id"],
        order: json["order"] == null ? null : json["order"],
        characterName: json["character_name"],
      );

  PosterListviewObject getPosterListViewObject() => PosterListviewObject(
        id: id,
        mediaType: MediaType.person,
        title: name,
        subtitle: characterName,
        imagePath: profilePath == null || profilePath == ""
            ? null
            : ImageUrl.getProfileImageUrl(url: profilePath as String),
      );
}
