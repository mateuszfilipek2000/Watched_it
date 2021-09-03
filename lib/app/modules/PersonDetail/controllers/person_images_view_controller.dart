import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/modules/PersonDetail/controllers/image_overlay_controller.dart';
import 'package:watched_it_getx/app/modules/PersonDetail/widgets/image_overlay.dart';

class PersonImageViewController extends GetxController {
  bool isOverlayOpen = false;

  late OverlayEntry overlayEntry;

  @override
  void onClose() {
    if (overlayEntry.mounted) overlayEntry.remove();
    super.onClose();
  }

  void showImageOverlay(BuildContext context, String imagePath) async {
    if (isOverlayOpen == false) {
      OverlayState? overlayState = Overlay.of(context);
      overlayEntry = OverlayEntry(
        builder: (_) => ImageOverlay(
          imagePath: imagePath,
        ),
      );
      if (overlayState != null) {
        overlayState.insert(overlayEntry);
        isOverlayOpen = true;
      }
    }
  }

  void hideOverlay() async {
    if (isOverlayOpen) {
      ImageOverlayController imageOverlayController =
          Get.find<ImageOverlayController>();
      imageOverlayController.animController.stop();
      TickerFuture animControllerStatus =
          imageOverlayController.animController.reverse();
      animControllerStatus.whenComplete(() {
        if (overlayEntry.mounted) {
          overlayEntry.remove();
          isOverlayOpen = false;
        }
      });
    }
  }

  void openImageFullScreen(String imagePath) {
    Get.to(
      () => Image.network(
        imagePath,
        fit: BoxFit.contain,
      ),
      fullscreenDialog: true,
    );
  }
}
