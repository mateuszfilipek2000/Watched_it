class TvSeasonAggregatedCredits {
  TvSeasonAggregatedCredits({
    required this.cast,
    required this.crew,
    required this.id,
  });

  final List<Cast> cast;
  final List<Crew> crew;
  final int? id;

  factory TvSeasonAggregatedCredits.fromJson(Map<String, dynamic> json) =>
      TvSeasonAggregatedCredits(
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromJson(x))),
        crew: List<Crew>.from(json["crew"].map((x) => Crew.fromJson(x))),
        id: json["id"],
      );
}

class Cast {
  Cast({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    this.profilePath,
    required this.roles,
    required this.totalEpisodeCount,
    this.order,
  });

  final bool adult;
  final int gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final List<Role> roles;
  final int totalEpisodeCount;
  final int? order;

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"].toDouble(),
        profilePath: json["profile_path"] == null ? null : json["profile_path"],
        roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
        totalEpisodeCount: json["total_episode_count"],
        order: json["order"] == null ? null : json["order"],
      );
}

class Crew {
  Crew({
    this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    this.profilePath,
    required this.totalEpisodeCount,
    this.order,
    required this.jobs,
    required this.department,
  });

  final bool? adult;
  final int gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final int totalEpisodeCount;
  final int? order;
  final List<Job> jobs;
  final String department;

  factory Crew.fromJson(Map<String, dynamic> json) => Crew(
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"].toDouble(),
        profilePath: json["profile_path"] == null ? null : json["profile_path"],
        totalEpisodeCount: json["total_episode_count"],
        order: json["order"] == null ? null : json["order"],
        jobs: List<Job>.from(json["jobs"].map((x) => Job.fromJson(x))),
        department: json["department"],
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
