import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/enums/media_type.dart';
import 'package:watched_it_getx/app/data/models/account_states.dart';
import 'package:watched_it_getx/app/data/models/keywords.dart';
import 'package:watched_it_getx/app/data/models/media_images.dart';
import 'package:watched_it_getx/app/data/models/minimal_media.dart';
import 'package:watched_it_getx/app/data/models/reviews.dart';
import 'package:watched_it_getx/app/data/models/tv/tv_aggregated_credits.dart';
import 'package:watched_it_getx/app/data/models/tv/tv_details_model.dart';
import 'package:watched_it_getx/app/data/models/tv/tv_similar_shows.dart';
import 'package:watched_it_getx/app/data/models/user_model.dart';
import 'package:watched_it_getx/app/data/services/tmdb_api_service.dart';
import 'package:watched_it_getx/app/modules/MovieDetail/widgets/fractionally_coloured_star.dart';
import 'package:watched_it_getx/app/modules/splash_screen/controllers/user_controller_controller.dart';

class TvDetailController extends GetxController {
  late AppUser? user;
  late String sessionID;
  Rx<MinimalMedia> minimalMedia = Rx<MinimalMedia>(Get.arguments);

  TvDetails? tvShow = null;
  Rx<AccountStates?> accountStates = Rx<AccountStates?>(null);
  Rx<TvAggregatedCredits?> aggregatedCredits = Rx<TvAggregatedCredits?>(null);
  KeyWords? keywords = null;
  Reviews? reviews = null;
  SimilarTvShows? similarTvShows = null;
  SimilarTvShows? recommendedTvShows = null;
  //WatchProviders? watchProviders;

  RxBool isReady = false.obs;

  Rx<MediaImages?> images = Rx<MediaImages?>(null);

  @override
  void onInit() async {
    user = await TMDBApiService.getUserDetails(
      Get.find<UserController>().sessionID.value,
    );
    sessionID = await Get.find<UserController>().sessionID.value;
    retrieveData();
    images.value = await TMDBApiService.getMediaImages(
      mediaID: minimalMedia.value.id.toString(),
      mediaType: MediaType.tv,
    );
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void retrieveData() async {
    Map<String, dynamic>? result = await TMDBApiService.getAggregatedTv(
        id: this.minimalMedia.value.id, sessionID: this.sessionID);

    int i = 0;
    if (result != null) {
      if (result["Details"] != null) {
        this.tvShow = result["Details"];
        print(i++);
      }
      if (result["AccountStates"] != null) {
        this.accountStates.value = result["AccountStates"];
        print(i++);
      }
      if (result["AggregateCredits"] != null) {
        this.aggregatedCredits.value = result["AggregateCredits"];
        print(i++);
      }
      if (result["Keywords"] != null) {
        this.keywords = result["Keywords"];
        print(i++);
      }
      if (result["Reviews"] != null) {
        this.reviews = result["Reviews"];
        print(i++);
      }
      if (result["SimilarTvShows"] != null) {
        this.similarTvShows = result["SimilarTvShows"];
        print(i++);
      }
      if (result["Recommendations"] != null) {
        this.recommendedTvShows = result["Recommendations"];
        print(i++);
      }
      isReady.value = true;
    }
  }

  void addToFavourites() async {
    print("adding to fav");
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
        mediaID: minimalMedia.value.id,
        mediaType: minimalMedia.value.mediaType,
      );
    }
    print(status);
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
        mediaID: minimalMedia.value.id,
        mediaType: minimalMedia.value.mediaType,
      );
    }
  }

  List<FractionallyColouredStar> generateRating() {
    List<FractionallyColouredStar> rating = [];
    double mediaRating = (tvShow?.voteAverage as double) / 2;
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
}
