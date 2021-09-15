import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:watched_it_getx/app/general/theme/app_theme.dart';

import 'app/routes/app_pages.dart';

void main() async {
  await GetStorage.init();
  GetStorage().writeIfNull("darkmode", true);
  runApp(
    GetMaterialApp(
      darkTheme: Themes.dark,
      themeMode: GetStorage().read("darkmode") == true
          ? ThemeMode.dark
          : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      title: "Watched It",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
