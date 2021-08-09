import 'package:get/get.dart';

import 'package:watched_it_getx/app/modules/MainPageView/bindings/main_page_view_binding.dart';
import 'package:watched_it_getx/app/modules/MainPageView/views/main_page_view_view.dart';
import 'package:watched_it_getx/app/modules/SearchPage/bindings/search_page_binding.dart';
import 'package:watched_it_getx/app/modules/SearchPage/views/search_page_view.dart';
import 'package:watched_it_getx/app/modules/UserPage/bindings/user_page_binding.dart';
import 'package:watched_it_getx/app/modules/UserPage/views/user_page_view.dart';
import 'package:watched_it_getx/app/modules/WatchList/bindings/watch_list_binding.dart';
import 'package:watched_it_getx/app/modules/WatchList/views/watch_list_view.dart';
import 'package:watched_it_getx/app/modules/home/bindings/home_binding.dart';
import 'package:watched_it_getx/app/modules/home/views/home_view.dart';
import 'package:watched_it_getx/app/modules/splash_screen/bindings/splash_screen_binding.dart';
import 'package:watched_it_getx/app/modules/splash_screen/views/splash_screen_view.dart';
import 'package:watched_it_getx/app/shared_widgets/MinimalMediaListView/minimal_media_listview.dart';
import 'package:watched_it_getx/app/shared_widgets/MinimalMediaListView/minimal_media_listview_binding.dart';

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
      name: _Paths.WATCH_LIST,
      page: () => WatchListView(),
      binding: WatchListBinding(),
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
  ];
}
