import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/enums/media_type.dart';
import 'package:watched_it_getx/app/data/models/similar_media.dart';
import 'package:watched_it_getx/app/shared_widgets/imagecarousel/image_carousel.dart';
import 'package:watched_it_getx/app/shared_widgets/imagecarousel/image_carousel_controller.dart';
import 'package:provider/provider.dart';
import 'package:watched_it_getx/app/shared_widgets/similar_media_view/simiar_media_controller.dart';

class SimilarMediaView extends StatelessWidget {
  const SimilarMediaView({
    Key? key,
    required this.accountID,
    // required this.recommendations,
    // required this.similar,
    required this.data,
    required this.contentType,
  })  : assert(data.length >= 1),
        super(key: key);

  final int accountID;
  // final List<SimilarMedia> recommendations;
  // final List<SimilarMedia> similar;

  ///key - sorting method, value - objects that belongs to this sorting method
  final Map<String, List<SimilarMedia>> data;
  final MediaType contentType;

  @override
  Widget build(BuildContext context) {
    return GetX<SimilarMediaController>(
      init: SimilarMediaController(
        tag: context.read<int>().toString(),
        data: this.data,
        contentType: this.contentType,
        accountID: this.accountID,
      ),
      tag: context.read<int>().toString(),
      builder: (_) {
        if (_.results.length == 0) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Stack(
            fit: StackFit.expand,
            children: [
              FittedBox(
                fit: BoxFit.cover,
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 200),
                  child: Image.network(
                    _.results[_.currentCarouselItem.value] as String,
                    key: UniqueKey(),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 5,
                  sigmaY: 5,
                ),
                child: Container(
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    //color: Colors.white,
                    color: Theme.of(context).primaryColor,
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(15)),
                  ),
                  child: Obx(
                    () => Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        for (var i = 0; i < _.sortingOptions.length; i++)
                          TextButton(
                            onPressed: () => _.changeSortingOption(i),
                            child: Text(
                              _.sortingOptions[i],
                              style: TextStyle(
                                color: _.selectedSortingOption.value == i
                                    ? Colors.blue
                                    : Colors.grey,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    //color: Colors.white,
                    color: Theme.of(context).primaryColor,
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(15)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => IconButton(
                          onPressed: () => _.changeFavourite(),
                          icon: Icon(
                            Icons.favorite_rounded,
                            color: _.accountStates.value != null
                                ? _.accountStates.value?.favourite as bool
                                    ? Colors.red
                                    : Colors.grey
                                : Colors.grey,
                          ),
                        ),
                      ),
                      Obx(
                        () => IconButton(
                          onPressed: () => _.changeWatchlist(),
                          icon: Icon(
                            _.accountStates.value != null
                                ? _.accountStates.value?.watchlist as bool
                                    ? Icons.bookmark_added_rounded
                                    : Icons.bookmark_add_rounded
                                : Icons.bookmark_add_rounded,
                            color: _.accountStates.value != null
                                ? _.accountStates.value?.watchlist as bool
                                    ? Colors.blue
                                    : Colors.grey
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GetBuilder<ImageCarouselController>(
                    init: ImageCarouselController(
                      pageController: _.carouselController,
                      minimumChildScale: 0.6,
                    ),
                    tag:
                        "smallCarouselController-${context.read<int>().toString()}",
                    builder: (controller) {
                      return ImageCarousel(
                        height: 300.0,
                        imageUrls: _.results,
                        onPageChanged: (index) => _.handlePageChange(index),
                        tag:
                            "smallCarouselController-${context.read<int>().toString()}",
                        onTap: _.getToMediaDetailPage,
                        controller: controller,
                      );
                    },
                  ),
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 200),
                    child: Container(
                      key: UniqueKey(),
                      margin: EdgeInsets.all(10.0),
                      padding: EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      //height: 100.0,
                      width: double.infinity,
                      child: Obx(
                        () => Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                _.title.value,
                                // style: TextStyle(
                                //   color: Colors.white,
                                //   fontSize: 30.0,
                                // ),
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ),
                            Text(
                              _.releaseDate.value,
                              //style: TextStyle(color: Colors.white),
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        }
      },
    );
  }
}
