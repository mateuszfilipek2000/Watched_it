import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
import 'package:watched_it_getx/app/modules/splash_screen/controllers/user_controller_controller.dart';

class TvDetailController extends GetxController {
  late AppUser? user;
  late String sessionID;
  Rx<MinimalMedia> minimalMedia = Rx<MinimalMedia>(Get.arguments);
  List<Tab> tabs = [
    Tab(
      text: "Overview",
    ),
    Tab(
      text: "Episodes",
    ),
    Tab(
      text: "More",
    ),
    Tab(
      text: "Reviews",
    ),
  ];
  List<Widget> pages = [
    Text("1"),
    Text("2"),
    Text("3"),
    Text("4"),
  ];

  TvDetails? tvShow = null;
  AccountStates? accountStates = null;
  TvAggregatedCredits? aggregatedCredits = null;
  KeyWords? keywords = null;
  Reviews? reviews = null;
  SimilarTvShows? similarTvShows = null;
  SimilarTvShows? recommendedTvShows = null;
  //WatchProviders? watchProviders;
  RxBool isReady = false.obs;

  MediaImages? images;

  @override
  void onInit() async {
    user = await TMDBApiService.getUserDetails(
      Get.find<UserController>().sessionID.value,
    );
    sessionID = await Get.find<UserController>().sessionID.value;

    print(sessionID);
    //TMDBApiService.getAggregatedTv(id: minimalMedia.value.id);

    retrieveData();

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
        this.accountStates = result["AccountStates"];
        print(i++);
      }
      if (result["AggregateCredits"] != null) {
        this.aggregatedCredits = result["AggregateCredits"];
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
}
