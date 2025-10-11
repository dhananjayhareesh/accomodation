// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'local_storage/shared_pref.dart';
// import 'routes/route_pages.dart';
// import 'routes/route_path.dart';
// import 'themes/theme.dart';
// import 'utils/navigator_key_utils.dart';

// void main() async {
//   await MySharedPref.init();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       navigatorKey: NavigatorKeyHelper.navigatorKey,
//       title: 'Flutter Demo',
//       theme: CustomThemes.themeDataLight(),
//       darkTheme: CustomThemes.themeDataDark(),
//       themeMode: ThemeMode.system,
//       getPages: RoutePages.routes,
//       initialRoute: RoutePath.initial,
//     );
//   }
// }

import 'package:accomodation_admin/features/counterUser/constants.dart';
import 'package:accomodation_admin/services/api_constants.dart';
import 'package:accomodation_admin/utils/enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'local_storage/shared_pref.dart';
import 'routes/route_pages.dart';
import 'routes/route_path.dart';
import 'utils/navigator_key_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BaseUrl.buildType = AppBuild.prod;
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
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ).apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      // if you still want to keep light/dark switchable themes from CustomThemes,
      // you can use below instead of overriding completely:
      // theme: CustomThemes.themeDataLight(),
      // darkTheme: CustomThemes.themeDataDark(),
      // themeMode: ThemeMode.system,
      getPages: RoutePages.routes,
      initialRoute: RoutePath.initial,
    );
  }
}
