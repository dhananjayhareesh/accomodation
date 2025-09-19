import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'local_storage/shared_pref.dart';
import 'routes/route_pages.dart';
import 'routes/route_path.dart';
import 'themes/theme.dart';
import 'utils/navigator_key_utils.dart';

void main() async {
  await MySharedPref.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigatorKeyHelper.navigatorKey,
      title: 'Flutter Demo',
      theme: CustomThemes.themeDataLight(),
      darkTheme: CustomThemes.themeDataDark(),
      themeMode: ThemeMode.system,
      getPages: RoutePages.routes,
      initialRoute: RoutePath.initial,
    );
  }
}
