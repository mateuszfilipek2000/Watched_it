import 'package:get/get.dart';

import '../controllers/media_detail_controller.dart';

class MediaDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MediaDetailController>(
      MediaDetailController(),
    );
  }
}
