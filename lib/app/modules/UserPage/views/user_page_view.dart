import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:watched_it_getx/app/data/models/image_model.dart';

import '../controllers/user_page_controller.dart';

class UserPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserPageController>(
      init: UserPageController(),
      builder: (_) {
        if (_.user == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView(
            children: [
              Container(
                child: Image.network(
                  ImageUrl.getProfileImageUrl(
                    url: _.user?.avatar_Path as String,
                    size: ProfileSizes.w185,
                  ),
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
              Center(
                child: Text(
                  _.user?.name as String,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
