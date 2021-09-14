import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/models/user_model.dart';
import 'package:watched_it_getx/app/data/services/tmdb_api_service.dart';
import 'package:watched_it_getx/app/data/services/user_service.dart';

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
      Get.find<UserService>().sessionID,
    );
    print(tempUser?.avatar_Path);
    if (tempUser != null) this.user = tempUser;
    update();
    refresh();
  }

/*
TMDBApiService.getWatchlist(
      mediaType: activeMediaType,
      sortingOption: sortingMethod,
      sessionID: Get.find<UserController>().sessionID.value,
      accountID: user?.id.toString() as String,
    );
*/

}
