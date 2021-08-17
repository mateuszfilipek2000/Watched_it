class Reviews {
  Reviews({
    required this.id,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory Reviews.fromJson(Map<String, dynamic> json) => Reviews(
        id: json["id"],
        page: json["page"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  final int id;
  final int page;
  final List<Result> results;
  final int totalPages;
  final int totalResults;
}

class Result {
  Result({
    required this.author,
    required this.authorDetails,
    required this.content,
    required this.createdAt,
    required this.id,
    required this.updatedAt,
    required this.url,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        author: json["author"],
        authorDetails: AuthorDetails.fromJson(json["author_details"]),
        content: json["content"],
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
        updatedAt: DateTime.parse(json["updated_at"]),
        url: json["url"],
      );

  final String author;
  final AuthorDetails authorDetails;
  final String content;
  final DateTime createdAt;
  final String id;
  final DateTime updatedAt;
  final String url;
}

class AuthorDetails {
  AuthorDetails({
    required this.name,
    required this.username,
    required this.avatarPath,
    required this.rating,
  });

  factory AuthorDetails.fromJson(Map<String, dynamic> json) => AuthorDetails(
        name: json["name"],
        username: json["username"],
        avatarPath: json["avatar_path"] == null ? null : json["avatar_path"],
        rating: json["rating"] == null ? null : json["rating"],
      );

  final String name;
  final String username;
  final String? avatarPath;
  final double? rating;
}
