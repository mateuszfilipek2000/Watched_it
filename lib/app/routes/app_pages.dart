import 'package:get/get.dart';

import 'package:watched_it_getx/app/modules/MainPageView/bindings/main_page_view_binding.dart';
import 'package:watched_it_getx/app/modules/MainPageView/views/main_page_view_view.dart';
import 'package:watched_it_getx/app/modules/MediaDetail/bindings/media_poster_view_binding.dart';
import 'package:watched_it_getx/app/modules/MediaDetail/views/media_poster_view.dart';
import 'package:watched_it_getx/app/modules/SearchPage/bindings/search_page_binding.dart';
import 'package:watched_it_getx/app/modules/SearchPage/views/search_page_view.dart';
import 'package:watched_it_getx/app/modules/UserPage/bindings/user_page_binding.dart';
import 'package:watched_it_getx/app/modules/UserPage/views/user_page_view.dart';
import 'package:watched_it_getx/app/modules/WatchList/bindings/minimal_media_listview_binding.dart';
import 'package:watched_it_getx/app/modules/WatchList/views/minimal_media_listview.dart';
import 'package:watched_it_getx/app/modules/home/bindings/home_binding.dart';
import 'package:watched_it_getx/app/modules/home/views/home_view.dart';
import 'package:watched_it_getx/app/modules/splash_screen/bindings/splash_screen_binding.dart';
import 'package:watched_it_getx/app/modules/splash_screen/views/splash_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.MAIN_PAGE_VIEW,
      page: () => MainPageViewView(),
      binding: MainPageViewBinding(),
    ),
    GetPage(
      name: _Paths.USER_PAGE,
      page: () => UserPageView(),
      binding: UserPageBinding(),
    ),
    GetPage(
      name: _Paths.MINIMAL_MEDIA_LIST_VIEW,
      page: () => MinimalMediaListView(),
      binding: MinimalMediaListViewBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_PAGE,
      page: () => SearchPageView(),
      binding: SearchPageBinding(),
    ),
    GetPage(
      name: _Paths.MEDIA_DETAIL,
      page: () => MediaPosterView(),
      binding: MediaDetailBinding(),
    ),
  ];
}
