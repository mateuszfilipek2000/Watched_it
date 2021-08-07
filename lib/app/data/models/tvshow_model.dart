// To parse this JSON data, do
//
//     final tvShow = tvShowFromJson(jsonString);
import 'dart:convert';

import 'package:watched_it_getx/app/data/models/media_model.dart';

TvShow tvShowFromJson(String str) => TvShow.fromJson(json.decode(str));

class TvShow extends Media {
  TvShow({
    required backdropPath,
    this.createdBy,
    this.episodeRunTime,
    this.firstAirDate,
    required genres,
    required homepage,
    required id,
    this.inProduction,
    this.languages,
    this.lastAirDate,
    this.lastEpisodeToAir,
    this.name,
    this.nextEpisodeToAir,
    this.networks,
    this.numberOfEpisodes,
    this.numberOfSeasons,
    this.originCountry,
    required originalLanguage,
    this.originalName,
    required overview,
    required popularity,
    required posterPath,
    required productionCompanies,
    required productionCountries,
    this.seasons,
    required spokenLanguages,
    required status,
    required tagline,
    this.type,
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

  final List<CreatedBy>? createdBy;
  final List<int>? episodeRunTime;
  final DateTime? firstAirDate;
  final bool? inProduction;
  final List<String>? languages;
  final DateTime? lastAirDate;
  final LastEpisodeToAir? lastEpisodeToAir;
  final String? name;
  final dynamic nextEpisodeToAir;
  final List<Network>? networks;
  final int? numberOfEpisodes;
  final int? numberOfSeasons;
  final List<String>? originCountry;
  final String? originalName;
  final List<Season>? seasons;
  final String? type;

  factory TvShow.fromJson(Map<String, dynamic> json) => TvShow(
        backdropPath: json["backdrop_path"],
        createdBy: List<CreatedBy>.from(
            json["created_by"].map((x) => CreatedBy.fromJson(x))),
        episodeRunTime: List<int>.from(json["episode_run_time"].map((x) => x)),
        firstAirDate: DateTime.parse(json["first_air_date"]),
        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
        homepage: json["homepage"],
        id: json["id"],
        inProduction: json["in_production"],
        languages: List<String>.from(json["languages"].map((x) => x)),
        lastAirDate: DateTime.parse(json["last_air_date"]),
        lastEpisodeToAir:
            LastEpisodeToAir.fromJson(json["last_episode_to_air"]),
        name: json["name"],
        nextEpisodeToAir: json["next_episode_to_air"],
        networks: List<Network>.from(
            json["networks"].map((x) => Network.fromJson(x))),
        numberOfEpisodes: json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"],
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        productionCompanies: List<ProductionCompany>.from(
            json["production_companies"].map((x) => Network.fromJson(x))),
        productionCountries: List<ProductionCountry>.from(
            json["production_countries"]
                .map((x) => ProductionCountry.fromJson(x))),
        seasons:
            List<Season>.from(json["seasons"].map((x) => Season.fromJson(x))),
        spokenLanguages: List<SpokenLanguage>.from(
            json["spoken_languages"].map((x) => SpokenLanguage.fromJson(x))),
        status: json["status"],
        tagline: json["tagline"],
        type: json["type"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );
}

class CreatedBy {
  CreatedBy({
    this.id,
    this.creditId,
    this.name,
    this.gender,
    this.profilePath,
  });

  final int? id;
  final String? creditId;
  final String? name;
  final int? gender;
  final String? profilePath;

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
        id: json["id"],
        creditId: json["credit_id"],
        name: json["name"],
        gender: json["gender"],
        profilePath: json["profile_path"],
      );
}

// class Genre {
//   Genre({
//     this.id,
//     this.name,
//   });

//   final int? id;
//   final String? name;

//   factory Genre.fromJson(Map<String, dynamic> json) => Genre(
//         id: json["id"],
//         name: json["name"],
//       );
// }

class LastEpisodeToAir {
  LastEpisodeToAir({
    this.airDate,
    this.episodeNumber,
    this.id,
    this.name,
    this.overview,
    this.productionCode,
    this.seasonNumber,
    this.stillPath,
    this.voteAverage,
    this.voteCount,
  });

  final DateTime? airDate;
  final int? episodeNumber;
  final int? id;
  final String? name;
  final String? overview;
  final String? productionCode;
  final int? seasonNumber;
  final String? stillPath;
  final double? voteAverage;
  final int? voteCount;

  factory LastEpisodeToAir.fromJson(Map<String, dynamic> json) =>
      LastEpisodeToAir(
        airDate: DateTime.parse(json["air_date"]),
        episodeNumber: json["episode_number"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        productionCode: json["production_code"],
        seasonNumber: json["season_number"],
        stillPath: json["still_path"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );
}

class Network {
  Network({
    this.name,
    this.id,
    this.logoPath,
    this.originCountry,
  });

  final String? name;
  final int? id;
  final String? logoPath;
  final String? originCountry;

  factory Network.fromJson(Map<String, dynamic> json) => Network(
        name: json["name"],
        id: json["id"],
        logoPath: json["logo_path"] == null ? null : json["logo_path"],
        originCountry: json["origin_country"],
      );
}

// class ProductionCountry {
//   ProductionCountry({
//     this.iso31661,
//     this.name,
//   });

//   final String? iso31661;
//   final String? name;

//   factory ProductionCountry.fromJson(Map<String, dynamic> json) =>
//       ProductionCountry(
//         iso31661: json["iso_3166_1"],
//         name: json["name"],
//       );
// }

class Season {
  Season({
    this.airDate,
    this.episodeCount,
    this.id,
    this.name,
    this.overview,
    this.posterPath,
    this.seasonNumber,
  });

  final DateTime? airDate;
  final int? episodeCount;
  final int? id;
  final String? name;
  final String? overview;
  final String? posterPath;
  final int? seasonNumber;

  factory Season.fromJson(Map<String, dynamic> json) => Season(
        airDate: DateTime.parse(json["air_date"]),
        episodeCount: json["episode_count"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
      );
}

// class SpokenLanguage {
//   SpokenLanguage({
//     this.englishName,
//     this.iso6391,
//     this.name,
//   });

//   final String? englishName;
//   final String? iso6391;
//   final String? name;

//   factory SpokenLanguage.fromJson(Map<String, dynamic> json) => SpokenLanguage(
//         englishName: json["english_name"],
//         iso6391: json["iso_639_1"],
//         name: json["name"],
//       );
// }