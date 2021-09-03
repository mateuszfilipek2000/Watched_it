import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/models/user_model.dart';
import 'package:watched_it_getx/app/data/services/tmdb_api_service.dart';

class UserController extends GetxController {
  final Rx<String> sessionID = "".obs;
  late final AppUser user;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void updateSessionID(String id) async {
    sessionID.value = id;
    AppUser? tempUser = await TMDBApiService.getUserDetails(
      sessionID.value,
    );

    if (tempUser != null) {
      user = tempUser;
      print("successfully retrieved user info in user controller");
    }

    update();
  }
}
