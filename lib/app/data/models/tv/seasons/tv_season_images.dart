class TvSeasonImages {
  TvSeasonImages({
    required this.id,
    required this.posters,
  });

  final int id;
  final List<Poster> posters;

  factory TvSeasonImages.fromJson(Map<String, dynamic> json) => TvSeasonImages(
        id: json["id"],
        posters:
            List<Poster>.from(json["posters"].map((x) => Poster.fromJson(x))),
      );
}

class Poster {
  Poster({
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
  final String iso6391;
  final double voteAverage;
  final int voteCount;
  final int width;

  factory Poster.fromJson(Map<String, dynamic> json) => Poster(
        aspectRatio: json["aspect_ratio"].toDouble(),
        filePath: json["file_path"],
        height: json["height"],
        iso6391: json["iso_639_1"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
        width: json["width"],
      );
}
