import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:accomodation_admin/features/superAdmin/side_panel/super_admin/view/create_admin.dart';
import 'package:accomodation_admin/features/superAdmin/side_panel/super_admin/view/list_admin.dart';
import 'package:accomodation_admin/features/superAdmin/side_panel/super_admin/view/create_room_page.dart';
import 'package:accomodation_admin/features/superAdmin/side_panel/super_admin/view/room_list.dart';

final GoRouter _router = GoRouter(
  initialLocation: '/create-admin', // Set the initial location (Home page)
  routes: [
    GoRoute(
      path: '/create-admin',
      builder: (context, state) => const CreateAdminPage(),
    ),
    GoRoute(
      path: '/list-admin',
      builder: (context, state) => const ListAdminPage(),
    ),
    GoRoute(
      path: '/create-room',
      builder: (context, state) => const CreateRoomPage(),
    ),
    GoRoute(
      path: '/manage-rooms',
      builder: (context, state) => const RoomListPage(),
    ),
  ],
);

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       routerConfig: _router,
//       title: 'Accommodation Admin',
//     );
//   }
// }
