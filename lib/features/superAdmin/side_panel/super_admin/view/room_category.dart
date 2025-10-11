// room_category_page.dart

import 'package:accomodation_admin/features/superAdmin/side_panel/super_admin/asramCreation/controller/room_cat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:accomodation_admin/widgets/custom_scafold.dart';

class RoomCategoryPage extends StatelessWidget {
  const RoomCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Instantiate the controller
    final RoomCategoryController controller = Get.put(RoomCategoryController());

    // This local list will be updated after a successful API call.
    // For a full solution, this list should also be in the controller and fetched from an API.
    final RxList<Map<String, dynamic>> categories = RxList([
      {
        "name": "Deluxe Room",
        "allotee": "1000",
        "donor": "800",
        "general": "1200",
        "staff": "600",
        "asram": "Himalayan Ashram",
        "asramId": "123e4567-e89b-12d3-a456-426614174000"
      },
      {
        "name": "Dormitory",
        "allotee": "300",
        "donor": "250",
        "general": "400",
        "staff": "200",
        "asram": "Vrindavan Ashram",
        "asramId": "123e4567-e89b-12d3-a456-426614174001"
      },
    ]);

    // Local state for the filter dropdown
    final _selectedAsramFilter = "All".obs;

    // Controllers for the dialog TextFields
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _alloteeController = TextEditingController();
    final TextEditingController _donorController = TextEditingController();
    final TextEditingController _generalController = TextEditingController();
    final TextEditingController _staffController = TextEditingController();

    void _showCategoryDialog({Map<String, dynamic>? existing, int? index}) {
      // Use RxString for the dialog's dropdown state
      final Rx<String?> selectedAsramId = Rx(null);

      if (existing != null) {
        _nameController.text = existing["name"] ?? "";
        _alloteeController.text = existing["allotee"] ?? "";
        _donorController.text = existing["donor"] ?? "";
        _generalController.text = existing["general"] ?? "";
        _staffController.text = existing["staff"] ?? "";
        selectedAsramId.value = existing["asramId"];
      } else {
        _nameController.clear();
        _alloteeController.clear();
        _donorController.clear();
        _generalController.clear();
        _staffController.clear();
        // Set a default value if asram list is not empty
        if (controller.asramList.isNotEmpty) {
          selectedAsramId.value = controller.asramList.first.id;
        }
      }

      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        existing == null
                            ? "Create Room Category"
                            : "Edit Room Category",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 20),
                      // Asram Dropdown - Fetched from API
                      Obx(() => DropdownButtonFormField<String>(
                            value: selectedAsramId.value,
                            items: controller.asramList.map((asram) {
                              return DropdownMenuItem(
                                value: asram.id,
                                child: Text(asram.name ?? "Unknown"),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                              labelText: "Select Asram",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            onChanged: (val) {
                              selectedAsramId.value = val;
                            },
                            validator: (value) =>
                                value == null ? 'Please select an asram' : null,
                          )),
                      const SizedBox(height: 14),
                      _buildTextField("Category Name", _nameController),
                      const SizedBox(height: 14),
                      _buildTextField("Tariff (Allotee)", _alloteeController,
                          isNumber: true),
                      const SizedBox(height: 14),
                      _buildTextField("Tariff (Donor)", _donorController,
                          isNumber: true),
                      const SizedBox(height: 14),
                      _buildTextField("Tariff (General)", _generalController,
                          isNumber: true),
                      const SizedBox(height: 14),
                      _buildTextField(
                          "Tariff (Working Staff)", _staffController,
                          isNumber: true),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            child: const Text("Cancel"),
                            onPressed: () => Navigator.pop(context),
                          ),
                          const SizedBox(width: 12),
                          // Use Obx to show loading indicator on the button
                          Obx(
                            () => ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                              ),
                              onPressed: controller.isCreatingCategory.value
                                  ? null
                                  : () async {
                                      if (_nameController.text.isNotEmpty &&
                                          selectedAsramId.value != null) {
                                        final selectedAsram = controller
                                            .asramList
                                            .firstWhere((a) =>
                                                a.id == selectedAsramId.value);

                                        bool success =
                                            await controller.createRoomCategory(
                                          name: _nameController.text,
                                          asramId: selectedAsram.id!,
                                          asramName: selectedAsram.name!,
                                          allotee: _alloteeController.text,
                                          donor: _donorController.text,
                                          general: _generalController.text,
                                          staff: _staffController.text,
                                        );

                                        if (success) {
                                          // For now, we add to the local list. Ideally, you'd refresh the list from the server.
                                          if (existing == null) {
                                            categories.add({
                                              "name": _nameController.text,
                                              "allotee":
                                                  _alloteeController.text,
                                              "donor": _donorController.text,
                                              "general":
                                                  _generalController.text,
                                              "staff": _staffController.text,
                                              "asram": selectedAsram.name!,
                                              "asramId": selectedAsram.id!
                                            });
                                          } else {
                                            // Update logic here...
                                          }
                                          Navigator.pop(context);
                                        }
                                      }
                                    },
                              child: controller.isCreatingCategory.value
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ))
                                  : Text(
                                      existing == null ? "Create" : "Update"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    }

    return CustomScaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Manage Room Categories",
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                // Filter Dropdown
                Obx(() {
                  if (controller.isLoadingAsrams.value) {
                    return const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator());
                  }
                  // Create a list for the filter that includes "All"
                  List<DropdownMenuItem<String>> filterItems = [
                    const DropdownMenuItem(value: "All", child: Text("All")),
                    ...controller.asramList.map((asram) => DropdownMenuItem(
                          value: asram.name, // Filter by name
                          child: Text(asram.name ?? "Unknown"),
                        ))
                  ];

                  return DropdownButton<String>(
                    value: _selectedAsramFilter.value,
                    items: filterItems,
                    onChanged: (val) {
                      _selectedAsramFilter.value = val!;
                    },
                  );
                }),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                final filteredCategories = _selectedAsramFilter.value == "All"
                    ? categories
                    : categories
                        .where((c) => c["asram"] == _selectedAsramFilter.value)
                        .toList();

                return filteredCategories.isEmpty
                    ? const Center(
                        child: Text("No categories found.",
                            style: TextStyle(color: Colors.grey, fontSize: 16)))
                    : SingleChildScrollView(
                        child: Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          children: List.generate(
                            filteredCategories.length,
                            (index) {
                              final category = filteredCategories[index];
                              // Find the original index for delete/edit operations
                              final originalIndex =
                                  categories.indexOf(category);
                              return _buildCategoryCard(category, originalIndex,
                                  () {
                                // Edit function
                                _showCategoryDialog(
                                    existing: category, index: originalIndex);
                              }, () {
                                // Delete function
                                categories.removeAt(originalIndex);
                              });
                            },
                          ),
                        ),
                      );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCategoryDialog(),
        icon: const Icon(Icons.add),
        label: const Text("Add Category"),
      ),
    );
  }

  // --- Helper Widgets remain mostly the same ---

  Widget _buildCategoryCard(Map<String, dynamic> category, int index,
      VoidCallback onEdit, VoidCallback onDelete) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Container(
          width: 300,
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Text(category["name"] ?? "",
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w700),
                          overflow: TextOverflow.ellipsis)),
                  PopupMenuButton<String>(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    onSelected: (value) {
                      if (value == "edit")
                        onEdit();
                      else if (value == "delete") onDelete();
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                          value: "edit",
                          child: Row(children: [
                            Icon(Icons.edit, size: 18),
                            SizedBox(width: 8),
                            Text("Edit")
                          ])),
                      const PopupMenuItem(
                          value: "delete",
                          child: Row(children: [
                            Icon(Icons.delete, size: 18, color: Colors.red),
                            SizedBox(width: 8),
                            Text("Delete")
                          ])),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 6),
              Text(category["asram"] ?? "-",
                  style: const TextStyle(fontSize: 13, color: Colors.black54)),
              const Divider(),
              _buildTariffRow("Allotee", category["allotee"]),
              _buildTariffRow("Donor", category["donor"]),
              _buildTariffRow("General", category["general"]),
              _buildTariffRow("Working Staff", category["staff"]),
            ],
          )),
    );
  }

  Widget _buildTariffRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(fontSize: 14, color: Colors.black54)),
          Text("₹${value ?? "-"}",
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool isNumber = false}) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
