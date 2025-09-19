import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../features/splash_screen/splash_screen.dart';
import 'route_path.dart';

class RoutePages {
  static const transition = Transition.fadeIn;
  static final routes = [
    GetPage(
      name: RoutePath.initial,
      page: () => const SplashScreen(),
      transition: transition,
    ),
  ];
}
