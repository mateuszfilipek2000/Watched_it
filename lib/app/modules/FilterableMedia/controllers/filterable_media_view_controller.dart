import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/enums/available_watchlist_sorting_options.dart';
import 'package:watched_it_getx/app/data/enums/media_type.dart';
import 'package:watched_it_getx/app/data/models/image_model.dart';
import 'package:watched_it_getx/app/data/models/minimal_media.dart';
import 'package:watched_it_getx/app/shared_widgets/poster_listview/poster_listview_object.dart';

class FilterableMediaViewController extends GetxController {
  FilterableMediaViewController({
    required this.title,
    required this.sortingOptions,
    required this.buttonTitles,
    required this.getMoreObjects,
  });

  final String title;
  final List<String> buttonTitles;
  final List<String> sortingOptions;
  final Future<Map<String, dynamic>?> Function(
      int, MediaType, AvailableWatchListSortingOptions) getMoreObjects;

  //-----------------------------------------------------------
  //RxList<MinimalMedia> mediaList = RxList([]);
  //RxBool mediaListFetchingStatus = false.obs;
  RxBool isLoadingResults = false.obs;
  List<PosterListviewObject> results = [];

  RxInt activeMediaIndex = 0.obs;
  MediaType selectedMediaType = MediaType.movie;
  RxInt activeSortingMethod = 0.obs;
  AvailableWatchListSortingOptions selectedSortingMethod =
      AvailableWatchListSortingOptions.CreatedAtAsc;
  //-----------------------------------------------------------

  int page = 1;

  void changeActiveMedia(int id) {
    this.activeMediaIndex.value = id;
    id == 0
        ? selectedMediaType = MediaType.movie
        : selectedMediaType = MediaType.tv;

    fillMediaList();
  }

  void changeSortingMethod(int id) {
    this.activeSortingMethod.value = id;
    id == 0
        ? selectedSortingMethod = AvailableWatchListSortingOptions.CreatedAtAsc
        : selectedSortingMethod =
            AvailableWatchListSortingOptions.CreatedAtDesc;

    fillMediaList();
  }

  void fillMediaList() async {
    isLoadingResults.value = true;
    Map<String, dynamic>? media = await getMoreObjects(
      page,
      selectedMediaType,
      selectedSortingMethod,
    );

    if (media != null) {
      this.results.clear();
      for (Map<String, dynamic> result in media["results"]) {
        results.add(
          PosterListviewObject(
            id: result["id"],
            title: selectedMediaType == MediaType.movie
                ? result["title"]
                : result["name"],
            mediaType: selectedMediaType,
            subtitle: result["overview"],
            imagePath: result["poster_path"] == null
                ? null
                : ImageUrl.getPosterImageUrl(
                    url: result["poster_path"],
                    size: PosterSizes.w92,
                  ),
          ),
        );
      }
    } else {
      print("fillWatchList function null result error");
    }
    isLoadingResults.value = false;
  }

  void getToMediaDetails(int index) {
    Get.toNamed(
      "/MediaDetails/${describeEnum(selectedMediaType)}",
      preventDuplicates: false,
      arguments: MinimalMedia(
        id: results[index].id,
        mediaType: selectedMediaType,
        title: results[index].title,
        posterPath: results[index].imagePath,
      ),
    );
  }
}
