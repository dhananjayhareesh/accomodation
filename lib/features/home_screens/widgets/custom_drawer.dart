import 'package:accomodation_admin/features/side_panel/super_admin/view/create_admin.dart';
import 'package:accomodation_admin/features/side_panel/super_admin/view/create_room_page.dart';
import 'package:accomodation_admin/features/side_panel/super_admin/view/list_admin.dart';
import 'package:accomodation_admin/features/side_panel/super_admin/view/room_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDrawer extends StatelessWidget {
  final Function(String) onItemTapped;

  const CustomDrawer({required this.onItemTapped, super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 6,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFe2f1f9), Color(0xFFffffff)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // Header with logo and subtle shadow
            const DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 48,
                      backgroundImage: AssetImage('assets/png/logo.png'),
                      backgroundColor: Colors.white,
                    ),
                    SizedBox(height: 12),
                  ],
                ),
              ),
            ),

            // Menu items list
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: [
                  _buildDrawerItem(
                      'Create Admin', Icons.admin_panel_settings, context),
                  _buildDrawerItem('List Admin', Icons.list_alt, context),
                  _buildDrawerItem(
                      'Settings', Icons.settings_outlined, context),
                  _buildDrawerItem(
                      'Create Room', Icons.meeting_room_outlined, context),
                  _buildDrawerItem(
                      'Manage Rooms', Icons.manage_history, context),
                  const Divider(
                    thickness: 1,
                    color: Colors.black26,
                    indent: 8,
                    endIndent: 8,
                  ),
                  _buildDrawerItem('Logout', Icons.exit_to_app, context,
                      color: Colors.red),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Drawer Item with card-style look
  Widget _buildDrawerItem(String title, IconData icon, BuildContext context,
      {Color color = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => _navigateToPage(title),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(icon, color: color, size: 22),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Handle navigation
  void _navigateToPage(String page) {
    switch (page) {
      case 'Create Admin':
        Get.to(() => const CreateAdminPage());
        break;
      case 'List Admin':
        Get.to(() => const ListAdminPage());
        break;
      case 'Create Room':
        Get.to(() => const CreateRoomPage());
        break;
      case 'Manage Rooms':
        Get.to(() => const RoomListPage());
      default:
        break;
    }
  }
}
