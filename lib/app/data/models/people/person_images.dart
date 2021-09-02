class PersonImages {
  PersonImages({
    required this.id,
    required this.profiles,
  });

  final int? id;
  final List<Profile> profiles;

  factory PersonImages.fromJson(Map<String, dynamic> json) => PersonImages(
        id: json["id"],
        profiles: List<Profile>.from(
            json["profiles"].map((x) => Profile.fromJson(x))),
      );
}

class Profile {
  Profile({
    required this.aspectRatio,
    required this.filePath,
    required this.height,
    required this.iso6391,
    required this.voteAverage,
    required this.voteCount,
    required this.width,
  });

  final double aspectRatio;
  final String filePath;
  final int height;
  final String? iso6391;
  final double voteAverage;
  final int voteCount;
  final int width;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        aspectRatio: json["aspect_ratio"].toDouble(),
        filePath: json["file_path"],
        height: json["height"],
        iso6391: json["iso_639_1"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
        width: json["width"],
      );
}
