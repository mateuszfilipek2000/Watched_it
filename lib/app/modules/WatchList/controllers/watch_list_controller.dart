import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/enums/available_watchlist_sorting_options.dart';
import 'package:watched_it_getx/app/data/enums/media_type.dart';
import 'package:watched_it_getx/app/data/models/minimal_media.dart';
import 'package:watched_it_getx/app/data/models/user_model.dart';
import 'package:watched_it_getx/app/data/services/tmdb_api_service.dart';
import 'package:watched_it_getx/app/modules/splash_screen/controllers/user_controller_controller.dart';

class WatchListController extends GetxController {
  late AppUser user;
  RxList<MinimalMedia> watchlist = RxList([]);
  RxBool watchlistFetchingStatus = false.obs;

  RxInt activeMediaIndex = 0.obs;
  MediaType selectedMediaType = MediaType.movie;
  RxInt activeSortingMethod = 0.obs;
  AvailableWatchListSortingOptions selectedSortingMethod =
      AvailableWatchListSortingOptions.CreatedAtAsc;
  List<String> buttonTexts = [
    "Movies",
    "Tv Shows",
  ];
  List<String> sortingMethodsTexts = [
    "Created At - Ascending",
    "Created At - Descending",
  ];

  @override
  void onInit() {
    user = Get.arguments;
    fillWatchList();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

/*
TMDBApiService.getWatchlist(
      mediaType: activeMediaType,
      sortingOption: sortingMethod,
      sessionID: Get.find<UserController>().sessionID.value,
      accountID: user?.id.toString() as String,
    );
*/
  void changeActiveMedia(int id) {
    this.activeMediaIndex.value = id;
    id == 0
        ? selectedMediaType = MediaType.movie
        : selectedMediaType = MediaType.tv;

    this.watchlistFetchingStatus.value = false;
    fillWatchList();
  }

  void changeSortingMethod(int id) {
    this.activeSortingMethod.value = id;
    id == 0
        ? selectedSortingMethod = AvailableWatchListSortingOptions.CreatedAtAsc
        : selectedSortingMethod =
            AvailableWatchListSortingOptions.CreatedAtDesc;

    this.watchlistFetchingStatus.value = false;
    fillWatchList();
  }

  void fillWatchList() async {
    List<MinimalMedia>? media = await TMDBApiService.getWatchlist(
      selectedMediaType,
      selectedSortingMethod,
      Get.find<UserController>().sessionID.value,
      user.id.toString(),
    );

    if (media != null) {
      this.watchlist.clear();
      for (MinimalMedia i in media) this.watchlist.add(i);
      this.watchlistFetchingStatus.value = true;
      update();
      print(watchlist.length);
      print("Succesfully filled the watchlist");
    } else {
      print("fillWatchList function null result error");
    }
  }
}
