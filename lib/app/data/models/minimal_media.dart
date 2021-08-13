/*
this class contains the minimum information about media objects used across the application:
posterpath
media title
media description
*/
import 'package:watched_it_getx/app/data/enums/media_type.dart';

/*
Minimal Media class provides enough properties about media types (
  movie,
  tv,
  person,
)
to create various widgets across the app without calling the api to get
details about media
*/

// class MinimalMovie extends MinimalMedia {
//   MinimalMovie({
//     required id,
//     required title,
//     required subtitle,
//     imagePath,
//     this.backdropPath,
//   }) : super(
//           title: title,
//           id: id,
//           subtitle: subtitle,
//           imagePath: imagePath,
//         );

//   final String? backdropPath;
// }

class MinimalMedia {
  // MinimalMedia({
  //   required this.id,
  //   required this.title,
  //   required this.subtitle,
  //   this.imagePath,
  // });

  // final int id;
  // final String title;
  // final String subtitle;
  // final MediaType mediaType;

  // String? imagePath;

  final int id;
  String? posterPath;
  final String title;
  String? subtitle;
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
    this.subtitle,
  });

  String getDateString() => this.date == null
      ? "No date available"
      : "${date?.year}-${date?.month.addLeadingZeros(2)}-${date?.day.addLeadingZeros(2)}";
}

extension leadingZeros on int {
  String addLeadingZeros(int numberOfTotalDigits) =>
      this.toString().padLeft(numberOfTotalDigits, '0');
}
