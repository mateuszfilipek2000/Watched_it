import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/models/minimal_media.dart';
import 'package:watched_it_getx/app/data/services/tmdb_api_service.dart';

class HomeController extends GetxController {
  final RxList<MinimalMedia> nowPlayingMovies = RxList<MinimalMedia>();
  final RxList<MinimalMedia> popularTvShows = RxList<MinimalMedia>();
  final RxList<MinimalMedia> popularPeople = RxList<MinimalMedia>();
  final Rx<PageController> pageController = Rx<PageController>(
    PageController(
      initialPage: 0,
    ),
  );
  @override
  void onInit() async {
    getTrendingMovies();
    getPopularTvShows();
    getPopularPeople();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void getTrendingMovies() async {
    List<MinimalMedia>? nowPlayingMovies =
        await TMDBApiService.getNowPlayingMovies();

    if (nowPlayingMovies != null) {
      for (MinimalMedia media in nowPlayingMovies) {
        this.nowPlayingMovies.add(media);
      }
    }
    update();
  }

  void getPopularTvShows() async {
    List<MinimalMedia>? popularTvShows =
        await TMDBApiService.getPopularTvShows();

    if (popularTvShows != null) {
      for (MinimalMedia media in popularTvShows) {
        this.popularTvShows.add(media);
      }
    }
    print(this.popularTvShows.length);
    update();
  }

  void getPopularPeople() async {
    List<MinimalMedia>? popularPeople =
        await TMDBApiService.getPopular(mediaType: MediaType.person);

    if (popularPeople != null) {
      for (MinimalMedia media in popularPeople) {
        this.popularPeople.add(media);
      }
    }
    print(this.popularPeople.length);
    update();
  }

  String getFormattedDate(MinimalMedia object) {
    if (object.date == null)
      return "";
    else
      return "${object.date?.year}-${object.date?.month.addLeadingZeros(2)}-${object.date?.day.addLeadingZeros(2)}";
  }
  // void printer() async {
  //   User? user = await TMDBApiService.getUserDetails(
  //       Get.find<UserController>().sessionID.value);
  //   print(user?.name);
  //   print(Get.find<UserController>().sessionID.value);
  // }
}

extension leadingZeros on int {
  String addLeadingZeros(int numberOfTotalDigits) =>
      this.toString().padLeft(numberOfTotalDigits, '0');
}
