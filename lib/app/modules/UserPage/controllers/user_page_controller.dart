import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/enums/available_watchlist_sorting_options.dart';
import 'package:watched_it_getx/app/data/enums/media_type.dart';
import 'package:watched_it_getx/app/data/models/user_model.dart';
import 'package:watched_it_getx/app/data/services/network/version4/account.dart';
import 'package:watched_it_getx/app/data/services/user_service.dart';
import 'package:watched_it_getx/app/modules/FilterableMedia/views/filterable_media_view.dart';
import 'package:watched_it_getx/app/modules/Settings/bindings/settings_binding.dart';
import 'package:watched_it_getx/app/modules/Settings/views/settings_view.dart';

class UserPageController extends GetxController {
  AppUser user = Get.find<UserService>().user;

  void getToWatchlistPage() {
    Get.to(
      () => FilterableMediaView(
        title: "Your Watchlist",
        sortingOptions: [
          "Created At - Ascending",
          "Created At - Descending",
        ],
        buttonTitles: ["Movies", "Tv Shows"],
        getMoreObjects: (int page, MediaType mediaType,
                AvailableWatchListSortingOptions sortingOption) =>
            AccountV4.getWatchlist(
          accessToken: Get.find<UserService>().accessToken,
          accountID: Get.find<UserService>().accountIDv4,
          mediaType: mediaType,
          page: page,
          sortingOption: sortingOption,
        ),
      ),
      fullscreenDialog: true,
    );
  }

  void getToFavouritesPage() {
    Get.to(
      () => FilterableMediaView(
        title: "Your Favourites",
        sortingOptions: [
          "Created At - Ascending",
          "Created At - Descending",
        ],
        buttonTitles: ["Movies", "Tv Shows"],
        getMoreObjects: (int page, MediaType mediaType,
                AvailableWatchListSortingOptions sortingOption) =>
            AccountV4.getFavourites(
          accessToken: Get.find<UserService>().accessToken,
          accountID: Get.find<UserService>().accountIDv4,
          mediaType: mediaType,
          page: page,
          sortingOption: sortingOption,
        ),
      ),
      fullscreenDialog: true,
    );
  }

  void getToSettingsPage() {
    Get.to(
      () => SettingsView(),
      binding: SettingsBinding(),
      fullscreenDialog: true,
    );
  }
}
