import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/enums/media_type.dart';
import 'package:watched_it_getx/app/data/models/account_states.dart';
import 'package:watched_it_getx/app/data/models/image_model.dart';
import 'package:watched_it_getx/app/data/models/minimal_media.dart';
import 'package:watched_it_getx/app/data/models/similar_media.dart';
import 'package:watched_it_getx/app/data/services/tmdb_api_service.dart';
import 'package:watched_it_getx/app/modules/splash_screen/controllers/user_controller_controller.dart';

//TODO FIX STRING TYPE CAST ON NULL, SOME MEDIA DO NOT HAVE TITLES AND/OR RELEASE DATES
class SimilarMediaController extends GetxController
    with SingleGetTickerProviderMixin {
  SimilarMediaController({
    required this.tag,
    required this.recommendations,
    required this.similar,
    required this.contentType,
    required this.accountID,
  });
  final int accountID;
  final String tag;
  final List<SimilarMedia> recommendations;
  final List<SimilarMedia> similar;
  final MediaType contentType;

  PageController carouselController = PageController(
    initialPage: 0,
    viewportFraction: 0.5,
  );

  RxInt currentPage = 1.obs;
  RxList<String?> results = RxList([]);
  RxInt currentCarouselItem = 0.obs;
  Rx<AccountStates?> accountStates = Rx<AccountStates?>(null);

  List<String> sortingOption = ["Recommended", "Similar"];
  RxInt selectedSortingOption = 0.obs;

  RxString title = "".obs;
  RxString releaseDate = "".obs;

  @override
  void onInit() {
    title.value = getTitle();
    releaseDate.value = getReleaseDate();
    getPosterUrls();

    super.onInit();
  }

  @override
  void onClose() {
    //print("closing similar movies");
    carouselController.dispose();
    super.onClose();
  }

  void getPosterUrls() async {
    if (selectedSortingOption.value == 0) {
      for (SimilarMedia media in recommendations) {
        if (media.posterPath == null) {
          results.add(null);
        } else {
          results.add(
            ImageUrl.getPosterImageUrl(
              url: media.posterPath as String,
              size: PosterSizes.w342,
            ),
          );
        }
      }
    } else {
      for (SimilarMedia media in similar) {
        if (media.posterPath == null) {
          results.add(null);
        } else {
          results.add(
            ImageUrl.getPosterImageUrl(
              url: media.posterPath as String,
              size: PosterSizes.w342,
            ),
          );
        }
      }
    }
    getAccountStates();
  }

  String getReleaseDate() {
    if (selectedSortingOption.value == 0)
      return recommendations[currentCarouselItem.value].getDashedDate();
    else
      return similar[currentCarouselItem.value].getDashedDate();
  }

  String getTitle() {
    if (selectedSortingOption.value == 0)
      return recommendations[currentCarouselItem.value].title;
    else
      return similar[currentCarouselItem.value].title;
  }

  void handlePageChange(int index) async {
    currentCarouselItem.value = index;
    title.value = getTitle();
    releaseDate.value = getReleaseDate();
  }

  void changeFavourite() async {
    late int contentID;
    if (selectedSortingOption.value == 0)
      contentID = recommendations[currentCarouselItem.value].id;
    else
      contentID = similar[currentCarouselItem.value].id;

    bool status = await TMDBApiService.markAsFavourite(
      accountID: accountID,
      contentID: contentID,
      mediaType: contentType,
      sessionID: Get.find<UserController>().sessionID.value,
    );
    if (status == true) {
      getAccountStates();
    }
  }

  void changeWatchlist() async {
    late int contentID;
    if (selectedSortingOption.value == 0)
      contentID = recommendations[currentCarouselItem.value].id;
    else
      contentID = similar[currentCarouselItem.value].id;
    bool status = await TMDBApiService.addToWatchlist(
      accountID: accountID,
      contentID: contentID,
      mediaType: contentType,
      sessionID: Get.find<UserController>().sessionID.value,
    );
    if (status == true) {
      getAccountStates();
    }
  }

  void getAccountStates() async {
    late int contentID;
    if (selectedSortingOption.value == 0)
      contentID = recommendations[currentCarouselItem.value].id;
    else
      contentID = similar[currentCarouselItem.value].id;

    accountStates.value = await TMDBApiService.getAccountStates(
      sessionID: Get.find<UserController>().sessionID.value,
      mediaID: contentID,
      mediaType: contentType,
    );
  }

  void changeSortingOption(int i) async {
    if (i != selectedSortingOption.value) {
      selectedSortingOption.value = i;
      results.clear();
      //currentCarouselItem.value = 0;
      handlePageChange(0);
      carouselController.animateToPage(
        0,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
      getPosterUrls();
    }
  }

  void getToMediaDetailPage(int index) {
    late int contentID;
    late String contentTitle;
    late String? contentPosterPath;

    if (selectedSortingOption.value == 0) {
      contentID = recommendations[currentCarouselItem.value].id;
      contentTitle = recommendations[currentCarouselItem.value].title;
      contentPosterPath = recommendations[currentCarouselItem.value].posterPath;
    } else {
      contentID = similar[currentCarouselItem.value].id;
      contentTitle = similar[currentCarouselItem.value].title;
      contentPosterPath = similar[currentCarouselItem.value].posterPath;
    }
    Get.toNamed(
      "/MediaDetails/${describeEnum(contentType)}",
      preventDuplicates: false,
      arguments: MinimalMedia(
        id: contentID,
        mediaType: contentType,
        title: contentTitle,
        posterPath: contentPosterPath,
      ),
    );
  }
}

// extension leadingZeros on int {
//   String addLeadingZeros(int numberOfTotalDigits) =>
//       this.toString().padLeft(numberOfTotalDigits, '0');
// }

extension dashedDate on DateTime {
  String getDashedDate() =>
      "${this.year}-${this.month.addLeadingZeros(2)}-${this.day.addLeadingZeros(2)}";
}
