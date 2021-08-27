import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/models/minimal_media.dart';
import 'package:watched_it_getx/app/data/services/tmdb_api_service.dart';

//TODO FIX PROBLEM WITH DATES?
class SearchPageController extends GetxController {
  RxString searchInputHint = "".obs;
  TextEditingController searchFieldController = TextEditingController();
  RxString textFieldValue = "".obs;
  List<MinimalMedia> searchResults = [];
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
    List<MinimalMedia>? results =
        await TMDBApiService.getSearchResults(query: query);
    if (results != null) {
      //print("Query executed succesfully");
      searchResults.clear();
      for (MinimalMedia media in results) this.searchResults.add(media);
      update();
    }
  }
}
