import 'package:get/get.dart';

import '../controllers/media_poster_view_controller.dart';

class MediaDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MediaPosterViewController>(
      MediaPosterViewController(),
    );
  }
}
