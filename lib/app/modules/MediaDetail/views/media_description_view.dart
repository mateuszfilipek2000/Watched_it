import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/models/image_model.dart';
import 'package:watched_it_getx/app/modules/MediaDetail/controllers/media_description_controller.dart';

class MediaDescriptionView extends GetView<MediaDescriptionController> {
  const MediaDescriptionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: double.infinity,
              height: 350,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Hero(
                      tag: controller.minimalMedia.value?.title as String,
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.only(bottomRight: Radius.circular(30)),
                        child: Image.network(
                          ImageUrl.getPosterImageUrl(
                            url: controller.minimalMedia.value?.posterPath
                                as String,
                            size: PosterSizes.w780,
                          ),
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Container(
                              color: Colors.black,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        //shape: BoxShape.circle,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                        ),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.favorite_rounded,
                          size: 30.0,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              color: Colors.blue,
              height: 500.0,
            ),
          ],
        ),
      ),
    );
  }
}
