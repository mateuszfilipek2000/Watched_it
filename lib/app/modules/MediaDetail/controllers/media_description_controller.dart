import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/models/minimal_media.dart';
import 'package:watched_it_getx/app/modules/MediaDetail/controllers/media_detail_controller.dart';

class MediaDescriptionController extends GetxController {
  late Rx<MinimalMedia?> minimalMedia;

  @override
  void onInit() {
    minimalMedia = Get.find<MediaDetailController>().minimalMedia;
    super.onInit();
  }
}
