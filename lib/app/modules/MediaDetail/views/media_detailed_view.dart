import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:provider/provider.dart';
import 'package:watched_it_getx/app/modules/MediaDetail/controllers/media_detailed_controller.dart';

class MediaDetailedView extends StatelessWidget {
  const MediaDetailedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<int>(
      create: (context) => Get.arguments.id,
      child: GetBuilder<MediaDetailedController>(
        init: MediaDetailedController(),
        tag: Get.arguments.id.toString(),
        builder: (controller) => Obx(
          () => DefaultTabController(
            length: controller.tabs.length,
            child: controller.tabs.length == 0
                ? Center(child: CircularProgressIndicator())
                : SafeArea(
                    child: Scaffold(
                      // floatingActionButton: FloatingActionButton(
                      //   onPressed: controller.openMediaRatingDialog,
                      //   child: Icon(
                      //     Icons.star,
                      //   ),
                      // ),
                      backgroundColor: Color(0xFF1c1d25),
                      bottomNavigationBar: Material(
                        color: Color(0xFF151515),
                        child: TabBar(
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
                          tabs: controller.tabs,
                          // tabs: [
                          //   Tab(
                          //     text: "Overview",
                          //   ),
                          //   Tab(
                          //     text: "Overview",
                          //   ),
                          //   Tab(
                          //     text: "Similar",
                          //   ),
                          //   Tab(
                          //     text: "Reviews",
                          //   ),
                          // ],
                        ),
                      ),
                      body: TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        children: controller.pages,
                        // children: [
                        //   MovieOverviewView(),
                        //   Text("2"),
                        //   SimilarMoviesView(),
                        //   MediaReviewScreen(),
                        // ],
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
