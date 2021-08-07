/*
this class contains the minimum information about media objects used across the application:
posterpath
media title
media description
*/
class MinimalMedia {
  final int id;
  String? posterPath;
  final String title;
  DateTime? date;
  String? backdropPath;

  MinimalMedia({
    required this.id,
    this.posterPath,
    required this.title,
    this.date,
    this.backdropPath,
  });
}
