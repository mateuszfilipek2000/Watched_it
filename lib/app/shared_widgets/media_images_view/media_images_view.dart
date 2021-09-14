import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:watched_it_getx/app/shared_widgets/media_images_view/media_images_view_controller.dart';

class MediaImagesView extends StatelessWidget {
  MediaImagesView({
    Key? key,
    required this.tag,
    required List<MediaImageObject> images,
  })  : controller =
            Get.put(MediaImagesViewController(images: images), tag: tag),
        super(key: key);

  final MediaImagesViewController controller;
  final String tag;

  @override
  Widget build(BuildContext context) {
    if (controller.images.length == 0) {
      return Center(
        child: Text(
          "No images",
          style: Theme.of(context).textTheme.headline5,
        ),
      );
    } else
      return Container(
        height: double.infinity,
        width: double.infinity,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
          ),
          itemCount: controller.images.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => controller.openImageFullScreen(
                index,
              ),
              onLongPress: () => controller.showImageOverlay(
                context,
                index,
              ),
              onLongPressEnd: (LongPressEndDetails) => controller.hideOverlay(),
              child: Image.network(
                controller.images[index].lowResUrl,
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      );
  }
}
