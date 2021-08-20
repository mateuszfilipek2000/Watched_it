import 'package:get/get.dart';

import '../controllers/media_poster_view_controller.dart';

class MediaPosterViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MediaPosterViewController>(
      MediaPosterViewController(),
    );
  }
}
