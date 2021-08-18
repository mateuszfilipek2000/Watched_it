import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:watched_it_getx/app/data/enums/media_type.dart';
import 'package:watched_it_getx/app/data/models/account_states.dart';
import 'package:watched_it_getx/app/data/models/credits_model.dart';
import 'package:watched_it_getx/app/data/models/image_model.dart';
import 'package:watched_it_getx/app/data/models/keywords.dart';
import 'package:watched_it_getx/app/data/models/lists_model.dart';
import 'package:watched_it_getx/app/data/models/media_images.dart';
import 'package:watched_it_getx/app/data/models/minimal_media.dart';
import 'package:watched_it_getx/app/data/models/movie_model.dart';
import 'package:watched_it_getx/app/data/models/recommendations_model.dart';
import 'package:watched_it_getx/app/data/models/user_model.dart';
import 'package:watched_it_getx/app/data/models/videos.dart';
import 'package:watched_it_getx/app/data/services/tmdb_api_service.dart';
import 'package:watched_it_getx/app/modules/MediaDetail/controllers/media_detail_controller.dart';
import 'package:watched_it_getx/app/modules/MediaDetail/controllers/swipeable_image_view_f_controller.dart';
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
  late Rx<Videos?> videos = Rx<Videos?>(null);
  late String sessionID;
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  Rx<MediaImages?> images = Rx<MediaImages?>(null);

  Rx<SwipeableWidgetViewController?> swipeableController =
      Rx<SwipeableWidgetViewController?>(null);

  //widget sizes

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

    getAdditionalImages();

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
    return rating;
    //return rating.reversed.toList();
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

  void initializeVideos() async {
    videos.value = await TMDBApiService.getVideos(id: minimalMedia.value.id);
    if (videos.value != null) {}
  }

  void getAdditionalImages() async {
    images.value = await TMDBApiService.getMediaImages(
      mediaID: minimalMedia.value.id.toString(),
    );
    print(images.value?.backdrops.length);
    if (images.value?.backdrops != null) {
      List<Image> results = [];
      for (Backdrop backdrop in images.value?.backdrops as List<Backdrop>) {
        Image result = Image.network(
          ImageUrl.getBackdropImageUrl(
              url: backdrop.filePath, size: BackdropSizes.w780),
          key: UniqueKey(),
        );
        results.add(result);
      }
      if (results.length != 0) {
        swipeableController.value = SwipeableWidgetViewController(
          children: results,
        );
      }
    }
  }
}
