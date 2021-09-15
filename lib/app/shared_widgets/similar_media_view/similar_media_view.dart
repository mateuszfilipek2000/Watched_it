import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/enums/media_type.dart';
import 'package:watched_it_getx/app/shared_widgets/imagecarousel/image_carousel.dart';
import 'package:watched_it_getx/app/shared_widgets/imagecarousel/image_carousel_controller.dart';
import 'package:provider/provider.dart';
import 'package:watched_it_getx/app/shared_widgets/poster_listview/poster_listview_object.dart';
import 'package:watched_it_getx/app/shared_widgets/similar_media_view/simiar_media_controller.dart';

class SimilarMediaView extends StatelessWidget {
  const SimilarMediaView({
    Key? key,
    required this.accountID,
    required this.data,
    required this.contentType,
  })  : assert(data.length >= 1),
        super(key: key);

  final int accountID;

  ///key - sorting method, value - objects that belongs to this sorting method
  final Map<String, List<PosterListviewObject>> data;

  //pass at least one content type, if you have more possible content types, then pass them in
  final List<MediaType> contentType;

  @override
  Widget build(BuildContext context) {
    return GetX<SimilarMediaController>(
      init: SimilarMediaController(
        tag: context.read<String>(),
        data: this.data,
        contentType: this.contentType,
        accountID: this.accountID,
      ),
      tag: context.read<String>(),
      builder: (_) {
        // if (_.results.length == 0) {
        //   return Center(
        //     child: CircularProgressIndicator(),
        //   );
        // } else {
        if (_.viewAsList.value) {
          return Column(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  //color: Colors.white,
                  color: Theme.of(context).primaryColor,
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(15)),
                ),
                child: Obx(
                  () => Align(
                    alignment: Alignment.topRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextButton(
                          onPressed: () => _.changeViewOption(),
                          child: Text(
                            "Change View",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
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
              Expanded(
                // height: double.infinity,
                // width: double.infinity,
                child: ListView.builder(
                  itemCount: _.currentItems.length,
                  itemBuilder: (context, index) => ListTile(
                    leading: _.currentItems[index].imagePath == null
                        ? null
                        : Image.network(
                            _.currentItems[index].imagePath!,
                          ),
                    title: Text(
                      _.currentItems[index].title,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    subtitle: _.currentItems[index].subtitle == null
                        ? null
                        : Text(
                            _.currentItems[index].subtitle!,
                            style: Theme.of(context).textTheme.caption,
                          ),
                    //TODO CANT RETRIEVE MORE THAN ONE ACCOUNT STATE AT ONCE, PLACING IT HERE WILL GENERATE A LOT OF REQUEST COMMENTING IT FOR NOW
                    // trailing: Row(
                    //   mainAxisSize: MainAxisSize.min,
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     Obx(
                    //       () => IconButton(
                    //         onPressed: () => _.changeFavourite(index: index),
                    //         icon: Icon(
                    //           Icons.favorite_rounded,
                    //           color: _.accountStates(index: index) != null
                    //               ? _.accountStates(index: index)!.favourite
                    //                   ? Colors.red
                    //                   : Colors.grey
                    //               : Colors.grey,
                    //         ),
                    //       ),
                    //     ),
                    //     Obx(
                    //       () => IconButton(
                    //         onPressed: () => _.changeWatchlist(index: index),
                    //         icon: Icon(
                    //           _.accountStates(index: index) != null
                    //               ? _.accountStates(index: index)!.watchlist
                    //                   ? Icons.bookmark_added_rounded
                    //                   : Icons.bookmark_add_rounded
                    //               : Icons.bookmark_add_rounded,
                    //           color: _.accountStates(index: index) != null
                    //               ? _.accountStates(index: index)!.watchlist
                    //                   ? Colors.blue
                    //                   : Colors.grey
                    //               : Colors.grey,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ),
                ),
              ),
            ],
          );
        } else
          return Stack(
            fit: StackFit.expand,
            children: [
              FittedBox(
                fit: BoxFit.cover,
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 200),
                  child: _.results[_.currentCarouselItem.value] == null
                      ? Container(
                          color: Colors.black,
                        )
                      : Image.network(
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
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      //color: Colors.white,
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                          bottomRight: const Radius.circular(15),
                          topRight: const Radius.circular(15)),
                    ),
                    child: TextButton(
                      onPressed: () => _.changeViewOption(),
                      child: Text(
                        "Change View",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
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
                            color: _.accountStates() != null
                                ? _.accountStates()!.favourite
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
                            _.accountStates() != null
                                ? _.accountStates()!.watchlist
                                    ? Icons.bookmark_added_rounded
                                    : Icons.bookmark_add_rounded
                                : Icons.bookmark_add_rounded,
                            color: _.accountStates() != null
                                ? _.accountStates()!.watchlist
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
                    tag: "smallCarouselController-${context.read<String>()}",
                    builder: (controller) {
                      return ImageCarousel(
                        height: 300.0,
                        imageUrls: _.results,
                        onPageChanged: (index) => _.handlePageChange(index),
                        tag:
                            "smallCarouselController-${context.read<String>()}",
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
                              _.subtitle.value,
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
        //}
      },
    );
  }
}
