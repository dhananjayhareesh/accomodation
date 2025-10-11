import 'package:accomodation_admin/features/superAdmin/side_panel/super_admin/asramCreation/controller/asrm_creation_controller.dart';
import 'package:accomodation_admin/features/superAdmin/side_panel/super_admin/asramCreation/model/asram_list_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:accomodation_admin/widgets/custom_scafold.dart';

class ManageAsramPage extends StatefulWidget {
  const ManageAsramPage({super.key});

  @override
  State<ManageAsramPage> createState() => _ManageAsramPageState();
}

class _ManageAsramPageState extends State<ManageAsramPage> {
  final AsrmCreationController _controller = Get.put(AsrmCreationController());

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadAsramList(); // 👈 Load API data on page open
  }

  Future<void> _loadAsramList() async {
    await _controller
        .fetchAsramList(); // calls repo -> controller -> updates list
  }

  void _showAsramDialog({Datum? existing}) {
    if (existing != null) {
      _nameController.text = existing.name;
      _locationController.text = existing.location;
    } else {
      _nameController.clear();
      _locationController.clear();
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
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    existing == null ? "Create Asram" : "Edit Asram",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: "Name of Asram",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: _locationController,
                    decoration: InputDecoration(
                      labelText: "Location",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: const Text("Cancel"),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 12),
                      Obx(() {
                        final isBusy = _controller.isLoading.value;
                        return ElevatedButton(
                          onPressed: isBusy
                              ? null
                              : () async {
                                  final name = _nameController.text.trim();
                                  final loc = _locationController.text.trim();
                                  if (name.isEmpty || loc.isEmpty) return;

                                  await _controller.createAsram(
                                      name: name, location: loc);
                                  await _loadAsramList(); // 👈 refresh after creation
                                  if (context.mounted) Navigator.pop(context);
                                },
                          child: isBusy
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2, color: Colors.white),
                                )
                              : Text(existing == null ? "Create" : "Update"),
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _confirmDelete(Datum item) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete Asram"),
        content: Text("Are you sure you want to delete '${item.name}'?"),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              _controller.asramList.remove(item);
              Navigator.pop(context);
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  Widget _buildAsramCard(Datum asram) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 260,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.temple_buddhist,
                    size: 28, color: Colors.deepPurple.shade400),
                PopupMenuButton<String>(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  onSelected: (value) {
                    if (value == "edit") {
                      _showAsramDialog(existing: asram);
                    } else if (value == "delete") {
                      _confirmDelete(asram);
                    }
                  },
                  itemBuilder: (context) => const [
                    PopupMenuItem(
                      value: "edit",
                      child: Row(children: [
                        Icon(Icons.edit, size: 18),
                        SizedBox(width: 8),
                        Text("Edit")
                      ]),
                    ),
                    PopupMenuItem(
                      value: "delete",
                      child: Row(children: [
                        Icon(Icons.delete, size: 18, color: Colors.red),
                        SizedBox(width: 8),
                        Text("Delete"),
                      ]),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 12),
            Text(asram.name,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(asram.location,
                      style:
                          const TextStyle(color: Colors.black87, fontSize: 14),
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Manage Asrams",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                if (_controller.isLoading.value &&
                    _controller.asramList.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (_controller.asramList.isEmpty) {
                  return const Center(
                      child: Text("No Asrams added yet.",
                          style: TextStyle(color: Colors.grey, fontSize: 16)));
                }
                return SingleChildScrollView(
                  child: Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children:
                        _controller.asramList.map(_buildAsramCard).toList(),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAsramDialog(),
        icon: const Icon(Icons.add),
        label: const Text("Add Asram"),
      ),
    );
  }
}
