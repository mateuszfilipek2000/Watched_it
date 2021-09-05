// To parse this JSON data, do
//
//     final movie = movieFromJson(jsonString);

import 'dart:convert';

import 'package:watched_it_getx/app/data/models/media_model.dart';

class MovieDetails extends Media {
  MovieDetails({
    required this.adult,
    required backdropPath,
    this.belongsToCollection,
    required this.budget,
    required genres,
    required homepage,
    required id,
    this.imdbId,
    required originalLanguage,
    required this.originalTitle,
    required overview,
    required popularity,
    required posterPath,
    required productionCompanies,
    required productionCountries,
    required this.releaseDate,
    required this.revenue,
    this.runtime,
    required spokenLanguages,
    required status,
    required tagline,
    required this.title,
    required this.video,
    required voteAverage,
    required voteCount,
  }) : super(
          voteAverage: voteAverage,
          homepage: homepage,
          originalLanguage: originalLanguage,
          backdropPath: backdropPath,
          voteCount: voteCount,
          popularity: popularity,
          productionCompanies: productionCompanies,
          genres: genres,
          productionCountries: productionCountries,
          status: status,
          posterPath: posterPath,
          spokenLanguages: spokenLanguages,
          id: id,
          overview: overview,
          tagline: tagline,
        );

  bool adult;
  dynamic belongsToCollection;
  int budget;
  String? imdbId;
  String originalTitle;
  DateTime releaseDate;
  int revenue;
  int? runtime;
  String title;
  bool video;

  factory MovieDetails.fromJson(Map<String, dynamic> json) => MovieDetails(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        belongsToCollection: json["belongs_to_collection"],
        budget: json["budget"],
        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
        homepage: json["homepage"],
        id: json["id"],
        imdbId: json["imdb_id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        productionCompanies: List<ProductionCompany>.from(
            json["production_companies"]
                .map((x) => ProductionCompany.fromJson(x))),
        productionCountries: List<ProductionCountry>.from(
            json["production_countries"]
                .map((x) => ProductionCountry.fromJson(x))),
        releaseDate: DateTime.parse(json["release_date"]),
        revenue: json["revenue"],
        runtime: json["runtime"],
        spokenLanguages: List<SpokenLanguage>.from(
            json["spoken_languages"].map((x) => SpokenLanguage.fromJson(x))),
        status: json["status"],
        tagline: json["tagline"],
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  String getDateString() =>
      "${releaseDate.year}-${releaseDate.month.addLeadingZeros(2)}-${releaseDate.day.addLeadingZeros(2)}";
}

extension leadingZeros on int {
  String addLeadingZeros(int numberOfTotalDigits) =>
      this.toString().padLeft(numberOfTotalDigits, '0');
}



// class ProductionCompany {
//   ProductionCompany({
//     this.id,
//     this.logoPath,
//     this.name,
//     this.originCountry,
//   });

//   int? id;
//   String? logoPath;
//   String? name;
//   String? originCountry;

//   factory ProductionCompany.fromJson(Map<String, dynamic> json) =>
//       ProductionCompany(
//         id: json["id"],
//         logoPath: json["logo_path"] == null ? null : json["logo_path"],
//         name: json["name"],
//         originCountry: json["origin_country"],
//       );
// }

// class ProductionCountry {
//   ProductionCountry({
//     this.iso31661,
//     this.name,
//   });

//   String? iso31661;
//   String? name;

//   factory ProductionCountry.fromJson(Map<String, dynamic> json) =>
//       ProductionCountry(
//         iso31661: json["iso_3166_1"],
//         name: json["name"],
//       );
// }

// class SpokenLanguage {
//   SpokenLanguage({
//     this.iso6391,
//     this.name,
//   });

//   String? iso6391;
//   String? name;

//   factory SpokenLanguage.fromJson(Map<String, dynamic> json) => SpokenLanguage(
//         iso6391: json["iso_639_1"],
//         name: json["name"],
//       );
// }

// class Genre {
//   Genre({
//     required this.id,
//     required this.name,
//   });
//   int id;
//   String name;

//   factory Genre.fromJson(Map<String, dynamic> json) => Genre(
//         id: json["id"],
//         name: json["name"],
//       );
// }
