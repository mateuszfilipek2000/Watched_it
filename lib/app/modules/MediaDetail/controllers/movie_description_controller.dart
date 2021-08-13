import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/enums/media_type.dart';
import 'package:watched_it_getx/app/data/models/account_states.dart';
import 'package:watched_it_getx/app/data/models/credits_model.dart';
import 'package:watched_it_getx/app/data/models/keywords.dart';
import 'package:watched_it_getx/app/data/models/lists_model.dart';
import 'package:watched_it_getx/app/data/models/minimal_media.dart';
import 'package:watched_it_getx/app/data/models/movie_model.dart';
import 'package:watched_it_getx/app/data/models/recommendations_model.dart';
import 'package:watched_it_getx/app/data/models/reviews.dart';
import 'package:watched_it_getx/app/data/models/user_model.dart';
import 'package:watched_it_getx/app/data/services/tmdb_api_service.dart';
import 'package:watched_it_getx/app/modules/MediaDetail/controllers/media_detail_controller.dart';
import 'package:watched_it_getx/app/modules/MediaDetail/widgets/fractionally_coloured_star.dart';
import 'package:watched_it_getx/app/modules/splash_screen/controllers/user_controller_controller.dart';

class MovieDescriptionController extends GetxController {
  late AppUser? user;
  Rx<MinimalMedia> minimalMedia =
      (Get.find<MediaDetailController>().minimalMedia.value as MinimalMedia)
          .obs;
  Rx<Movie?> movie = Rx<Movie?>(null);
  late Rx<AccountStates?> accountStates = Rx<AccountStates?>(null);
  Rx<Credits?> credits = Rx<Credits?>(null);
  late Rx<KeyWords> keywords;
  late Rx<Lists> lists;
  late Rx<Recommendations> recommendations;
  late Rx<Reviews> reviews;
  late String sessionID;
  //RxBool isFavourite = false.obs;

  @override
  void onInit() async {
    user = await TMDBApiService.getUserDetails(
      Get.find<UserController>().sessionID.value,
    );
    sessionID = await Get.find<UserController>().sessionID.value;
    movie.value = await TMDBApiService.getMovieDetails(minimalMedia.value.id);
    accountStates.value = await TMDBApiService.getAccountStates(
        sessionID: sessionID, movieID: minimalMedia.value.id);
    credits.value =
        await TMDBApiService.getCredits(movieID: minimalMedia.value.id);
    super.onInit();
  }

  List<FractionallyColouredStar> generateRating() {
    List<FractionallyColouredStar> rating = [];
    double mediaRating = (movie.value?.voteAverage as double) / 2;
    print(mediaRating);
    for (int i = 0; i < 5; i++) {
      if (mediaRating - 1.0 > 0) {
        mediaRating -= 1;
        rating.add(FractionallyColouredStar(fraction: 1));
      } else {
        rating.add(FractionallyColouredStar(fraction: mediaRating));
        mediaRating = 0;
      }
    }

    return rating.reversed.toList();
  }

  void addToFavourites() async {
    bool status = await TMDBApiService.markAsFavourite(
      accountID: user?.id as int,
      contentID: minimalMedia.value.id,
      mediaType: minimalMedia.value.mediaType,
      sessionID: sessionID,
      isFavourite: !(accountStates.value?.favourite as bool),
    );
    if (status == true) {
      accountStates.value = await TMDBApiService.getAccountStates(
        sessionID: sessionID,
        movieID: minimalMedia.value.id,
      );
    }
  }

  void addToWatchlist() async {
    bool status = await TMDBApiService.addToWatchlist(
      accountID: user?.id as int,
      contentID: minimalMedia.value.id,
      mediaType: minimalMedia.value.mediaType,
      sessionID: sessionID,
      add: !(accountStates.value?.watchlist as bool),
    );
    if (status == true) {
      accountStates.value = await TMDBApiService.getAccountStates(
        sessionID: sessionID,
        movieID: minimalMedia.value.id,
      );
    }
  }

  void updateAccountStates() {}

  List<MinimalMedia> minimalMediaFromCast() {
    List<MinimalMedia> results = [];

    for (Cast actor in credits.value?.cast as List<Cast>) {
      results.add(
        MinimalMedia(
          mediaType: MediaType.person,
          id: actor.id,
          title: actor.name,
          subtitle: actor.character,
          posterPath: actor.profilePath,
        ),
      );
    }
    return results;
  }

  List<MinimalMedia> minimalMediaFromCrew() {
    List<MinimalMedia> results = [];

    for (Crew actor in credits.value?.crew as List<Crew>) {
      results.add(
        MinimalMedia(
          mediaType: MediaType.person,
          id: actor.id,
          title: actor.name,
          subtitle: actor.department == null ? "" : actor.department,
          posterPath: actor.profilePath,
        ),
      );
    }
    return results;
  }
}
