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
import 'package:watched_it_getx/app/shared_widgets/poster_listview/poster_listview_object.dart';

class SimilarMediaController extends GetxController
    with SingleGetTickerProviderMixin {
  SimilarMediaController({
    required this.tag,
    required this.data,
    required this.contentType,
    required this.accountID,
  })  : assert(contentType.length > 0),
        selectedContentType = contentType[0];
  //key - sorting method, value - objects that belong to this sorting method
  final Map<String, List<PosterListviewObject>> data;

  final int accountID;
  final String tag;
  late MediaType selectedContentType;
  final List<MediaType> contentType;

  RxBool viewAsList = false.obs;

  PageController carouselController = PageController(
    initialPage: 0,
    viewportFraction: 0.5,
  );

  RxInt currentPage = 1.obs;
  RxList<String?> results = RxList([]);
  RxInt currentCarouselItem = 0.obs;
  //Rx<AccountStates?> accountStates = Rx<AccountStates?>(null);

  RxMap<int, AccountStates?> _accountStates = RxMap<int, AccountStates?>({});

  List<String> sortingOptions = [];
  RxInt selectedSortingOption = 0.obs;

  RxString title = "".obs;
  RxString subtitle = "".obs;

  @override
  void onInit() {
    data.forEach((key, value) {
      sortingOptions.add(key);
    });
    // title.value = getTitle();
    // releaseDate.value = getReleaseDate();
    handlePageChange(0);
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
    for (PosterListviewObject media
        in data[sortingOptions[selectedSortingOption.value]]
            as List<PosterListviewObject>) {
      if (media.imagePath == null) {
        results.add(null);
      } else {
        results.add(
          media.imagePath,
        );
      }
    }
    //getAccountStates();
  }

  String getSubtitle() {
    // if (data[sortingOptions[selectedSortingOption.value]]![
    //             currentCarouselItem.value]
    //         .releaseDate ==
    //     null) {
    //   return "No release date available";
    // } else
    //   return data[sortingOptions[selectedSortingOption.value]]![
    //           currentCarouselItem.value]
    //       .releaseDate!
    //       .getDashedDate();
    if (data[sortingOptions[selectedSortingOption.value]]![
                currentCarouselItem.value]
            .subtitle ==
        null) {
      return "";
    } else
      return data[sortingOptions[selectedSortingOption.value]]![
              currentCarouselItem.value]
          .subtitle!;
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
    subtitle.value = getSubtitle();
    getAccountStates();
  }

  void changeFavourite({int? index}) async {
    late int contentID;
    if (index != null) {
      contentID = data[sortingOptions[selectedSortingOption.value]]![index].id;
    } else {
      contentID = data[sortingOptions[selectedSortingOption.value]]![
              currentCarouselItem.value]
          .id;
    }

    // if (selectedSortingOption.value == 0)
    //   contentID = recommendations[currentCarouselItem.value].id;
    // else
    //   contentID = similar[currentCarouselItem.value].id;

    bool status = await TMDBApiService.markAsFavourite(
      accountID: accountID,
      contentID: contentID,
      mediaType: selectedContentType,
      sessionID: Get.find<UserController>().sessionID.value,
    );
    if (status == true) {
      getAccountStates();
    }
  }

  void changeWatchlist({int? index}) async {
    late int contentID;
    if (index != null) {
      contentID = data[sortingOptions[selectedSortingOption.value]]![index].id;
    } else {
      contentID = data[sortingOptions[selectedSortingOption.value]]![
              currentCarouselItem.value]
          .id;
    }
    bool status = await TMDBApiService.addToWatchlist(
      accountID: accountID,
      contentID: contentID,
      mediaType: selectedContentType,
      sessionID: Get.find<UserController>().sessionID.value,
    );
    if (status == true) {
      getAccountStates();
    }
  }

  void getAccountStates({int? index}) async {
    late int contentID;
    if (index != null) {
      contentID = data[sortingOptions[selectedSortingOption.value]]![index].id;
    } else {
      contentID = data[sortingOptions[selectedSortingOption.value]]![
              currentCarouselItem.value]
          .id;
    }

    // accountStates.value = await TMDBApiService.getAccountStates(
    //   sessionID: Get.find<UserController>().sessionID.value,
    //   mediaID: contentID,
    //   mediaType: selectedContentType,
    // );
    if (index != null) {
      _accountStates[index] = await TMDBApiService.getAccountStates(
        sessionID: Get.find<UserController>().sessionID.value,
        mediaID: contentID,
        mediaType: selectedContentType,
      );
    } else
      _accountStates[currentCarouselItem.value] =
          await TMDBApiService.getAccountStates(
        sessionID: Get.find<UserController>().sessionID.value,
        mediaID: contentID,
        mediaType: selectedContentType,
      );
    update();
  }

  void changeSortingOption(int i) async {
    if (i != selectedSortingOption.value) {
      if (contentType.length > 1) selectedContentType = contentType[i];

      selectedSortingOption.value = i;
      results.clear();
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
            .imagePath;

    Get.toNamed(
      "/MediaDetails/${describeEnum(selectedContentType)}",
      preventDuplicates: false,
      arguments: MinimalMedia(
        id: contentID,
        mediaType: selectedContentType,
        title: contentTitle,
        posterPath: contentPosterPath,
      ),
    );
  }

  List<PosterListviewObject> get currentItems {
    return data[sortingOptions[selectedSortingOption.value]]!;
  }

  void changeViewOption() {
    if (viewAsList == true) {
      getPosterUrls();
      handlePageChange(0);
    }
    viewAsList.value = !viewAsList.value;
  }

  AccountStates? accountStates({int? index}) {
    if (index != null)
      return _accountStates[index];
    else
      return _accountStates[currentCarouselItem.value];
  }
}
