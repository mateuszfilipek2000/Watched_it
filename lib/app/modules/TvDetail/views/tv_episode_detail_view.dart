import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/shared_widgets/poster_listview/posterlistview.dart';
import 'package:watched_it_getx/app/modules/TvDetail/controllers/tv_episode_detail_controller.dart';
import 'package:watched_it_getx/app/shared_widgets/image_carousel_with_indicator/image_carousel_with_indicator.dart';

class TvEpisodeDetailView extends StatelessWidget {
  const TvEpisodeDetailView({
    Key? key,
    required this.tag,
  }) : super(key: key);

  final String tag;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TvEpisodeDetailController>(
      init: TvEpisodeDetailController(),
      tag: tag,
      builder: (_) {
        return Scaffold(
          backgroundColor: Color(0xFF1c1d25),
          body: SafeArea(
            child: Obx(
              () {
                if (_.isReady.value == false) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          height: 250.0,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              ImageCarouselWithIndicator(
                                height: 250.0,
                                imageUrls: _.images.getStillsUrls(),
                                navigationIndicatorAlignment:
                                    Alignment.topRight,
                                tag: tag,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Container(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Padding(
                                        padding: EdgeInsets.only(bottom: 5.0),
                                        child: Text(
                                          "Episode name: ",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                    FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text(
                                        _.details.name,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25.0,
                                          //fontWeight: FontWeight.w300,
                                        ),
                                        maxLines: 3,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: Container(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: Text(
                                    "Overview:",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Text(
                                  _.details.overview,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    //fontWeight: FontWeight.w500,
                                  ),
                                  //overflow: TextOverflow.ellipsis,
                                  //maxLines: 5,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10.0),
                          child: PosterListView(
                            listTitle: "Cast",
                            height: 300.0,
                            objects:
                                _.credits.getPosterListviewObjectsFromCast(),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10.0),
                          child: PosterListView(
                            listTitle: "Guest Stars",
                            height: 300.0,
                            objects: _.credits
                                .getPosterListviewObjectsFromGuestStars(),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10.0),
                          child: PosterListView(
                            listTitle: "Crew",
                            height: 300.0,
                            objects:
                                _.credits.getPosterListviewObjectsFromCrew(),
                          ),
                        ),
                      ],
                    ),
                  );
              },
            ),
          ),
        );
      },
    );
  }
}
