import 'package:get/get.dart';

import '../controllers/main_page_view_controller.dart';

class MainPageViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainPageViewController>(
      () => MainPageViewController(),
    );
  }
}
