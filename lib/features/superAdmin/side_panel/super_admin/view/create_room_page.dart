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
  String? _selectedAsram;

  // Mock asram list
  final List<String> _asrams = ["Shanti Asram", "Ananda Ashram", "Seva Asram"];

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
  String? _occupancyStatus;
  String? _roomStatus;

  static const List<String> ALLOWED_STATUS = [
    "vacant",
    "occupied",
    "reserved",
    "maintenance",
    "guest",
  ];

  static const List<String> ALLOTTEE_STATUS = [
    "KOB", // Key on Board
    "CT", // Central Trust
    "OCP", // Occupied by Paid
    "OCN", // Occupied Non-Paid
    "OAP", // Occupied by Allottee Paid
    "OAN", // Occupied by Allottee Non-Paid
    "OSP", // Occupied Staff Paid
    "OSN", // Occupied Staff Non-Paid
  ];

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

  Widget _buildAsramDropdown() {
    return SizedBox(
      width: 300,
      child: DropdownButtonFormField<String>(
        value: _selectedAsram,
        items: _asrams
            .map((asram) => DropdownMenuItem(
                  value: asram,
                  child: Text(asram),
                ))
            .toList(),
        onChanged: (val) => setState(() => _selectedAsram = val),
        decoration: const InputDecoration(
          labelText: "Select Asram",
        ),
        validator: (val) => val == null ? "Please select an Asram" : null,
      ),
    );
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
            _buildTariffInput("Tariff (General)", _tariffGeneralCtrl),
            _buildTariffInput("Tariff (Allotee)", _tariffAlloteeCtrl),
            _buildTariffInput("Tariff (Donor)", _tariffDonorCtrl),
            _buildTariffInput("Tariff (Working Staff)", _tariffStaffCtrl),
          ],
        ),
      ],
    );
  }

  Widget _buildTariffInput(String label, TextEditingController ctrl) {
    return SizedBox(
      width: 250,
      child: TextFormField(
        controller: ctrl,
        decoration: InputDecoration(labelText: label),
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget _buildRoomFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAsramDropdown(),
        const SizedBox(height: 20),
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
                decoration: const InputDecoration(labelText: "Room Category"),
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
                onChanged: (val) => setState(() {
                  _occupancyType = val;
                  _occupancyStatus = null;
                }),
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

        // Conditional: show occupancy status only if Allotee is selected
        if (_occupancyType == "Allotee") ...[
          const SizedBox(height: 16),
          SizedBox(
            width: 250,
            child: DropdownButtonFormField<String>(
              value: _occupancyStatus,
              items: ALLOTTEE_STATUS
                  .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                  .toList(),
              onChanged: (val) => setState(() => _occupancyStatus = val),
              decoration: const InputDecoration(labelText: "Occupancy Status"),
              validator: (val) =>
                  val == null ? "Select Occupancy Status" : null,
            ),
          ),
        ],

        const SizedBox(height: 16),
        SizedBox(
          width: 250,
          child: DropdownButtonFormField<String>(
            value: _roomStatus,
            items: ALLOWED_STATUS
                .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                .toList(),
            onChanged: (val) => setState(() => _roomStatus = val),
            decoration: const InputDecoration(labelText: "Room Status"),
            validator: (val) => val == null ? "Select Room Status" : null,
          ),
        ),

        _buildTariffFields(),
      ],
    );
  }

  Widget _buildDormWithBedFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAsramDropdown(),
        const SizedBox(height: 20),
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
              child: TextFormField(
                controller: _dormNameCtrl,
                decoration: const InputDecoration(labelText: "Dormitory Name"),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: 250,
          child: DropdownButtonFormField<String>(
            value: _roomStatus,
            items: ALLOWED_STATUS
                .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                .toList(),
            onChanged: (val) => setState(() => _roomStatus = val),
            decoration: const InputDecoration(labelText: "Room Status"),
            validator: (val) => val == null ? "Select Room Status" : null,
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
        _buildAsramDropdown(),
        const SizedBox(height: 20),
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
        const SizedBox(height: 16),
        SizedBox(
          width: 250,
          child: DropdownButtonFormField<String>(
            value: _roomStatus,
            items: ALLOWED_STATUS
                .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                .toList(),
            onChanged: (val) => setState(() => _roomStatus = val),
            decoration: const InputDecoration(labelText: "Room Status"),
            validator: (val) => val == null ? "Select Room Status" : null,
          ),
        ),
        _buildTariffFields(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
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
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Room Created Successfully in $_selectedAsram!",
                                  ),
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
