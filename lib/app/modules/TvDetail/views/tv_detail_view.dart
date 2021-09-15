import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:watched_it_getx/app/data/enums/media_type.dart';
import 'package:watched_it_getx/app/modules/TvDetail/views/tv_overview_view.dart';
import 'package:watched_it_getx/app/modules/TvDetail/views/tv_reviews_view.dart';
import 'package:watched_it_getx/app/modules/TvDetail/views/tv_seasons_view.dart';
import 'package:watched_it_getx/app/shared_widgets/loading_placeholders/media_details_overview_placeholder.dart';
import 'package:watched_it_getx/app/shared_widgets/media_images_view/media_images_view.dart';
import 'package:watched_it_getx/app/shared_widgets/similar_media_view/similar_media_view.dart';
import '../controllers/tv_detail_controller.dart';

class TvDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<String>(
      create: (context) => "${describeEnum(MediaType.tv)}-${Get.arguments.id}",
      child: GetX<TvDetailController>(
        init: TvDetailController(),
        tag: "${describeEnum(MediaType.tv)}-${Get.arguments.id}",
        builder: (controller) => controller.isLoading.value
            ? MediaDetailsOverviewPlaceholder()
            : DefaultTabController(
                length: 5,
                child: SafeArea(
                  child: Scaffold(
                    floatingActionButton: FloatingActionButton(
                      backgroundColor: Colors.blue,
                      onPressed: controller.rateTv,
                      child: Icon(
                        Icons.star,
                      ),
                    ),
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
                      isScrollable: true,
                      tabs: [
                        Tab(
                          text: "Overview",
                        ),
                        Tab(
                          text: "Episodes",
                        ),
                        Tab(
                          text: "Images",
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
                        MediaImagesView(
                          tag:
                              "${describeEnum(MediaType.tv)}-${Get.arguments.id}",
                          images: controller.getAllImages(),
                        ),
                        SimilarMediaView(
                          accountID: controller.user?.id as int,
                          data: controller.getSortingOptionsWithData(),
                          contentType: [MediaType.tv],
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
