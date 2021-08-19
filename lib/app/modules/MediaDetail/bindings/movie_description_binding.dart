import 'package:get/get.dart';
import 'package:watched_it_getx/app/modules/MediaDetail/controllers/movie_overview_controller.dart';

class MovieDescriptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MovieOverviewController>(
      MovieOverviewController(),
    );
  }
}
