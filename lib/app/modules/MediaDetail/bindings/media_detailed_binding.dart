import 'package:get/get.dart';
import 'package:watched_it_getx/app/modules/MediaDetail/controllers/media_detailed_controller.dart';

class MediaDetailedViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MediaDetailedController>(
      MediaDetailedController(),
    );
  }
}
