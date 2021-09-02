import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/models/minimal_media.dart';
import 'package:watched_it_getx/app/data/models/people/person_details.dart';
import 'package:watched_it_getx/app/data/models/people/person_images.dart';
import 'package:watched_it_getx/app/data/models/people/person_movie_credits.dart';
import 'package:watched_it_getx/app/data/models/people/person_tv_credits.dart';
import 'package:watched_it_getx/app/data/services/tmdb_api_service.dart';
import 'package:watched_it_getx/app/data/extensions/date_helpers.dart';

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
