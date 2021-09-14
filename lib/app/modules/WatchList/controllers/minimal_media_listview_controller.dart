import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/enums/available_watchlist_sorting_options.dart';
import 'package:watched_it_getx/app/data/enums/media_type.dart';
import 'package:watched_it_getx/app/data/models/minimal_media.dart';
import 'package:watched_it_getx/app/data/models/user_model.dart';
import 'package:watched_it_getx/app/data/services/user_service.dart';

class MinimalMediaListViewController extends GetxController {
  //-----------------------------------------------------------
  late String title;
  late AppUser user;
  late List<String> buttonTexts;
  late List<String> sortingMethodTexts;
  late Future<List<MinimalMedia>?> Function(
      MediaType, AvailableWatchListSortingOptions, String, String,
      [String, int]) minimalMediaRetrievalFuture;
  RxList<MinimalMedia> mediaList = RxList([]);
  RxBool mediaListFetchingStatus = false.obs;

  RxInt activeMediaIndex = 0.obs;
  MediaType selectedMediaType = MediaType.movie;
  RxInt activeSortingMethod = 0.obs;
  AvailableWatchListSortingOptions selectedSortingMethod =
      AvailableWatchListSortingOptions.CreatedAtAsc;
  //-----------------------------------------------------------

  @override
  void onInit() {
    user = Get.arguments["user"];
    title = Get.arguments["ListTitle"];
    buttonTexts = Get.arguments["ButtonTexts"];
    sortingMethodTexts = Get.arguments["SortingMethodTexts"];
    minimalMediaRetrievalFuture = Get.arguments["MinimalMediaRetrievalFuture"];

    fillMediaList();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void changeActiveMedia(int id) {
    this.activeMediaIndex.value = id;
    id == 0
        ? selectedMediaType = MediaType.movie
        : selectedMediaType = MediaType.tv;

    this.mediaListFetchingStatus.value = false;
    fillMediaList();
  }

  void changeSortingMethod(int id) {
    this.activeSortingMethod.value = id;
    id == 0
        ? selectedSortingMethod = AvailableWatchListSortingOptions.CreatedAtAsc
        : selectedSortingMethod =
            AvailableWatchListSortingOptions.CreatedAtDesc;

    this.mediaListFetchingStatus.value = false;
    fillMediaList();
  }

  void fillMediaList() async {
    List<MinimalMedia>? media = await minimalMediaRetrievalFuture(
      selectedMediaType,
      selectedSortingMethod,
      Get.find<UserService>().sessionID,
      user.id.toString(),
    );

    if (media != null) {
      this.mediaList.clear();
      for (MinimalMedia i in media) this.mediaList.add(i);
      this.mediaListFetchingStatus.value = true;
      update();
      print(mediaList.length);
      print("Succesfully filled the mediaList");
    } else {
      print("fillWatchList function null result error");
    }
  }
}

Map<String, dynamic> arguments = {
  "user": AppUser,
  "ListTitle": String,
  "ButtonTexts": List,
  "SortingMethodsTexts": List,
  "MinimalMediaRetrievalFuture": Future,
};
