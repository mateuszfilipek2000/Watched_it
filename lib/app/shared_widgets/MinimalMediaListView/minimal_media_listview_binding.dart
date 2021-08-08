import 'package:get/get.dart';
import 'package:watched_it_getx/app/shared_widgets/MinimalMediaListView/minimal_media_listview_controller.dart';

class MinimalMediaListViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MinimalMediaListViewController>(
      MinimalMediaListViewController(),
    );
  }
}
