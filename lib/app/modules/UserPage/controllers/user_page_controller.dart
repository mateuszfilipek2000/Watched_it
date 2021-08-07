import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/models/user_model.dart';
import 'package:watched_it_getx/app/data/services/tmdb_api_service.dart';
import 'package:watched_it_getx/app/modules/splash_screen/controllers/user_controller_controller.dart';

class UserPageController extends GetxController {
  AppUser? user = null;

  @override
  void onInit() {
    getUserDetails();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Future<void> getUserDetails() async {
    AppUser? tempUser = await TMDBApiService.getUserDetails(
      Get.find<UserController>().sessionID.value,
    );
    print(tempUser?.avatar_Path);
    if (tempUser != null) this.user = tempUser;
    update();
  }
}
