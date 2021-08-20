import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/models/recommendations_model.dart';
import 'package:watched_it_getx/app/data/services/tmdb_api_service.dart';

class SimilarMoviesController extends GetxController {
  Rx<Recommendations?> recommendations = Rx<Recommendations?>(null);
  @override
  void onInit() async {
    //recommendations = await TMDBApiService.get
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
