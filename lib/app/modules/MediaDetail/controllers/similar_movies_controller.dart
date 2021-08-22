import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/enums/media_type.dart';
import 'package:watched_it_getx/app/data/models/account_states.dart';
import 'package:watched_it_getx/app/data/models/image_model.dart';
import 'package:watched_it_getx/app/data/models/minimal_media.dart';
import 'package:watched_it_getx/app/data/models/recommendations_model.dart';
import 'package:watched_it_getx/app/data/services/tmdb_api_service.dart';
import 'package:watched_it_getx/app/modules/MediaDetail/controllers/media_detailed_controller.dart';
import 'package:watched_it_getx/app/modules/MediaDetail/views/media_detailed_view.dart';
import 'package:watched_it_getx/app/modules/splash_screen/controllers/user_controller_controller.dart';

class SimilarMoviesController extends GetxController
    with SingleGetTickerProviderMixin {
  SimilarMoviesController({required this.tag});
  String tag;
  Rx<Recommendations?> recommendations = Rx<Recommendations?>(null);
  RxInt currentPage = 1.obs;
  RxList<String?> results = RxList([]);
  RxInt currentCarouselItem = 0.obs;
  Rx<AccountStates?> accountStates = Rx<AccountStates?>(null);

  List<String> sortingOption = ["Similar", "Recommended"];
  RxInt selectedSortingOption = 0.obs;

  @override
  void onInit() {
    getPosterUrls();

    super.onInit();
  }

  @override
  void onClose() {
    //print("closing similar movies");
    super.onClose();
  }

  void getPosterUrls() async {
    if (selectedSortingOption.value == 0) {
      recommendations.value = await TMDBApiService.getRecommendations(
        id: Get.find<MediaDetailedController>(tag: tag).minimalMedia.value.id,
        page: currentPage.value,
      );
    } else {
      recommendations.value = await TMDBApiService.getSimilar(
        id: Get.find<MediaDetailedController>(tag: tag).minimalMedia.value.id,
        page: currentPage.value,
      );
    }
    if (recommendations.value != null) {
      for (Result result in recommendations.value?.results as List<Result>) {
        if (result.posterPath == null) {
          results.add(null);
        } else {
          results.add(
            ImageUrl.getPosterImageUrl(
              url: result.posterPath as String,
              size: PosterSizes.w342,
            ),
          );
        }
      }
      getAccountStates();
    }
  }

  String getReleaseDate() {
    if (recommendations.value?.results[currentCarouselItem.value].releaseDate !=
        null)
      return recommendations
          .value?.results[currentCarouselItem.value].releaseDate
          .getDashedDate() as String;
    else
      return "No date available";
  }

  String getTitle() {
    if (recommendations.value?.results[currentCarouselItem.value].title != null)
      return recommendations.value?.results[currentCarouselItem.value].title
          as String;
    else
      return "No title available";
  }

  void handlePageChange(int index) async {
    currentCarouselItem.value = index;
    getAccountStates();
  }

  void changeFavourite() async {
    bool status = await TMDBApiService.markAsFavourite(
      accountID: Get.find<MediaDetailedController>(tag: tag).user?.id as int,
      contentID:
          recommendations.value?.results[currentCarouselItem.value].id as int,
      mediaType: MediaType.movie,
      sessionID: Get.find<UserController>().sessionID.value,
    );
    if (status == true) {
      getAccountStates();
    }
  }

  void changeWatchlist() async {
    bool status = await TMDBApiService.addToWatchlist(
      accountID: Get.find<MediaDetailedController>(tag: tag).user?.id as int,
      contentID:
          recommendations.value?.results[currentCarouselItem.value].id as int,
      mediaType: MediaType.movie,
      sessionID: Get.find<UserController>().sessionID.value,
    );
    if (status == true) {
      getAccountStates();
    }
  }

  void getAccountStates() async {
    accountStates.value = await TMDBApiService.getAccountStates(
      sessionID: Get.find<UserController>().sessionID.value,
      movieID:
          recommendations.value?.results[currentCarouselItem.value].id as int,
    );
  }

  void changeSortingOption(int i) async {
    if (i != selectedSortingOption.value) {
      selectedSortingOption.value = i;
      results.clear();
      currentCarouselItem.value = 0;
      getPosterUrls();
    }
  }

  void getToMovieDetailPage(int index) {
    Get.to(
      () => MediaDetailedView(),
      fullscreenDialog: true,
      preventDuplicates: false,
      arguments: MinimalMedia(
        id: this.recommendations.value?.results[index].id as int,
        mediaType: MediaType.movie,
        title: this.recommendations.value?.results[index].title as String,
        posterPath: this.recommendations.value?.results[index].posterPath,
      ),
    );
  }
}

// extension leadingZeros on int {
//   String addLeadingZeros(int numberOfTotalDigits) =>
//       this.toString().padLeft(numberOfTotalDigits, '0');
// }

extension dashedDate on DateTime {
  String getDashedDate() =>
      "${this.year}-${this.month.addLeadingZeros(2)}-${this.day.addLeadingZeros(2)}";
}
