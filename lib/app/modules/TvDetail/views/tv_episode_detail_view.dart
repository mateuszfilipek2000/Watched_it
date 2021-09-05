import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/shared_widgets/poster_listview/posterlistview.dart';
import 'package:watched_it_getx/app/modules/TvDetail/controllers/tv_episode_detail_controller.dart';
import 'package:watched_it_getx/app/shared_widgets/image_carousel_with_indicator/image_carousel_with_indicator.dart';
import 'package:watched_it_getx/app/shared_widgets/section.dart';

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
                        Section(
                          child: Container(
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
                        ),
                        Section(
                          sectionTitle: "Episode name",
                          width: double.infinity,
                          child: Text(
                            _.details.name,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        Section(
                          sectionTitle: "Overview",
                          child: Text(
                            _.details.overview,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ),
                        Section(
                          sectionTitle: "Cast",
                          child: PosterListView(
                            height: 270.0,
                            objects:
                                _.credits.getPosterListviewObjectsFromCast(),
                          ),
                        ),
                        Section(
                          sectionTitle: "Guest Stars",
                          child: PosterListView(
                            height: 270.0,
                            objects: _.credits
                                .getPosterListviewObjectsFromGuestStars(),
                          ),
                        ),
                        Section(
                          sectionTitle: "Crew",
                          child: PosterListView(
                            height: 270.0,
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
