import 'package:accomodation_admin/widgets/custom_scafold.dart';
import 'package:flutter/material.dart';

class RoomCategoryPage extends StatefulWidget {
  const RoomCategoryPage({super.key});

  @override
  State<RoomCategoryPage> createState() => _RoomCategoryPageState();
}

class _RoomCategoryPageState extends State<RoomCategoryPage> {
  final List<Map<String, dynamic>> _categories = [
    {
      "name": "Deluxe Room",
      "allotee": "1000",
      "donor": "800",
      "general": "1200",
      "staff": "600",
      "asram": "Shanti Asram",
    },
    {
      "name": "Dormitory",
      "allotee": "300",
      "donor": "250",
      "general": "400",
      "staff": "200",
      "asram": "Ananda Ashram",
    },
    {
      "name": "Suite",
      "allotee": "2000",
      "donor": "1800",
      "general": "2500",
      "staff": "1200",
      "asram": "Shanti Asram",
    },
  ];

  // mock asram list
  final List<String> _asrams = ["All", "Shanti Asram", "Ananda Ashram"];
  String _selectedAsram = "All";

  // controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _alloteeController = TextEditingController();
  final TextEditingController _donorController = TextEditingController();
  final TextEditingController _generalController = TextEditingController();
  final TextEditingController _staffController = TextEditingController();

  void _showCategoryDialog({Map<String, dynamic>? existing, int? index}) {
    if (existing != null) {
      _nameController.text = existing["name"] ?? "";
      _alloteeController.text = existing["allotee"] ?? "";
      _donorController.text = existing["donor"] ?? "";
      _generalController.text = existing["general"] ?? "";
      _staffController.text = existing["staff"] ?? "";
    } else {
      _nameController.clear();
      _alloteeController.clear();
      _donorController.clear();
      _generalController.clear();
      _staffController.clear();
    }

    String selectedAsram = existing?["asram"] ??
        _asrams.firstWhere(
          (a) => a != "All",
          orElse: () => _asrams[1],
        );

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
                    // Select Asram
                    DropdownButtonFormField<String>(
                      value: selectedAsram,
                      items: _asrams
                          .where((a) => a != "All")
                          .map((asram) => DropdownMenuItem(
                                value: asram,
                                child: Text(asram),
                              ))
                          .toList(),
                      decoration: InputDecoration(
                        labelText: "Select Asram",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onChanged: (val) {
                        selectedAsram = val!;
                      },
                    ),
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
                    _buildTextField("Tariff (Working Staff)", _staffController,
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
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                          ),
                          onPressed: () {
                            if (_nameController.text.isNotEmpty) {
                              setState(() {
                                if (existing == null) {
                                  _categories.add({
                                    "name": _nameController.text,
                                    "allotee": _alloteeController.text,
                                    "donor": _donorController.text,
                                    "general": _generalController.text,
                                    "staff": _staffController.text,
                                    "asram": selectedAsram,
                                  });
                                } else {
                                  _categories[index!] = {
                                    "name": _nameController.text,
                                    "allotee": _alloteeController.text,
                                    "donor": _donorController.text,
                                    "general": _generalController.text,
                                    "staff": _staffController.text,
                                    "asram": selectedAsram,
                                  };
                                }
                              });
                              Navigator.pop(context);
                            }
                          },
                          child: Text(existing == null ? "Create" : "Update"),
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

  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete Category"),
        content: Text(
            "Are you sure you want to delete '${_categories[index]["name"]}'?"),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              setState(() {
                _categories.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> category, int index) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------- Header ----------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    category["name"] ?? "",
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                PopupMenuButton<String>(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  onSelected: (value) {
                    if (value == "edit") {
                      _showCategoryDialog(existing: category, index: index);
                    } else if (value == "delete") {
                      _confirmDelete(index);
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: "edit",
                      child: Row(
                        children: [
                          Icon(Icons.edit, size: 18),
                          SizedBox(width: 8),
                          Text("Edit"),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: "delete",
                      child: Row(
                        children: [
                          Icon(Icons.delete, size: 18, color: Colors.red),
                          SizedBox(width: 8),
                          Text("Delete"),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),

            const SizedBox(height: 6),
            Text(
              category["asram"] ?? "-",
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black54,
              ),
            ),
            const Divider(),

            // ---------- Tariff Details ----------
            _buildTariffRow("Allotee", category["allotee"]),
            _buildTariffRow("Donor", category["donor"]),
            _buildTariffRow("General", category["general"]),
            _buildTariffRow("Working Staff", category["staff"]),
          ],
        ),
      ),
    );
  }

  Widget _buildTariffRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),
          Text(
            "₹${value ?? "-"}",
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
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

  @override
  Widget build(BuildContext context) {
    // filter categories
    final filteredCategories = _selectedAsram == "All"
        ? _categories
        : _categories.where((c) => c["asram"] == _selectedAsram).toList();

    return CustomScaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------- Header with filter ----------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Manage Room Categories",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                DropdownButton<String>(
                  value: _selectedAsram,
                  items: _asrams
                      .map((asram) => DropdownMenuItem(
                            value: asram,
                            child: Text(asram),
                          ))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedAsram = val!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            Expanded(
              child: filteredCategories.isEmpty
                  ? const Center(
                      child: Text(
                        "No categories found.",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: List.generate(
                          filteredCategories.length,
                          (index) => _buildCategoryCard(
                              filteredCategories[index],
                              _categories.indexOf(filteredCategories[index])),
                        ),
                      ),
                    ),
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
}
