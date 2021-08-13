abstract class Media {
  final String? backdropPath;
  final List<Genre> genres;
  final String homepage;
  final int id;
  final String originalLanguage;
  final String overview;
  final double popularity;
  final String posterPath;
  final List<ProductionCompany> productionCompanies;
  final List<ProductionCountry> productionCountries;
  final List<SpokenLanguage> spokenLanguages;
  final String status;
  final String tagline;
  final double voteAverage;
  final int voteCount;

  Media({
    this.backdropPath,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.originalLanguage,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.voteAverage,
    required this.voteCount,
  });

  List<String> getGenresNames() {
    List<String> results = [];
    for (Genre genre in genres) results.add(genre.name);
    return results;
  }

  String genresCommaSeparated() => getGenresNames().join(", ");
}

class ProductionCompany {
  ProductionCompany({
    this.id,
    this.logoPath,
    this.name,
    this.originCountry,
  });

  int? id;
  String? logoPath;
  String? name;
  String? originCountry;

  factory ProductionCompany.fromJson(Map<String, dynamic> json) =>
      ProductionCompany(
        id: json["id"],
        logoPath: json["logo_path"] == null ? null : json["logo_path"],
        name: json["name"],
        originCountry: json["origin_country"],
      );
}

class ProductionCountry {
  ProductionCountry({
    this.iso31661,
    this.name,
  });

  String? iso31661;
  String? name;

  factory ProductionCountry.fromJson(Map<String, dynamic> json) =>
      ProductionCountry(
        iso31661: json["iso_3166_1"],
        name: json["name"],
      );
}

class SpokenLanguage {
  SpokenLanguage({
    this.iso6391,
    this.name,
  });

  String? iso6391;
  String? name;

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) => SpokenLanguage(
        iso6391: json["iso_639_1"],
        name: json["name"],
      );
}

class Genre {
  Genre({
    required this.id,
    required this.name,
  });
  int id;
  String name;

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
      );
}
