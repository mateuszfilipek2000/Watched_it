import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/enums/media_type.dart';
import 'package:watched_it_getx/app/data/models/minimal_media.dart';
import 'package:watched_it_getx/app/data/models/user_model.dart';
import 'package:watched_it_getx/app/data/services/tmdb_api_service.dart';
import 'package:watched_it_getx/app/modules/MediaDetail/controllers/media_poster_view_controller.dart';
import 'package:watched_it_getx/app/modules/MediaDetail/views/movie_overview_view.dart';
import 'package:watched_it_getx/app/modules/MediaDetail/views/similar_movies_view.dart';
import 'package:watched_it_getx/app/modules/MediaDetail/views/media_review_view.dart';
import 'package:watched_it_getx/app/modules/splash_screen/controllers/user_controller_controller.dart';

class MediaDetailedController extends GetxController {
  late AppUser? user;
  late String sessionID;
  Rx<MinimalMedia> minimalMedia =
      (Get.find<MediaPosterViewController>().minimalMedia.value as MinimalMedia)
          .obs;
  RxList<Tab> tabs = RxList([]);
  RxList<Widget> pages = RxList([]);

  @override
  void onInit() async {
    user = await TMDBApiService.getUserDetails(
      Get.find<UserController>().sessionID.value,
    );
    sessionID = await Get.find<UserController>().sessionID.value;

    if (minimalMedia.value.mediaType == MediaType.movie) {
      tabs.value = [
        Tab(
          text: "Overview",
        ),
        Tab(
          text: "Overview",
        ),
        Tab(
          text: "Similar",
        ),
        Tab(
          text: "Reviews",
        ),
      ];
      pages.value = [
        MovieOverviewView(),
        Text("2"),
        SimilarMoviesView(),
        MediaReviewView(),
      ];
    } else if (minimalMedia.value.mediaType == MediaType.person) {
      tabs.value = [
        Tab(
          text: "Overview",
        ),
        Tab(
          text: "Overview",
        ),
        Tab(
          text: "Similar",
        ),
        Tab(
          text: "Reviews",
        ),
      ];
      pages.value = [
        Text("1"),
        Text("2"),
        Text("3"),
        Text("4"),
      ];
    } else {
      tabs.value = [
        Tab(
          text: "Overview",
        ),
        Tab(
          text: "Overview",
        ),
        Tab(
          text: "Similar",
        ),
        Tab(
          text: "Reviews",
        ),
      ];
      pages.value = [
        Text("1"),
        Text("2"),
        Text("3"),
        Text("4"),
      ];
    }

    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  //TODO CHECK IF ACCOUNT STATES ARE THE SAME FOR EVERY MEDIA, IF THEY ARE THE SAME/SIMILAR ENOUGH THEN MOVE ACCOUNT STATES VARIABLE AND THE WHOLE LOGIC TO THIS CONTROLLER
  // void openMediaRatingDialog() {
  //   Get.defaultDialog(
  //     title: "How'd you rate: ${minimalMedia.value.title}?",
  //     content: Obx(
  //       () => Column(
  //         children: [
  //           Slider.adaptive(
  //             min: 0.0,
  //             max: 10.0,
  //             divisions: 20,
  //             label: userMediaRating.value.toString(),
  //             onChanged: (newRating) => userMediaRating.value = newRating,
  //             value: userMediaRating.value,
  //           ),
  //           Padding(
  //             padding: EdgeInsets.all(5),
  //             child: Center(
  //               child: Text(
  //                 "Your rating: ${userMediaRating.value.toString()}",
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //     onConfirm: () {
  //       print("yeah!");
  //       rate();
  //       Get.back();
  //     },
  //     onCancel: () {},
  //   );
  // }

  // void rate() async {
  //   bool result = await TMDBApiService.rateMedia(
  //     id: minimalMedia.value.id,
  //     rating: userMediaRating.value,
  //     mediaType: minimalMedia.value.mediaType,
  //     mediaName: minimalMedia.value.title,
  //     sessionID: sessionID,
  //   );
  //   if (result) getAccountStates();
  // }
}
