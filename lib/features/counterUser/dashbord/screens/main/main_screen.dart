import 'package:accomodation_admin/features/counterUser/responsive.dart';
import 'package:accomodation_admin/features/counterUser/dashbord/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';

import 'components/side_menu.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  // Directly define a scaffold key here
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Show side menu only for desktop
            if (Responsive.isDesktop(context))
              const Expanded(
                // default flex = 1 -> takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // Takes 5/6 part of the screen
              flex: 5,
              child: DashboardScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
