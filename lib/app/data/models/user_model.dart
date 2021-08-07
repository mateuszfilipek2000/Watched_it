import 'dart:convert';

AppUser userFromJson(String str) => AppUser.fromJson(json.decode(str));

class AppUser {
  AppUser({
    required this.avatar,
    required this.id,
    required this.iso6391,
    required this.iso31661,
    required this.name,
    required this.includeAdult,
    required this.username,
    required this.avatar_Path,
  });

  Avatar avatar;
  int id;
  String iso6391;
  String iso31661;
  String name;
  bool includeAdult;
  String username;
  String? avatar_Path;

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
        avatar: Avatar.fromJson(json["avatar"]),
        id: json["id"],
        iso6391: json["iso_639_1"],
        iso31661: json["iso_3166_1"],
        name: json["name"],
        includeAdult: json["include_adult"],
        username: json["username"],
        avatar_Path: json["avatar"]?["tmdb"]?["avatar_path"],
      );
}

class Avatar {
  Avatar({
    required this.gravatar,
  });

  Gravatar gravatar;

  factory Avatar.fromJson(Map<String, dynamic> json) => Avatar(
        gravatar: Gravatar.fromJson(json["gravatar"]),
      );
}

class Gravatar {
  Gravatar({
    required this.hash,
  });

  String hash;

  factory Gravatar.fromJson(Map<String, dynamic> json) => Gravatar(
        hash: json["hash"],
      );
}
