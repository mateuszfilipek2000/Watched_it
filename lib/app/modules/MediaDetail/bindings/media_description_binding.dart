import 'package:get/get.dart';
import 'package:watched_it_getx/app/modules/MediaDetail/controllers/media_description_controller.dart';

class MediaDescriptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MediaDescriptionController>(
      MediaDescriptionController(),
    );
  }
}
