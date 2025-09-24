import 'package:accomodation_admin/features/superAdmin/side_panel/super_admin/model/admin_list_model.dart';
import 'package:accomodation_admin/features/superAdmin/side_panel/super_admin/view/admin_details_page.dart';
import 'package:accomodation_admin/widgets/custom_scafold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListAdminPage extends StatefulWidget {
  const ListAdminPage({super.key});

  @override
  State<ListAdminPage> createState() => _ListAdminPageState();
}

class _ListAdminPageState extends State<ListAdminPage> {
  // Dummy data list - in a real app, this would come from a database or API
  final List<AdminModel> _admins = [
    AdminModel(
        id: '1',
        name: 'John Doe',
        phone: '+1 123 456 7890',
        userId: 'johndoe',
        powers: ['Allocation', 'Reports']),
    AdminModel(
        id: '2',
        name: 'Jane Smith',
        phone: '+1 987 654 3210',
        userId: 'janesmith',
        powers: ['Vacation', 'Maintenance', 'Settings']),
    AdminModel(
        id: '3',
        name: 'Peter Jones',
        phone: '+1 555 555 5555',
        userId: 'peterj',
        powers: ['Extension', 'User Management']),
    AdminModel(
        id: '4',
        name: 'Mary Williams',
        phone: '+1 222 333 4444',
        userId: 'maryw',
        powers: [
          'Allocation',
          'Vacation',
          'Maintenance',
          'Extension',
          'Reports',
          'User Management',
          'Settings'
        ]),
  ];

  void _navigateToDetails(AdminModel admin) {
    Get.to(AdminDetailsPage(admin: admin));
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      // Adding an AppBar for better UI context
      appBar: AppBar(
        title: const Text('Admin List'),
        backgroundColor: const Color(0xFF382D1E),
        foregroundColor: Colors.white,
        elevation: 4.0,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: _admins.length,
            itemBuilder: (context, index) {
              final admin = _admins[index];
              return Card(
                elevation: 4.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ListTile(
                  onTap: () => _navigateToDetails(admin),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 16.0,
                  ),
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFF382D1E),
                    foregroundColor: Colors.white,
                    child: Text(admin.name[0]), // First initial
                  ),
                  title: Text(
                    admin.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text('UserID: ${admin.userId}'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
