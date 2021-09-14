import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/enums/media_type.dart';
import 'package:watched_it_getx/app/data/models/image_model.dart';
import 'package:watched_it_getx/app/data/models/minimal_media.dart';
import 'package:watched_it_getx/app/data/models/people/person_details.dart';
import 'package:watched_it_getx/app/data/models/people/person_images.dart';
import 'package:watched_it_getx/app/data/models/people/person_movie_credits.dart';
import 'package:watched_it_getx/app/data/models/people/person_tv_credits.dart';
import 'package:watched_it_getx/app/data/services/tmdb_api_service.dart';
import 'package:watched_it_getx/app/data/extensions/date_helpers.dart';
import 'package:watched_it_getx/app/shared_widgets/poster_listview/poster_listview_object.dart';

class PersonDetailController extends GetxController {
  late PersonDetails personDetails;
  late PersonImages personImages;
  late PersonMovieCredits personMovieCredits;
  late PersonTvCredits personTvCredits;

  int amountOfProfiles = 0;
  int amountOfBackdrops = 0;

  RxBool isReady = false.obs;

  MinimalMedia person = Get.arguments;

  @override
  void onInit() {
    preparePersonScreen();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void preparePersonScreen() async {
    print("preparing person screen");
    Map<String, dynamic>? results =
        await TMDBApiService.getAggregatedPerson(id: person.id);

    if (results != null) {
      personDetails = results["PersonDetails"];
      personImages = results["PersonImages"];
      personMovieCredits = results["PersonMovieCredits"];
      personTvCredits = results["PersonTvCredits"];

      amountOfProfiles = personImages.profiles.length;

      isReady.value = true;
    }
  }

  int? getAge() {
    if (personDetails.birthday != null) {
      DateTime present = personDetails.deathday != null
          ? personDetails.deathday!
          : DateTime.now();
      int yearDifference = present.year - personDetails.birthday!.year;

      if (present.month < personDetails.birthday!.month)
        yearDifference -= 1;
      else if (personDetails.birthday!.month == present.month) if (present.day <
          personDetails.birthday!.day) yearDifference -= 1;
      return yearDifference;
    }
  }

  Map<String, List<PosterListviewObject>> getCreditsData() {
    Map<String, List<PosterListviewObject>> results = {};

    if (personMovieCredits.cast.length != 0) {
      results["Movies"] = personMovieCredits.cast
          .map(
            (e) => PosterListviewObject(
              id: e.id,
              title: e.title,
              subtitle: e.character,
              mediaType: MediaType.movie,
              imagePath: e.posterPath == null
                  ? null
                  : ImageUrl.getPosterImageUrl(
                      url: e.posterPath!,
                      size: PosterSizes.w342,
                    ),
            ),
          )
          .toList();
    }
    if (personMovieCredits.crew.length != 0) {
      if (results["Movies"] != null)
        results["Movies"] = results["Movies"]! +
            personMovieCredits.crew
                .map(
                  (e) => PosterListviewObject(
                    id: e.id,
                    title: e.title,
                    subtitle: e.job,
                    mediaType: MediaType.movie,
                    imagePath: e.posterPath == null
                        ? null
                        : ImageUrl.getPosterImageUrl(
                            url: e.posterPath!,
                            size: PosterSizes.w342,
                          ),
                  ),
                )
                .toList();
      else {
        results["Movies"] = personMovieCredits.crew
            .map(
              (e) => PosterListviewObject(
                id: e.id,
                title: e.title,
                subtitle: e.job,
                mediaType: MediaType.movie,
                imagePath: e.posterPath == null
                    ? null
                    : ImageUrl.getPosterImageUrl(
                        url: e.posterPath!,
                        size: PosterSizes.w342,
                      ),
              ),
            )
            .toList();
      }
    }

    if (personTvCredits.cast.length != 0) {
      results["Tv Shows"] = personTvCredits.cast
          .map(
            (e) => PosterListviewObject(
              id: e.id,
              title: e.name,
              subtitle: e.character,
              mediaType: MediaType.tv,
              imagePath: e.posterPath == null
                  ? null
                  : ImageUrl.getPosterImageUrl(
                      url: e.posterPath!,
                      size: PosterSizes.w342,
                    ),
            ),
          )
          .toList();
    }
    if (personTvCredits.crew.length != 0) {
      if (results["Tv Shows"] != null)
        results["Tv Shows"] = results["Tv Shows"]! +
            personTvCredits.crew
                .map(
                  (e) => PosterListviewObject(
                    id: e.id,
                    title: e.name,
                    subtitle: e.job,
                    mediaType: MediaType.tv,
                    imagePath: e.posterPath == null
                        ? null
                        : ImageUrl.getPosterImageUrl(
                            url: e.posterPath!,
                            size: PosterSizes.w342,
                          ),
                  ),
                )
                .toList();
      else {
        results["Tv Shows"] = personTvCredits.crew
            .map(
              (e) => PosterListviewObject(
                id: e.id,
                title: e.name,
                subtitle: e.job,
                mediaType: MediaType.tv,
                imagePath: e.posterPath == null
                    ? null
                    : ImageUrl.getPosterImageUrl(
                        url: e.posterPath!,
                        size: PosterSizes.w342,
                      ),
              ),
            )
            .toList();
      }
    }
    return results;

    // return {
    //   "Movies": personMovieCredits.cast
    //           .map(
    //             (e) => PosterListviewObject(
    //               id: e.id,
    //               title: e.title,
    //               subtitle: e.character,
    //               mediaType: MediaType.movie,
    //               imagePath: e.posterPath == null
    //                   ? null
    //                   : ImageUrl.getPosterImageUrl(
    //                       url: e.posterPath!,
    //                       size: PosterSizes.w342,
    //                     ),
    //             ),
    //           )
    //           .toList() +
    //       personMovieCredits.crew
    //           .map(
    //             (e) => PosterListviewObject(
    //               id: e.id,
    //               title: e.title,
    //               subtitle: e.job,
    //               mediaType: MediaType.movie,
    //               imagePath: e.posterPath == null
    //                   ? null
    //                   : ImageUrl.getPosterImageUrl(
    //                       url: e.posterPath!,
    //                       size: PosterSizes.w342,
    //                     ),
    //             ),
    //           )
    //           .toList(),
    //   "Tv Shows": personTvCredits.cast
    //           .map(
    //             (e) => PosterListviewObject(
    //               id: e.id,
    //               title: e.name,
    //               subtitle: e.character,
    //               mediaType: MediaType.tv,
    //               imagePath: e.posterPath == null
    //                   ? null
    //                   : ImageUrl.getPosterImageUrl(
    //                       url: e.posterPath!,
    //                       size: PosterSizes.w342,
    //                     ),
    //             ),
    //           )
    //           .toList() +
    //       personTvCredits.crew
    //           .map(
    //             (e) => PosterListviewObject(
    //               id: e.id,
    //               title: e.name,
    //               subtitle: e.job,
    //               mediaType: MediaType.tv,
    //               imagePath: e.posterPath == null
    //                   ? null
    //                   : ImageUrl.getPosterImageUrl(
    //                       url: e.posterPath!,
    //                       size: PosterSizes.w342,
    //                     ),
    //             ),
    //           )
    //           .toList(),
    // };
  }

  String? getBirthday() => personDetails.birthday == null
      ? null
      : personDetails.birthday!.getDashedDate();

  String getBirthPlace() => personDetails.placeOfBirth == null
      ? ""
      : ", ${personDetails.placeOfBirth}";

  String? getDeathDay() => personDetails.deathday == null
      ? null
      : personDetails.deathday!.getDashedDate();
}
