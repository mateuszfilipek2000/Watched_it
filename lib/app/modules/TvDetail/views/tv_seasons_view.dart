import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/enums/media_type.dart';
import 'package:watched_it_getx/app/data/models/image_model.dart';
import 'package:watched_it_getx/app/modules/TvDetail/controllers/tv_detail_controller.dart';
import 'package:watched_it_getx/app/modules/TvDetail/controllers/tv_seasons_controller.dart';
import 'package:provider/provider.dart';
import 'package:watched_it_getx/app/data/extensions/date_helpers.dart';

class TvSeasonView extends StatelessWidget {
  TvSeasonView({Key? key, required String tag})
      : tvDetailController = Get.find<TvDetailController>(tag: tag),
        super(key: key);

  final TvDetailController tvDetailController;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TvSeasonsController>(
      init: TvSeasonsController(
        tag: "${describeEnum(MediaType.tv)}-${context.read<int>().toString()}",
      ),
      //TODO CHANGED ALL DETAIL MEDIA CONTROLLER TAGS TO STH LIKE THIS
      tag: "${describeEnum(MediaType.tv)}-${context.read<int>().toString()}",
      builder: (_) {
        return Obx(
          () {
            if (tvDetailController.isReady.value == false)
              return Center(
                child: CircularProgressIndicator(),
              );
            else
              return ListView.builder(
                itemCount: tvDetailController.tvShow?.numberOfSeasons,
                itemBuilder: (context, index) {
                  return ExpansionTile(
                    textColor: Colors.blue,
                    collapsedTextColor: Colors.white,
                    tilePadding: EdgeInsets.all(8),
                    backgroundColor: Colors.black38,
                    leading:
                        tvDetailController.tvShow?.seasons[index].posterPath ==
                                null
                            ? null
                            : Image.network(
                                ImageUrl.getPosterImageUrl(
                                  url: tvDetailController.tvShow?.seasons[index]
                                      .posterPath as String,
                                  size: PosterSizes.w92,
                                ),
                              ),
                    title: Text(
                      "${index + 1}. " +
                          (tvDetailController.tvShow?.seasons[index].name
                              as String),
                    ),
                    subtitle:
                        tvDetailController.tvShow?.seasons[index].airDate ==
                                null
                            ? null
                            : Text(
                                "Air date: " +
                                    (tvDetailController
                                        .tvShow?.seasons[index].airDate
                                        ?.getDashedDate() as String),
                              ),
                    onExpansionChanged: (isOpen) {
                      if (isOpen) _.retrieveInfo(index);
                      //print(isOpen.toString());
                    },
                    children: [
                      Obx(
                        () {
                          if (_.seasonsInfo[index] == null)
                            return Container(
                              height: 300.0,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          else
                            return Container(
                              height: 300.0,
                              //color: Colors.red,
                              child: ListView.builder(
                                itemCount: _.seasonsInfo[index]!.details
                                    .episodes.length,
                                itemBuilder: (context, i) {
                                  return ListTile(
                                    onTap: () => _.getToEpisodeDetails(
                                      seasonNumber: index + 1,
                                      episodeNumber: i + 1,
                                    ),
                                    contentPadding: EdgeInsets.all(8),
                                    isThreeLine: _.seasonsInfo[index]!.details
                                            .episodes[i].airDate ==
                                        null,
                                    leading: _.seasonsInfo[index]?.details
                                                .episodes[i].stillPath ==
                                            null
                                        ? null
                                        : Image.network(
                                            ImageUrl.getStillImageUrl(
                                              url: _
                                                  .seasonsInfo[index]
                                                  ?.details
                                                  .episodes[i]
                                                  .stillPath as String,
                                              size: StillSizes.w185,
                                            ),
                                          ),
                                    title: Text(
                                      "${i + 1}. " +
                                          _.seasonsInfo[index]!.details
                                              .episodes[i].name,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    subtitle: _.seasonsInfo[index]!.details
                                                .episodes[i].airDate ==
                                            null
                                        ? null
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Air date: ${_.seasonsInfo[index]!.details.episodes[i].airDate!.getDashedDate()}",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                "Vote average: ${_.seasonsInfo[index]!.details.episodes[i].voteAverage.toStringAsFixed(1)}",
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                    trailing: _
                                                .seasonsInfo[index]
                                                ?.tvSeasonAccountStates
                                                .episodeRatings[i]
                                                .rated ==
                                            null
                                        ? ElevatedButton(
                                            onPressed: () => _.rateEpisode(
                                              seasonNumber: _
                                                  .seasonsInfo[index]!
                                                  .details
                                                  .seasonNumber,
                                              episodeNumber: i + 1,
                                              seasonIndex: index,
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.star_rounded,
                                                  color: Colors.grey,
                                                ),
                                              ],
                                            ),
                                          )
                                        : ElevatedButton(
                                            onPressed: () {},
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.star_rounded,
                                                  color: Colors.yellow,
                                                ),
                                                Text(
                                                  (_
                                                          .seasonsInfo[index]
                                                          ?.tvSeasonAccountStates
                                                          .episodeRatings[i]
                                                          .rated
                                                          .toString() as String) +
                                                      "/10",
                                                ),
                                              ],
                                            ),
                                          ),
                                  );
                                },
                              ),
                            );
                        },
                      ),
                    ],
                  );
                },
              );
          },
        );
      },
    );
  }
}
