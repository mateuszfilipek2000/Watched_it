import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController {
  RxBool darkMode = RxBool(GetStorage().read("darkmode"));

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void changeTheme(bool val) async {
    await GetStorage().write("darkmode", val);
    Get.changeThemeMode(
      val == false ? ThemeMode.light : ThemeMode.dark,
    );
    darkMode.value = val;
  }
}
