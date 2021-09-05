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
  TvSeasonView({
    Key? key,
  }) : super(key: key);

  //final TvDetailController tvDetailController;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TvDetailController>(
      init: Get.find<TvDetailController>(
        tag: context.read<String>(),
      ),
      builder: (tvDetailController) => GetBuilder<TvSeasonsController>(
        init: TvSeasonsController(
          tag: context.read<String>(),
        ),
        tag: context.read<String>(),
        builder: (_) {
          return Obx(
            () {
              if (tvDetailController.isReady.value == false)
                return Center(
                  child: CircularProgressIndicator(),
                );
              else
                return ListView.builder(
                  itemCount: tvDetailController.tvShow?.seasons.length,
                  itemBuilder: (context, seasonIndex) {
                    return ExpansionTile(
                      //textColor: Colors.blue,
                      //collapsedTextColor: Colors.white,
                      tilePadding: EdgeInsets.all(8),
                      //backgroundColor: Colors.black38,
                      leading: tvDetailController
                                  .tvShow?.seasons[seasonIndex].posterPath ==
                              null
                          ? null
                          : Image.network(
                              ImageUrl.getPosterImageUrl(
                                url: tvDetailController.tvShow
                                    ?.seasons[seasonIndex].posterPath as String,
                                size: PosterSizes.w92,
                              ),
                            ),
                      title: Text(
                        "${seasonIndex + 1}. " +
                            (tvDetailController
                                .tvShow?.seasons[seasonIndex].name as String),
                      ),
                      subtitle: tvDetailController
                                  .tvShow?.seasons[seasonIndex].airDate ==
                              null
                          ? null
                          : Text(
                              "Air date: " +
                                  (tvDetailController
                                      .tvShow?.seasons[seasonIndex].airDate
                                      ?.getDashedDate() as String),
                            ),
                      onExpansionChanged: (isOpen) {
                        if (isOpen) _.retrieveInfo(seasonIndex);
                        //print(isOpen.toString());
                      },
                      children: [
                        Obx(
                          () {
                            if (_.seasonsInfo[seasonIndex] == null)
                              return Container(
                                height: MediaQuery.of(context).size.height / 2,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            else
                              return Container(
                                height: 300.0,
                                child: ListView.builder(
                                  itemCount: _.seasonsInfo[seasonIndex]!.details
                                      .episodes.length,
                                  itemBuilder: (context, episodeIndex) {
                                    return Obx(
                                      () => ListTile(
                                        onTap: () => _.getToEpisodeDetails(
                                          seasonNumber: _
                                              .seasonsInfo[seasonIndex]!
                                              .details
                                              .seasonNumber,
                                          episodeNumber: episodeIndex + 1,
                                        ),
                                        contentPadding: EdgeInsets.all(8),
                                        isThreeLine: _
                                                .seasonsInfo[seasonIndex]!
                                                .details
                                                .episodes[episodeIndex]
                                                .airDate !=
                                            null,
                                        leading: _
                                                    .seasonsInfo[seasonIndex]
                                                    ?.details
                                                    .episodes[episodeIndex]
                                                    .stillPath ==
                                                null
                                            ? null
                                            : Image.network(
                                                ImageUrl.getStillImageUrl(
                                                  url: _
                                                      .seasonsInfo[seasonIndex]
                                                      ?.details
                                                      .episodes[episodeIndex]
                                                      .stillPath as String,
                                                  size: StillSizes.w185,
                                                ),
                                              ),
                                        title: Text(
                                          "${episodeIndex + 1}. " +
                                              _
                                                  .seasonsInfo[seasonIndex]!
                                                  .details
                                                  .episodes[episodeIndex]
                                                  .name,
                                          // style: TextStyle(
                                          //   color: Colors.white,
                                          //   fontWeight: FontWeight.w500,
                                          // ),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                        ),
                                        subtitle: _
                                                    .seasonsInfo[seasonIndex]!
                                                    .details
                                                    .episodes[episodeIndex]
                                                    .airDate ==
                                                null
                                            ? null
                                            : Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Air date: ${_.seasonsInfo[seasonIndex]!.details.episodes[episodeIndex].airDate!.getDashedDate()}",
                                                    // style: TextStyle(
                                                    //   color: Colors.white,
                                                    // ),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .caption,
                                                  ),
                                                  Text(
                                                    "Vote average: ${_.seasonsInfo[seasonIndex]!.details.episodes[episodeIndex].voteAverage.toStringAsFixed(1)}",
                                                    // style: TextStyle(
                                                    //   color: Colors.grey,
                                                    // ),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .caption,
                                                  ),
                                                ],
                                              ),
                                        trailing: _
                                                    .seasonsInfo[seasonIndex]
                                                    ?.tvSeasonAccountStates
                                                    .episodeRatings[
                                                        episodeIndex]
                                                    .rated ==
                                                null
                                            ? OutlinedButton(
                                                onPressed: () => _.rateEpisode(
                                                  episodeIndex: episodeIndex,
                                                  seasonIndex: seasonIndex,
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
                                            : OutlinedButton(
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
                                                              .seasonsInfo[
                                                                  seasonIndex]
                                                              ?.tvSeasonAccountStates
                                                              .episodeRatings[
                                                                  episodeIndex]
                                                              .rated
                                                              .toString() as String) +
                                                          "/10",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .button,
                                                    ),
                                                  ],
                                                ),
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
      ),
    );
  }
}
