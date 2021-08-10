import 'package:get/get.dart';

import '../controllers/search_page_controller.dart';

class SearchPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SearchPageController>(
      SearchPageController(),
    );
  }
}
