class MovieImages {
  MovieImages({
    required this.id,
    required this.backdrops,
    required this.posters,
  });

  final int id;
  final List<MovieImage> backdrops;
  final List<MovieImage> posters;

  factory MovieImages.fromJson(Map<String, dynamic> json) => MovieImages(
        id: json["id"],
        backdrops: List<MovieImage>.from(
            json["backdrops"].map((x) => MovieImage.fromJson(x))),
        posters: List<MovieImage>.from(
            json["posters"].map((x) => MovieImage.fromJson(x))),
      );
}

class MovieImage {
  MovieImage({
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

  factory MovieImage.fromJson(Map<String, dynamic> json) => MovieImage(
        aspectRatio: json["aspect_ratio"].toDouble(),
        filePath: json["file_path"],
        height: json["height"],
        iso6391: json["iso_639_1"] == null ? null : json["iso_639_1"],
        voteAverage: json["vote_average"],
        voteCount: json["vote_count"],
        width: json["width"],
      );
}
