import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:watched_it_getx/app/data/enums/media_type.dart';
import 'package:watched_it_getx/app/data/services/user_service.dart';
import 'package:watched_it_getx/app/modules/MovieDetail/views/media_review_view.dart';
import 'package:watched_it_getx/app/modules/MovieDetail/views/movie_overview_view.dart';
import 'package:watched_it_getx/app/shared_widgets/loading_placeholders/media_details_images_placeholder.dart';
import 'package:watched_it_getx/app/shared_widgets/loading_placeholders/media_details_overview_placeholder.dart';
import 'package:watched_it_getx/app/shared_widgets/loading_placeholders/media_details_reviews_placeholder.dart';
import 'package:watched_it_getx/app/shared_widgets/media_images_view/media_images_view.dart';
import 'package:watched_it_getx/app/shared_widgets/similar_media_view/similar_media_view.dart';
import '../controllers/movie_detail_controller.dart';

class MovieDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<String>(
      create: (context) =>
          "${describeEnum(MediaType.movie)}-${Get.arguments.id}",
      child: GetBuilder<MovieDetailController>(
        init: MovieDetailController(),
        tag: "${describeEnum(MediaType.movie)}-${Get.arguments.id}",
        builder: (controller) => DefaultTabController(
          length: 4,
          child: SafeArea(
            child: Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: controller.rateMovie,
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
                tabs: [
                  Tab(
                    text: "Overview",
                  ),
                  Tab(
                    text: "Images",
                  ),
                  Tab(
                    text: "Similar",
                  ),
                  Tab(
                    text: "Reviews",
                  ),
                ],
              ),
              body: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  controller.isReady == false
                      ? MediaDetailsOverviewPlaceholder()
                      : MovieOverviewView(),
                  controller.movieImages == null
                      ? MediaDetailsImageViewPlaceholder()
                      : MediaImagesView(
                          tag:
                              "${describeEnum(MediaType.movie)}-${Get.arguments.id}",
                          images: controller.getAllImages(),
                        ),
                  controller.isReady == false
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : SimilarMediaView(
                          accountID: Get.find<UserService>().user.id,
                          data: controller.getSortingOptionsWithData(),
                          contentType: [MediaType.movie],
                        ),
                  controller.isReady == false
                      ? Center(
                          child: MediaDetailsReviewsViewPlaceholder(),
                        )
                      : MediaReviewView(
                          fetchReviews: controller.fetchReviews,
                          id: Get.arguments.id,
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
