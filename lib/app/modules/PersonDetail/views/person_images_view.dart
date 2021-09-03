import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/models/image_model.dart';
import 'package:watched_it_getx/app/modules/PersonDetail/controllers/person_detail_controller.dart';
import 'package:provider/provider.dart';
import 'package:watched_it_getx/app/modules/PersonDetail/controllers/person_images_view_controller.dart';

class PersonImagesView extends StatelessWidget {
  const PersonImagesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PersonImageViewController>(
      init: PersonImageViewController(),
      tag: context.read<String>(),
      builder: (imageController) => GetBuilder<PersonDetailController>(
        init: Get.find<PersonDetailController>(
          tag: context.read<String>(),
        ),
        builder: (personDetailController) => Container(
          height: double.infinity,
          width: double.infinity,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
              childAspectRatio: 1 / 1.5,
            ),
            itemCount: personDetailController.amountOfProfiles,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => imageController.openImageFullScreen(
                  ImageUrl.getProfileImageUrl(
                    url: personDetailController
                        .personImages.profiles[index].filePath,
                    size: ProfileSizes.w780,
                  ),
                ),
                onLongPress: () {
                  imageController.showImageOverlay(
                    context,
                    ImageUrl.getProfileImageUrl(
                      url: personDetailController
                          .personImages.profiles[index].filePath,
                      size: ProfileSizes.w500,
                    ),
                  );
                },
                onLongPressEnd: (LongPressEndDetails) {
                  imageController.hideOverlay();
                },
                child: Image.network(
                  ImageUrl.getProfileImageUrl(
                    url: personDetailController
                        .personImages.profiles[index].filePath,
                    size: ProfileSizes.w500,
                  ),
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
//todo change grid to listview using different sizes of elements ?
/*
grid width is 3x
small grid element size is 1x1 - cropped posters
medium vertical grid element size is 2x1 - non cropped posters
medium vertical grid element size is 1x2 - backdrops
big grid element size is 3x2 - backdrops?
*/

class SmallGridElement extends StatelessWidget {
  const SmallGridElement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MediumVerticalGridElement extends StatelessWidget {
  const MediumVerticalGridElement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MediumHorizontalGridElement extends StatelessWidget {
  const MediumHorizontalGridElement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class BigGridElement extends StatelessWidget {
  const BigGridElement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
