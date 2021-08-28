import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/models/minimal_media.dart';
import 'package:watched_it_getx/app/data/services/tmdb_api_service.dart';
import 'package:watched_it_getx/app/shared_widgets/poster_listview/poster_listview_object.dart';

//TODO FIX PROBLEM WITH DATES?
class SearchPageController extends GetxController {
  RxString searchInputHint = "".obs;
  TextEditingController searchFieldController = TextEditingController();
  RxString textFieldValue = "".obs;
  List<PosterListviewObject> searchResults = [];
  @override
  void onInit() {
    searchInputHint.value = "Insert your query here";

    debounce(
      textFieldValue,
      (value) {
        if (value != "") handleSearch(value.toString());
      },
    );
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    searchFieldController.dispose();
    super.onClose();
  }

  void handleControllerTextChange(String value) => textFieldValue.value = value;

  void handleSearch(String query) async {
    List<PosterListviewObject>? results =
        await TMDBApiService.getSearchResults(query: query);
    if (results != null) {
      //print("Query executed succesfully");
      searchResults.clear();
      for (PosterListviewObject media in results) this.searchResults.add(media);
      update();
    }
  }

  //TODO GET RID OF MINIMAL MEDIA IN ROUTES OR CHANGE POSTER PATH TO IMAGE PATH (FULL IMAGE PATH, NOT ONLY)
  void navigateToMediaDetail({required int searchResultIndex}) {
    Get.toNamed(
      "/MediaDetails/${describeEnum(searchResults[searchResultIndex].mediaType)}",
      arguments: MinimalMedia(
        id: searchResults[searchResultIndex].id,
        mediaType: searchResults[searchResultIndex].mediaType,
        title: searchResults[searchResultIndex].title,
        posterPath: searchResults[searchResultIndex].imagePath,
      ),
    );
  }
}
