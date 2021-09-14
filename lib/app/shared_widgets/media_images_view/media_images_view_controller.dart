import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/shared_widgets/media_images_view/media_image_overlay.dart';
import 'package:watched_it_getx/app/shared_widgets/media_images_view/media_images_overlay_controller.dart';

class MediaImagesViewController extends GetxController {
  MediaImagesViewController({required this.images});
  final List<MediaImageObject> images;

  bool isOverlayOpen = false;

  late OverlayEntry overlayEntry;

  @override
  void onClose() {
    if (overlayEntry.mounted) overlayEntry.remove();
    super.onClose();
  }

  void openImageFullScreen(int index) {
    Get.to(
      () => Image.network(
        images[index].highResUrl,
        fit: BoxFit.fitWidth,
      ),
      fullscreenDialog: true,
    );
  }

  void showImageOverlay(context, index) {
    if (isOverlayOpen == false) {
      OverlayState? overlayState = Overlay.of(context);
      overlayEntry = OverlayEntry(
        builder: (_) => MediaImageOverlay(
          imagePath: images[index].lowResUrl,
          aspectRatio: images[index].aspectRatio,
        ),
      );
      if (overlayState != null) {
        overlayState.insert(overlayEntry);
        isOverlayOpen = true;
      }
    }
  }

  void hideOverlay() {
    if (isOverlayOpen) {
      MediaImagesOverlayController imageOverlayController =
          Get.find<MediaImagesOverlayController>();
      //imageOverlayController.animController.stop();
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
}

class MediaImageObject {
  MediaImageObject({
    required this.lowResUrl,
    required this.highResUrl,
    required this.aspectRatio,
  });
  final String lowResUrl;
  final String highResUrl;
  final double aspectRatio;
}
