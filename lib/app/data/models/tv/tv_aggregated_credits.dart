import 'package:watched_it_getx/app/data/enums/media_type.dart';
import 'package:watched_it_getx/app/data/models/minimal_media.dart';

class TvAggregatedCredits {
  TvAggregatedCredits({
    required this.cast,
    required this.crew,
    this.id,
  });

  final List<Cast> cast;
  final List<Cast> crew;
  final int? id;

  factory TvAggregatedCredits.fromJson(Map<String, dynamic> json) =>
      TvAggregatedCredits(
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromJson(x))),
        crew: List<Cast>.from(json["crew"].map((x) => Cast.fromJson(x))),
        id: json["id"],
      );

  List<MinimalMedia> minimalMediaFromCast() {
    List<MinimalMedia> results = [];

    for (Cast actor in cast) {
      results.add(
        MinimalMedia(
          mediaType: MediaType.person,
          id: actor.id,
          title: actor.name,
          subtitle: (actor.roles != null) && (actor.roles?.length != 0)
              ? actor.roles![0].character
              : actor.knownForDepartment,
          posterPath: actor.profilePath,
        ),
      );
    }
    return results;
  }

  List<MinimalMedia> minimalMediaFromCrew() {
    List<MinimalMedia> results = [];

    for (Cast actor in crew) {
      results.add(
        MinimalMedia(
          mediaType: MediaType.person,
          id: actor.id,
          title: actor.name,
          subtitle: (actor.jobs != null) && (actor.jobs?.length != 0)
              ? actor.jobs![0].job
              : actor.knownForDepartment,
          posterPath: actor.profilePath,
        ),
      );
    }
    return results;
  }
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
    required this.roles,
    required this.totalEpisodeCount,
    this.order,
    required this.jobs,
  });

  final bool adult;
  final int? gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final List<Role>? roles;
  final int totalEpisodeCount;
  final int? order;
  final List<Job>? jobs;

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"].toDouble(),
        profilePath: json["profile_path"] == null ? null : json["profile_path"],
        roles: json["roles"] == null
            ? null
            : List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
        totalEpisodeCount: json["total_episode_count"],
        order: json["order"] == null ? null : json["order"],
        jobs: json["jobs"] == null
            ? null
            : List<Job>.from(json["jobs"].map((x) => Job.fromJson(x))),
      );
}

class Job {
  Job({
    required this.creditId,
    required this.job,
    required this.episodeCount,
  });

  final String creditId;
  final String job;
  final int episodeCount;

  factory Job.fromJson(Map<String, dynamic> json) => Job(
        creditId: json["credit_id"],
        job: json["job"],
        episodeCount: json["episode_count"],
      );
}

class Role {
  Role({
    required this.creditId,
    required this.character,
    required this.episodeCount,
  });

  final String creditId;
  final String character;
  final int episodeCount;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        creditId: json["credit_id"],
        character: json["character"],
        episodeCount: json["episode_count"],
      );
}
