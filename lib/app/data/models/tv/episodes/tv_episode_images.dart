import 'package:watched_it_getx/app/data/models/image_model.dart';

class TvEpisodeImages {
  TvEpisodeImages({
    required this.id,
    required this.stills,
  });

  final int? id;
  final List<Still> stills;

  List<String> getStillsUrls() {
    List<String> results = [];
    for (Still still in stills) {
      results.add(
        ImageUrl.getStillImageUrl(
          url: still.filePath,
          size: StillSizes.w300,
        ),
      );
    }
    return results;
  }

  factory TvEpisodeImages.fromJson(Map<String, dynamic> json) =>
      TvEpisodeImages(
        id: json["id"],
        stills: List<Still>.from(json["stills"].map((x) => Still.fromJson(x))),
      );
}

class Still {
  Still({
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

  factory Still.fromJson(Map<String, dynamic> json) => Still(
        aspectRatio: json["aspect_ratio"].toDouble(),
        filePath: json["file_path"],
        height: json["height"],
        iso6391: json["iso_639_1"] == null ? null : json["iso_639_1"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
        width: json["width"],
      );
}
