import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:watched_it_getx/app/data/enums/media_type.dart';
import 'package:watched_it_getx/app/data/services/user_service.dart';
import 'package:watched_it_getx/app/modules/PersonDetail/controllers/person_detail_controller.dart';
import 'package:watched_it_getx/app/modules/PersonDetail/views/person_images_view.dart';
import 'package:watched_it_getx/app/modules/PersonDetail/views/person_overview_view.dart';
import 'package:watched_it_getx/app/shared_widgets/similar_media_view/similar_media_view.dart';

class PersonDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<String>(
      create: (context) =>
          "${describeEnum(MediaType.person)}-${Get.arguments.id}",
      child: GetBuilder<PersonDetailController>(
        init: PersonDetailController(),
        tag: "${describeEnum(MediaType.person)}-${Get.arguments.id}",
        builder: (controller) => Obx(
          () => controller.isReady.value == false
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : DefaultTabController(
                  length: 3,
                  child: SafeArea(
                    child: Scaffold(
                      //backgroundColor: Theme.of(context).colorScheme.background,
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
                            text: "About",
                          ),
                          Tab(
                            text: "Known for",
                          ),
                          Tab(
                            text: "Images",
                          ),
                        ],
                      ),
                      body: TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          PersonOverviewView(),
                          SimilarMediaView(
                            data: controller.getCreditsData(),
                            accountID: Get.find<UserService>().user.id,
                            contentType: [MediaType.movie, MediaType.tv],
                          ),
                          PersonImagesView(),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
