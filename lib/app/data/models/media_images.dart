import 'dart:convert';

MediaImages mediaImagesFromJson(String str) =>
    MediaImages.fromJson(json.decode(str));

class MediaImages {
  MediaImages({
    required this.id,
    required this.backdrops,
    required this.posters,
  });

  final int id;
  final List<Backdrop> backdrops;
  final List<Backdrop> posters;

  factory MediaImages.fromJson(Map<String, dynamic> json) => MediaImages(
        id: json["id"],
        backdrops: List<Backdrop>.from(
            json["backdrops"].map((x) => Backdrop.fromJson(x))),
        posters: List<Backdrop>.from(
            json["posters"].map((x) => Backdrop.fromJson(x))),
      );
}

class Backdrop {
  Backdrop({
    required this.aspectRatio,
    required this.filePath,
    required this.height,
    this.iso6391,
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

  factory Backdrop.fromJson(Map<String, dynamic> json) => Backdrop(
        aspectRatio: json["aspect_ratio"].toDouble(),
        filePath: json["file_path"],
        height: json["height"],
        iso6391: json["iso_639_1"] == null ? null : json["iso_639_1"],
        voteAverage: json["vote_average"],
        voteCount: json["vote_count"],
        width: json["width"],
      );
}
