import 'package:get/get.dart';

import 'package:watched_it_getx/app/modules/About/bindings/about_binding.dart';
import 'package:watched_it_getx/app/modules/About/views/about_view.dart';
import 'package:watched_it_getx/app/modules/DiscoverView/views/discover_view_view.dart';
import 'package:watched_it_getx/app/modules/MainPageView/bindings/main_page_view_binding.dart';
import 'package:watched_it_getx/app/modules/MainPageView/views/main_page_view_view.dart';
import 'package:watched_it_getx/app/modules/MovieDetail/views/media_poster_view.dart';
import 'package:watched_it_getx/app/modules/MovieDetail/views/movie_detail_view.dart';
import 'package:watched_it_getx/app/modules/PersonDetail/views/person_detail_view.dart';
import 'package:watched_it_getx/app/modules/SearchPage/bindings/search_page_binding.dart';
import 'package:watched_it_getx/app/modules/SearchPage/views/search_page_view.dart';
import 'package:watched_it_getx/app/modules/Settings/bindings/settings_binding.dart';
import 'package:watched_it_getx/app/modules/Settings/views/settings_view.dart';
import 'package:watched_it_getx/app/modules/TvDetail/views/tv_detail_view.dart';
import 'package:watched_it_getx/app/modules/UserPage/views/user_page_view.dart';
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
      //binding: UserPageBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_PAGE,
      page: () => SearchPageView(),
      binding: SearchPageBinding(),
    ),
    GetPage(
      name: _Paths.MEDIA_DETAIL,
      page: () => MediaPosterView(),
    ),
    // GetPage(
    //   name: _Paths.TV_DETAIL,
    //   page: () => TvDetailView(),
    //   binding: TvDetailBinding(),
    // ),
    GetPage(
      name: "/MediaDetails/tv",
      page: () => TvDetailView(),
    ),
    GetPage(
      name: "/MediaDetails/movie",
      page: () => MovieDetailView(),
    ),
    GetPage(
      name: "/MediaDetails/person",
      page: () => PersonDetailView(),
    ),
    GetPage(
      name: _Paths.PERSON_DETAIL,
      page: () => PersonDetailView(),
    ),
    GetPage(
      name: _Paths.DISCOVER_VIEW,
      page: () => DiscoverViewView(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.ABOUT,
      page: () => AboutView(),
      binding: AboutBinding(),
    ),
  ];
}
