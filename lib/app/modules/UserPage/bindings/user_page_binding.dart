import 'package:get/get.dart';

import '../controllers/user_page_controller.dart';

class UserPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserPageController>(
      () => UserPageController(),
    );
  }
}
