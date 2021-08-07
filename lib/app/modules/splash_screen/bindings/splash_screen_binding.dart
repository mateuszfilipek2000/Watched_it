import 'package:get/get.dart';

import 'package:watched_it_getx/app/modules/splash_screen/controllers/login_controller.dart';
import 'package:watched_it_getx/app/modules/splash_screen/controllers/user_controller_controller.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<UserController>(
      UserController(),
      permanent: true,
    );
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
    Get.put<SplashScreenController>(
      SplashScreenController(),
      //SplashScreenController
    );
  }
}
