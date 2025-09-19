import 'package:accomodation_admin/widgets/custom_scafold.dart';
import 'package:flutter/material.dart';

class CreateRoomPage extends StatefulWidget {
  const CreateRoomPage({super.key});

  @override
  State<CreateRoomPage> createState() => _CreateRoomPageState();
}

class _CreateRoomPageState extends State<CreateRoomPage> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedRoomType;

  // Controllers
  final TextEditingController _noOfPeopleCtrl = TextEditingController();
  final TextEditingController _roomNumberCtrl = TextEditingController();
  final TextEditingController _dormNameCtrl = TextEditingController();

  // Tariff controllers
  final TextEditingController _tariffGeneralCtrl = TextEditingController();
  final TextEditingController _tariffAlloteeCtrl = TextEditingController();
  final TextEditingController _tariffDonorCtrl = TextEditingController();
  final TextEditingController _tariffStaffCtrl = TextEditingController();

  // Dropdown selections
  String? _roomFacility;
  String? _occupancyType;

  @override
  void dispose() {
    _noOfPeopleCtrl.dispose();
    _roomNumberCtrl.dispose();
    _dormNameCtrl.dispose();
    _tariffGeneralCtrl.dispose();
    _tariffAlloteeCtrl.dispose();
    _tariffDonorCtrl.dispose();
    _tariffStaffCtrl.dispose();
    super.dispose();
  }

  Widget _buildTariffFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const Text("Tariff Rates",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 20,
          runSpacing: 20,
          children: [
            SizedBox(
              width: 250,
              child: TextFormField(
                controller: _tariffGeneralCtrl,
                decoration:
                    const InputDecoration(labelText: "Tariff (General)"),
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(
              width: 250,
              child: TextFormField(
                controller: _tariffAlloteeCtrl,
                decoration:
                    const InputDecoration(labelText: "Tariff (Allotee)"),
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(
              width: 250,
              child: TextFormField(
                controller: _tariffDonorCtrl,
                decoration: const InputDecoration(labelText: "Tariff (Donor)"),
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(
              width: 250,
              child: TextFormField(
                controller: _tariffStaffCtrl,
                decoration:
                    const InputDecoration(labelText: "Tariff (Working Staff)"),
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRoomFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 20,
          runSpacing: 20,
          children: [
            SizedBox(
              width: 250,
              child: TextFormField(
                controller: _noOfPeopleCtrl,
                decoration: const InputDecoration(
                    labelText: "No. of People Who Can Occupy"),
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(
              width: 250,
              child: DropdownButtonFormField<String>(
                value: _roomFacility,
                items: const [
                  DropdownMenuItem(
                      value: "Furnished", child: Text("Furnished")),
                  DropdownMenuItem(
                      value: "With Geaser", child: Text("With Geaser")),
                  DropdownMenuItem(value: "AC", child: Text("AC")),
                  DropdownMenuItem(value: "Non-AC", child: Text("Non-AC")),
                ],
                onChanged: (val) => setState(() => _roomFacility = val),
                decoration: const InputDecoration(labelText: "Room Type"),
              ),
            ),
            SizedBox(
              width: 250,
              child: DropdownButtonFormField<String>(
                value: _occupancyType,
                items: const [
                  DropdownMenuItem(value: "General", child: Text("General")),
                  DropdownMenuItem(value: "Allotee", child: Text("Allotee")),
                  DropdownMenuItem(
                      value: "Working Staff", child: Text("Working Staff")),
                ],
                onChanged: (val) => setState(() => _occupancyType = val),
                decoration: const InputDecoration(labelText: "Occupancy Type"),
              ),
            ),
            SizedBox(
              width: 250,
              child: TextFormField(
                controller: _roomNumberCtrl,
                decoration: const InputDecoration(labelText: "Assign Room No."),
              ),
            ),
          ],
        ),
        _buildTariffFields(),
      ],
    );
  }

  Widget _buildDormWithBedFields() {
    _noOfPeopleCtrl.text = "1"; // Default
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 250,
          child: TextFormField(
            controller: _roomNumberCtrl,
            decoration: const InputDecoration(labelText: "Assign Room No."),
          ),
        ),
        _buildTariffFields(),
      ],
    );
  }

  Widget _buildDormWithoutBedFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 20,
          runSpacing: 20,
          children: [
            SizedBox(
              width: 250,
              child: TextFormField(
                controller: _noOfPeopleCtrl,
                decoration: const InputDecoration(
                    labelText: "No. of People in Dormitory"),
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(
              width: 250,
              child: TextFormField(
                controller: _dormNameCtrl,
                decoration: const InputDecoration(labelText: "Dormitory Name"),
              ),
            ),
          ],
        ),
        _buildTariffFields(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      // backgroundColor: const Color(0xFFeef7fb),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Create New Room",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 24),

                      // Select type
                      DropdownButtonFormField<String>(
                        value: _selectedRoomType,
                        items: const [
                          DropdownMenuItem(value: "Room", child: Text("Room")),
                          DropdownMenuItem(
                              value: "DormWithBed",
                              child: Text("Dormitory with Bed")),
                          DropdownMenuItem(
                              value: "DormWithoutBed",
                              child: Text("Dormitory without Bed")),
                        ],
                        onChanged: (val) {
                          setState(() => _selectedRoomType = val);
                        },
                        decoration: const InputDecoration(
                          labelText: "Select Room/Dormitory Type",
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Conditional forms
                      if (_selectedRoomType == "Room") _buildRoomFields(),
                      if (_selectedRoomType == "DormWithBed")
                        _buildDormWithBedFields(),
                      if (_selectedRoomType == "DormWithoutBed")
                        _buildDormWithoutBedFields(),

                      const SizedBox(height: 32),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            backgroundColor: const Color(0xFF382D1E),
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Submit logic
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Room Created Successfully!"),
                                ),
                              );
                            }
                          },
                          child: const Text("Create Room",
                              style: TextStyle(fontSize: 16)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
