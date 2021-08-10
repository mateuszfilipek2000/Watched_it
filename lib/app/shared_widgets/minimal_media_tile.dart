import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/models/image_model.dart';
import 'package:watched_it_getx/app/data/models/minimal_media.dart';
import 'package:watched_it_getx/app/modules/MediaDetail/bindings/media_detail_binding.dart';
import 'package:watched_it_getx/app/modules/MediaDetail/views/media_detail_view.dart';

//TODO ADD DIFFERENT MEDIA TYPES HANDLING
//TODO ADD DETAIL PAGE ROUTE ON TILE CLICK
class MinimalMediaTile extends StatelessWidget {
  const MinimalMediaTile({
    Key? key,
    required this.media,
  }) : super(key: key);

  final MinimalMedia media;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        Get.to(
          () => MediaDetailView(),
          binding: MediaDetailBinding(),
          arguments: media,
          fullscreenDialog: true,
        );
      },
      child: Container(
        margin: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: media.posterPath == null
                    ? Image.asset('assets/images/no_image_placeholder.png')
                    : Image.network(
                        ImageUrl.getPosterImageUrl(
                          url: media.posterPath as String,
                          size: PosterSizes.w185,
                        ),
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      media.title,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Text(
                      "Premiere date: " + media.getDateString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
