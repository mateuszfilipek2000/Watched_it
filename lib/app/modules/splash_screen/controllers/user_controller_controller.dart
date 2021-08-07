import 'package:get/get.dart';

class UserController extends GetxController {
  final Rx<String> sessionID = "".obs;
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

  void updateSessionID(String id) {
    sessionID.value = id;
    update();
  }
}
