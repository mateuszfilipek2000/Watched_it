import 'package:get/get.dart';
import 'package:watched_it_getx/app/modules/WatchList/controllers/minimal_media_listview_controller.dart';

class MinimalMediaListViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MinimalMediaListViewController>(
      MinimalMediaListViewController(),
    );
  }
}
