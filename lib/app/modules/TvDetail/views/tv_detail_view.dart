import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:watched_it_getx/app/data/enums/media_type.dart';
import 'package:watched_it_getx/app/data/models/tv/tv_similar_shows.dart';
import 'package:watched_it_getx/app/modules/TvDetail/views/tv_overview_view.dart';
import 'package:watched_it_getx/app/modules/TvDetail/views/tv_reviews_view.dart';
import 'package:watched_it_getx/app/modules/TvDetail/views/tv_seasons_view.dart';
import 'package:watched_it_getx/app/shared_widgets/similar_media_view/similar_media_view.dart';
import '../controllers/tv_detail_controller.dart';

class TvDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<String>(
      create: (context) => "${describeEnum(MediaType.tv)}-${Get.arguments.id}",
      child: GetBuilder<TvDetailController>(
        init: TvDetailController(),
        tag: "${describeEnum(MediaType.tv)}-${Get.arguments.id}",
        builder: (controller) => DefaultTabController(
          length: 4,
          child: SafeArea(
            child: Scaffold(
              // floatingActionButton: FloatingActionButton(
              //   onPressed: controller.openMediaRatingDialog,
              //   child: Icon(
              //     Icons.star,
              //   ),
              // ),
              bottomNavigationBar: TabBar(
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 3.0,
                  ),
                  insets: EdgeInsets.only(bottom: 45),
                ),
                indicatorColor: Colors.blue,
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(
                    text: "Overview",
                  ),
                  Tab(
                    text: "Episodes",
                  ),
                  Tab(
                    text: "More",
                  ),
                  Tab(
                    text: "Reviews",
                  ),
                ],
              ),
              body: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  TvOverviewView(),
                  TvSeasonView(),
                  Obx(
                    () {
                      if (controller.isReady.value == false)
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      else
                        return SimilarMediaView(
                          accountID: controller.user?.id as int,
                          data: controller.getSortingOptionsWithData(),
                          contentType: [MediaType.tv],
                        );
                    },
                  ),
                  TvReviewsView(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
