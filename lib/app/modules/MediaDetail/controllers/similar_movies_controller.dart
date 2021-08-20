import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/models/image_model.dart';
import 'package:watched_it_getx/app/data/models/recommendations_model.dart';
import 'package:watched_it_getx/app/data/services/tmdb_api_service.dart';
import 'package:watched_it_getx/app/modules/MediaDetail/controllers/media_detailed_controller.dart';
import 'package:watched_it_getx/app/shared_widgets/imagecarousel/image_carousel_controller.dart';

class SimilarMoviesController extends GetxController {
  Rx<Recommendations?> recommendations = Rx<Recommendations?>(null);
  RxInt currentPage = 1.obs;
  RxList<String?> recommendedUrls = RxList([]);
  RxInt currentCarouselItem = 0.obs;

  //late ImageCarouselController smallCarouselController;

  @override
  void onInit() {
    // smallCarouselController = Get.put<ImageCarouselController>(
    //   ImageCarouselController(0.7, 0.8),
    //   tag: "smallCarouselController",
    // );
    getRecommendedUrls();
    super.onInit();
  }

  @override
  void onClose() {
    print("closing similar movies");
    super.onClose();
  }

  void getRecommendedUrls() async {
    recommendations.value = await TMDBApiService.getRecommendations(
      id: Get.find<MediaDetailedController>().minimalMedia.value.id,
      page: currentPage.value,
    );
    if (recommendations.value != null) {
      for (Result result in recommendations.value?.results as List<Result>) {
        if (result.posterPath == null) {
          recommendedUrls.add(null);
        } else {
          // print(
          //   ImageUrl.getPosterImageUrl(
          //     url: result.posterPath as String,
          //     size: PosterSizes.w342,
          //   ),
          // );
          recommendedUrls.add(
            ImageUrl.getPosterImageUrl(
              url: result.posterPath as String,
              size: PosterSizes.w342,
            ),
          );
        }
      }
    }
  }
}
