import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:watched_it_getx/app/general/theme/app_theme.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      darkTheme: Themes.dark,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      title: "Watched It",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
