import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/enums/media_type.dart';
import 'package:watched_it_getx/app/data/models/account_states.dart';
import 'package:watched_it_getx/app/data/models/credits_model.dart';
import 'package:watched_it_getx/app/data/models/image_model.dart';
import 'package:watched_it_getx/app/data/models/keywords.dart';
import 'package:watched_it_getx/app/data/models/media_images.dart';
import 'package:watched_it_getx/app/data/models/minimal_media.dart';
import 'package:watched_it_getx/app/data/models/movie_model.dart';
import 'package:watched_it_getx/app/data/models/user_model.dart';
import 'package:watched_it_getx/app/data/models/videos.dart';
import 'package:watched_it_getx/app/data/services/tmdb_api_service.dart';
import 'package:watched_it_getx/app/modules/MovieDetail/controllers/movie_detail_controller.dart';
import 'package:watched_it_getx/app/modules/MovieDetail/widgets/fractionally_coloured_star.dart';

class MovieOverviewController extends GetxController {
  MovieOverviewController({required this.tag});
  String tag;

  late AppUser user;
  late Rx<MinimalMedia> minimalMedia;
  late String sessionID;

  Rx<Movie?> movie = Rx<Movie?>(null);
  Rx<AccountStates?> accountStates = Rx<AccountStates?>(null);
  Rx<Credits?> credits = Rx<Credits?>(null);
  Rx<KeyWords?> keywords = Rx<KeyWords?>(null);
  Rx<Videos?> videos = Rx<Videos?>(null);

  Rx<MediaImages?> images = Rx<MediaImages?>(null);
  RxBool isFabActive = false.obs;
  RxDouble userMediaRating = 0.0.obs;

  // Rx<SwipeableWidgetViewController?> swipeableController =
  //     Rx<SwipeableWidgetViewController?>(null);

  @override
  void onInit() async {
    minimalMedia = Get.find<MovieDetailController>(tag: tag).minimalMedia;
    user = Get.find<MovieDetailController>(tag: tag).user as AppUser;
    sessionID = Get.find<MovieDetailController>(tag: tag).sessionID;

    movie.value = await TMDBApiService.getMovieDetails(minimalMedia.value.id);
    getAccountStates();
    credits.value =
        await TMDBApiService.getCredits(movieID: minimalMedia.value.id);

    getAdditionalImages();

    keywords.value =
        await TMDBApiService.getKeywords(id: minimalMedia.value.id);
    super.onInit();
  }

  void getAccountStates() async {
    accountStates.value = await TMDBApiService.getAccountStates(
        sessionID: sessionID, movieID: minimalMedia.value.id);

    if (accountStates.value != null) {
      if (accountStates.value?.rated != null) {
        userMediaRating.value = accountStates.value?.rated as double;
        print("aaaaa ${accountStates.value?.rated as double}");
      }
    }
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
    return rating;
    //return rating.reversed.toList();
  }

  void addToFavourites() async {
    bool status = await TMDBApiService.markAsFavourite(
      accountID: user.id,
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
      accountID: user.id,
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

  void initializeVideos() async {
    videos.value = await TMDBApiService.getVideos(id: minimalMedia.value.id);
    if (videos.value != null) {}
  }

  void getAdditionalImages() async {
    images.value = await TMDBApiService.getMediaImages(
      mediaID: minimalMedia.value.id.toString(),
    );
    //print(images.value?.backdrops.length);
  }

  List<Image> getBackdropImages() {
    List<Image> results = [];
    for (Backdrop backdrop in images.value?.backdrops as List<Backdrop>) {
      Image result = Image.network(
        ImageUrl.getBackdropImageUrl(
            url: backdrop.filePath, size: BackdropSizes.w780),
        key: UniqueKey(),
      );
      results.add(result);
    }
    return results;
  }
}
