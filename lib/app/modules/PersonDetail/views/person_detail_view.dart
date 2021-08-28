import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:watched_it_getx/app/data/enums/media_type.dart';
import 'package:watched_it_getx/app/data/models/tv/tv_similar_shows.dart';
import 'package:watched_it_getx/app/modules/PersonDetail/controllers/person_detail_controller.dart';
import 'package:watched_it_getx/app/modules/PersonDetail/views/person_know_for_view.dart';
import 'package:watched_it_getx/app/modules/PersonDetail/views/person_overview_view.dart';
import 'package:watched_it_getx/app/modules/TvDetail/views/tv_overview_view.dart';
import 'package:watched_it_getx/app/modules/TvDetail/views/tv_seasons_view.dart';
import 'package:watched_it_getx/app/shared_widgets/similar_media_view/similar_media_view.dart';

class PersonDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<int>(
      create: (context) => Get.arguments.id,
      child: GetBuilder<PersonDetailController>(
        init: PersonDetailController(),
        tag: "${describeEnum(MediaType.person)}-${Get.arguments.id}",
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
                  tabs: [
                    Tab(
                      text: "Overview",
                    ),
                    Tab(
                      text: "Know for",
                    ),
                    Tab(
                      text: "Images",
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  PersonOverviewView(
                    tag:
                        "${describeEnum(MediaType.person)}-${Get.arguments.id}",
                  ),
                  PersonKnowForView(
                    tag:
                        "${describeEnum(MediaType.person)}-${Get.arguments.id}",
                  ),
                  Text("3"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
