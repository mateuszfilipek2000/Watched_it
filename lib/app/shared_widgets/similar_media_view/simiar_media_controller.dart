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
import 'package:watched_it_getx/app/data/extensions/date_helpers.dart';

//TODO FIX STRING TYPE CAST ON NULL, SOME MEDIA DO NOT HAVE TITLES AND/OR RELEASE DATES
class SimilarMediaController extends GetxController
    with SingleGetTickerProviderMixin {
  SimilarMediaController({
    required this.tag,
    //required this.recommendations,
    //required this.similar,
    required this.data,
    required this.contentType,
    required this.accountID,
  });
  //key - sorting method, value - objects that belong to this sorting method
  final Map<String, List<SimilarMedia>> data;

  final int accountID;
  final String tag;
  //final List<SimilarMedia> recommendations;
  //final List<SimilarMedia> similar;
  final MediaType contentType;

  PageController carouselController = PageController(
    initialPage: 0,
    viewportFraction: 0.5,
  );

  RxInt currentPage = 1.obs;
  RxList<String?> results = RxList([]);
  RxInt currentCarouselItem = 0.obs;
  Rx<AccountStates?> accountStates = Rx<AccountStates?>(null);

  List<String> sortingOptions = [];
  RxInt selectedSortingOption = 0.obs;

  RxString title = "".obs;
  RxString releaseDate = "".obs;

  @override
  void onInit() {
    data.forEach((key, value) {
      sortingOptions.add(key);
    });
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
    for (SimilarMedia media in data[sortingOptions[selectedSortingOption.value]]
        as List<SimilarMedia>) {
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
    getAccountStates();
  }

  String getReleaseDate() {
    if (data[sortingOptions[selectedSortingOption.value]]![
                currentCarouselItem.value]
            .releaseDate ==
        null) {
      return "No release date available";
    } else
      return data[sortingOptions[selectedSortingOption.value]]![
              currentCarouselItem.value]
          .releaseDate!
          .getDashedDate();

    // if (selectedSortingOption.value == 0) {
    //   if (recommendations[currentCarouselItem.value].releaseDate == null)
    //     return "No release date available";
    //   else
    //     return recommendations[currentCarouselItem.value]
    //         .releaseDate!
    //         .getDashedDate();
    // } else {
    //   if (similar[currentCarouselItem.value].releaseDate == null)
    //     return "No release date available";
    //   else
    //     return similar[currentCarouselItem.value].releaseDate!.getDashedDate();
    // }
  }

  String getTitle() {
    return data[sortingOptions[selectedSortingOption.value]]![
            currentCarouselItem.value]
        .title;

    // if (selectedSortingOption.value == 0)
    //   return recommendations[currentCarouselItem.value].title;
    // else
    //   return similar[currentCarouselItem.value].title;
  }

  void handlePageChange(int index) async {
    currentCarouselItem.value = index;
    title.value = getTitle();
    releaseDate.value = getReleaseDate();
  }

  void changeFavourite() async {
    int contentID = data[sortingOptions[selectedSortingOption.value]]![
            currentCarouselItem.value]
        .id;

    // if (selectedSortingOption.value == 0)
    //   contentID = recommendations[currentCarouselItem.value].id;
    // else
    //   contentID = similar[currentCarouselItem.value].id;

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
    int contentID = data[sortingOptions[selectedSortingOption.value]]![
            currentCarouselItem.value]
        .id;

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
    int contentID = data[sortingOptions[selectedSortingOption.value]]![
            currentCarouselItem.value]
        .id;

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
    int contentID = data[sortingOptions[selectedSortingOption.value]]![
            currentCarouselItem.value]
        .id;
    String contentTitle = data[sortingOptions[selectedSortingOption.value]]![
            currentCarouselItem.value]
        .title;
    String? contentPosterPath =
        data[sortingOptions[selectedSortingOption.value]]![
                currentCarouselItem.value]
            .posterPath;

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
