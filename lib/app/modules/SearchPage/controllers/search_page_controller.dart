import 'package:get/get.dart';

class SearchPageController extends GetxController {
  RxString searchInputHint = "".obs;
  @override
  void onInit() {
    searchInputHint.value = "Insert your query here";
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
