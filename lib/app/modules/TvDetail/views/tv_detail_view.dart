import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../controllers/tv_detail_controller.dart';

class TvDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<int>(
      create: (context) => Get.arguments.id,
      child: GetBuilder<TvDetailController>(
        init: TvDetailController(),
        tag: Get.arguments.id.toString(),
        builder: (controller) => DefaultTabController(
          length: controller.tabs.length,
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
                  tabs: controller.tabs,
                ),
              ),
              body: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: controller.pages,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
