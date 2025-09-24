// ---------------- EDIT PAGE -----------------
import 'package:accomodation_admin/features/superAdmin/side_panel/super_admin/view/room_list.dart';
import 'package:accomodation_admin/widgets/custom_scafold.dart';
import 'package:flutter/material.dart';

class EditRoomPage extends StatefulWidget {
  final RoomModel room;

  const EditRoomPage({super.key, required this.room});

  @override
  State<EditRoomPage> createState() => _EditRoomPageState();
}

class _EditRoomPageState extends State<EditRoomPage> {
  final _formKey = GlobalKey<FormState>();
  late RoomModel _editable;

  // Controllers
  late TextEditingController _noOfPeopleCtrl;
  late TextEditingController _roomNumberCtrl;
  late TextEditingController _dormNameCtrl;
  late TextEditingController _tariffGeneralCtrl;
  late TextEditingController _tariffAlloteeCtrl;
  late TextEditingController _tariffDonorCtrl;
  late TextEditingController _tariffStaffCtrl;

  String? _roomFacility;
  String? _occupancyType;
  RoomType? _selectedRoomType;

  @override
  void initState() {
    super.initState();
    _editable = widget.room.copy();

    _selectedRoomType = _editable.type;
    _noOfPeopleCtrl =
        TextEditingController(text: _editable.noOfPeople.toString());
    _roomNumberCtrl = TextEditingController(text: _editable.roomNumber ?? '');
    _dormNameCtrl = TextEditingController(text: _editable.dormName ?? '');
    _tariffGeneralCtrl =
        TextEditingController(text: _editable.tariff.general?.toString() ?? '');
    _tariffAlloteeCtrl =
        TextEditingController(text: _editable.tariff.allotee?.toString() ?? '');
    _tariffDonorCtrl =
        TextEditingController(text: _editable.tariff.donor?.toString() ?? '');
    _tariffStaffCtrl =
        TextEditingController(text: _editable.tariff.staff?.toString() ?? '');
    _roomFacility = _editable.roomFacility;
    _occupancyType = _editable.occupancyType;
  }

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

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    _editable.type = _selectedRoomType ?? RoomType.Room;
    _editable.noOfPeople = int.tryParse(_noOfPeopleCtrl.text) ?? 1;
    _editable.roomNumber =
        _roomNumberCtrl.text.isEmpty ? null : _roomNumberCtrl.text;
    _editable.dormName = _dormNameCtrl.text.isEmpty ? null : _dormNameCtrl.text;
    _editable.roomFacility = _roomFacility;
    _editable.occupancyType = _occupancyType;

    _editable.tariff.general = double.tryParse(
        _tariffGeneralCtrl.text.trim().isEmpty ? "0" : _tariffGeneralCtrl.text);
    _editable.tariff.allotee = double.tryParse(
        _tariffAlloteeCtrl.text.trim().isEmpty ? "0" : _tariffAlloteeCtrl.text);
    _editable.tariff.donor = double.tryParse(
        _tariffDonorCtrl.text.trim().isEmpty ? "0" : _tariffDonorCtrl.text);
    _editable.tariff.staff = double.tryParse(
        _tariffStaffCtrl.text.trim().isEmpty ? "0" : _tariffStaffCtrl.text);

    Navigator.pop(context, _editable);
  }

  Widget _buildTariffFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Tariff Rates",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 20,
          runSpacing: 20,
          children: [
            _tariffField("Tariff (General)", _tariffGeneralCtrl),
            _tariffField("Tariff (Allotee)", _tariffAlloteeCtrl),
            _tariffField("Tariff (Donor)", _tariffDonorCtrl),
            _tariffField("Tariff (Working Staff)", _tariffStaffCtrl),
          ],
        ),
      ],
    );
  }

  Widget _tariffField(String label, TextEditingController ctrl) {
    return SizedBox(
      width: 260,
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
        Wrap(
          spacing: 20,
          runSpacing: 20,
          children: [
            SizedBox(
              width: 260,
              child: TextFormField(
                controller: _noOfPeopleCtrl,
                decoration: const InputDecoration(
                    labelText: "No. of People Who Can Occupy"),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Enter occupancy';
                  if (int.tryParse(v) == null) return 'Enter valid number';
                  return null;
                },
              ),
            ),
            SizedBox(
              width: 260,
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
                decoration: const InputDecoration(labelText: "Room Facility"),
              ),
            ),
            SizedBox(
              width: 260,
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
              width: 260,
              child: TextFormField(
                controller: _roomNumberCtrl,
                decoration: const InputDecoration(labelText: "Assign Room No."),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _buildTariffFields(),
      ],
    );
  }

  Widget _buildDormWithBedFields() {
    if (_noOfPeopleCtrl.text.isEmpty) _noOfPeopleCtrl.text = '1';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 260,
          child: TextFormField(
            controller: _roomNumberCtrl,
            decoration: const InputDecoration(labelText: "Assign Room No."),
          ),
        ),
        const SizedBox(height: 20),
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
              width: 260,
              child: TextFormField(
                controller: _noOfPeopleCtrl,
                decoration: const InputDecoration(
                    labelText: "No. of People in Dormitory"),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Enter occupancy';
                  if (int.tryParse(v) == null) return 'Enter valid number';
                  return null;
                },
              ),
            ),
            SizedBox(
              width: 260,
              child: TextFormField(
                controller: _dormNameCtrl,
                decoration: const InputDecoration(labelText: "Dormitory Name"),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Enter dormitory name'
                    : null,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _buildTariffFields(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: const Text("Edit Room"),
        backgroundColor: const Color(0xFFFBE4CD),
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Card(
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButtonFormField<RoomType>(
                      value: _selectedRoomType,
                      items: const [
                        DropdownMenuItem(
                            value: RoomType.Room, child: Text("Room")),
                        DropdownMenuItem(
                            value: RoomType.DormWithBed,
                            child: Text("Dormitory with Bed")),
                        DropdownMenuItem(
                            value: RoomType.DormWithoutBed,
                            child: Text("Dormitory without Bed")),
                      ],
                      onChanged: (val) =>
                          setState(() => _selectedRoomType = val),
                      decoration: const InputDecoration(
                          labelText: "Select Room/Dormitory Type"),
                    ),
                    const SizedBox(height: 20),
                    if (_selectedRoomType == RoomType.Room) _buildRoomFields(),
                    if (_selectedRoomType == RoomType.DormWithBed)
                      _buildDormWithBedFields(),
                    if (_selectedRoomType == RoomType.DormWithoutBed)
                      _buildDormWithoutBedFields(),
                    const SizedBox(height: 30),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton(
                            onPressed: _save,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 26, vertical: 14),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            child: const Text("Save Changes"),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
