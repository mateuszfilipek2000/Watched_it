import 'package:watched_it_getx/app/data/enums/media_type.dart';

class PosterListviewObject {
  PosterListviewObject({
    required this.id,
    required this.title,
    required this.mediaType,
    this.subtitle,
    this.imagePath,
  });
  final int id;
  final String title;
  final String? subtitle;
  final String? imagePath;
  final MediaType mediaType;
}
