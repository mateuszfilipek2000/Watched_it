import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:watched_it_getx/app/modules/About/bindings/about_binding.dart';
import 'package:watched_it_getx/app/modules/About/views/about_view.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ListTile(
            title: Text("Dark mode"),
            trailing: Obx(
              () => Switch(
                onChanged: controller.changeTheme,
                value: controller.darkMode.value,
              ),
            ),
          ),
          ListTile(
            title: Text("About"),
            onTap: () => Get.to(
              () => AboutView(),
              binding: AboutBinding(),
              fullscreenDialog: true,
            ),
          ),
        ],
      ),
    );
  }
}
