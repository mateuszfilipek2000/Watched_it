/*
this class contains the minimum information about media objects used across the application:
posterpath
media title
media description
*/
import 'package:watched_it_getx/app/data/enums/media_type.dart';

class MinimalMedia {
  final int id;
  String? posterPath;
  final String title;
  DateTime? date;
  String? backdropPath;
  MediaType mediaType;

  MinimalMedia({
    required this.mediaType,
    required this.id,
    required this.title,
    this.posterPath,
    this.date,
    this.backdropPath,
  });

  String getDateString() => this.date == null
      ? "No date available"
      : "${date?.year}-${date?.month.addLeadingZeros(2)}-${date?.day.addLeadingZeros(2)}";
}

extension leadingZeros on int {
  String addLeadingZeros(int numberOfTotalDigits) =>
      this.toString().padLeft(numberOfTotalDigits, '0');
}
