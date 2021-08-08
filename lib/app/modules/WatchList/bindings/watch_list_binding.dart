import 'package:get/get.dart';

import '../controllers/watch_list_controller.dart';

class WatchListBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<WatchListController>(
      WatchListController(),
    );
  }
}
