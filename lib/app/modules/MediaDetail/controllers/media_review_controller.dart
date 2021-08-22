import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/models/reviews.dart';
import 'package:watched_it_getx/app/data/services/tmdb_api_service.dart';
import 'package:watched_it_getx/app/modules/MediaDetail/controllers/media_detailed_controller.dart';
import 'package:watched_it_getx/app/modules/MediaDetail/controllers/movie_overview_controller.dart';

class MediaReviewController extends GetxController {
  MediaReviewController({required this.tag});
  String tag;
  Rx<Reviews?> reviews = Rx<Reviews?>(null);
  int reviewPage = 1;
  ScrollController scrollController = ScrollController();
  RxList<Result> listOfReviews = RxList([]);

  @override
  void onInit() {
    scrollController.addListener(_scrollListener);
    _fetchReviews();
    super.onInit();
    //reviews.value.results
  }

  @override
  void onClose() {
    super.onClose();
  }

  void _nextReviewsPage() {
    if (reviews.value?.totalPages as int >= reviewPage + 1) {
      reviewPage += 1;
      _fetchReviews();
    } else {
      print("no more reviews");
    }
  }

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      _nextReviewsPage();
      print("bottom reached");
    }
  }

  void _fetchReviews() async {
    reviews.value = await TMDBApiService.getReviews(
      id: Get.find<MediaDetailedController>(tag: tag).minimalMedia.value.id,
      page: reviewPage,
    );

    if (reviews.value != null) {
      for (Result result in reviews.value?.results as List<Result>)
        listOfReviews.add(result);
    }
  }
}

extension leadingZeros on int {
  String addLeadingZeros(int numberOfTotalDigits) =>
      this.toString().padLeft(numberOfTotalDigits, '0');
}

extension dashedDate on DateTime {
  String getDashedDate() =>
      "${this.year}-${this.month.addLeadingZeros(2)}-${this.day.addLeadingZeros(2)}";
}
