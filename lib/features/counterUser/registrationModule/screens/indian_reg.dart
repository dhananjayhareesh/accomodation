import 'package:flutter/material.dart';

class IndianRegScreen extends StatefulWidget {
  const IndianRegScreen({super.key});

  @override
  State<IndianRegScreen> createState() => _IndianRegScreenState();
}

class _IndianRegScreenState extends State<IndianRegScreen> {
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();
  final TextEditingController departureTimeController = TextEditingController();
  final TextEditingController purposeController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController signatureController = TextEditingController();

  // Guest list (dynamic rows)
  List<Map<String, dynamic>> guests = [
    {
      "name": TextEditingController(),
      "age": TextEditingController(),
      "sex": null,
      "idType": null,
      "idCardNo": TextEditingController(),
    }
  ];

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      isDense: true,
      filled: true,
    );
  }

  void _addGuest() {
    setState(() {
      guests.add({
        "name": TextEditingController(),
        "age": TextEditingController(),
        "sex": null,
        "idType": null,
        "idCardNo": TextEditingController(),
      });
    });
  }

  void _removeGuest(int index) {
    setState(() {
      guests.removeAt(index);
    });
  }

  void _resetForm() {
    mobileController.clear();
    fromDateController.clear();
    toDateController.clear();
    departureTimeController.clear();
    purposeController.clear();
    addressController.clear();
    stateController.clear();
    dateController.clear();
    signatureController.clear();
    guests = [
      {
        "name": TextEditingController(),
        "age": TextEditingController(),
        "sex": null,
        "idType": null,
        "idCardNo": TextEditingController(),
      }
    ];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Title
                Text(
                  "Indian Registration",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 24),

                // Mobile
                TextField(
                  controller: mobileController,
                  keyboardType: TextInputType.phone,
                  decoration: _inputDecoration("Mobile No."),
                ),
                const SizedBox(height: 24),

                // Guests Dynamic List
                Column(
                  children: List.generate(guests.length, (index) {
                    final guest = guests[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: TextField(
                                    controller: guest["name"],
                                    decoration: _inputDecoration("Name"),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: TextField(
                                    controller: guest["age"],
                                    keyboardType: TextInputType.number,
                                    decoration: _inputDecoration("Age"),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    value: guest["sex"],
                                    decoration: _inputDecoration("Sex"),
                                    items: const [
                                      DropdownMenuItem(
                                          value: "Male", child: Text("Male")),
                                      DropdownMenuItem(
                                          value: "Female",
                                          child: Text("Female")),
                                    ],
                                    onChanged: (val) =>
                                        setState(() => guest["sex"] = val),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    value: guest["idType"],
                                    decoration: _inputDecoration("ID Type"),
                                    items: const [
                                      DropdownMenuItem(
                                          value: "Aadhaar",
                                          child: Text("Aadhaar")),
                                      DropdownMenuItem(
                                          value: "Voter ID",
                                          child: Text("Voter ID")),
                                      DropdownMenuItem(
                                          value: "Driving License",
                                          child: Text("Driving License")),
                                      DropdownMenuItem(
                                          value: "Passport",
                                          child: Text("Passport")),
                                      DropdownMenuItem(
                                          value: "Other", child: Text("Other")),
                                    ],
                                    onChanged: (val) =>
                                        setState(() => guest["idType"] = val),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  flex: 2,
                                  child: TextField(
                                    controller: guest["idCardNo"],
                                    decoration:
                                        _inputDecoration("ID Card Number"),
                                  ),
                                ),
                                if (guests.length > 1) ...[
                                  const SizedBox(width: 12),
                                  IconButton(
                                    onPressed: () => _removeGuest(index),
                                    icon: const Icon(Icons.remove_circle,
                                        color: Colors.red),
                                  )
                                ]
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),

                // Add Guest Button
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: _addGuest,
                    icon: const Icon(Icons.add),
                    label: const Text("Add Guest"),
                  ),
                ),

                const SizedBox(height: 24),

                // Stay Information
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: fromDateController,
                        decoration: _inputDecoration("From Date"),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: toDateController,
                        decoration: _inputDecoration("To Date"),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: departureTimeController,
                        decoration: _inputDecoration("Departure Time (HH:MM)"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                TextField(
                  controller: purposeController,
                  decoration: _inputDecoration("Purpose of Visit"),
                ),
                const SizedBox(height: 16),

                TextField(
                  controller: addressController,
                  decoration: _inputDecoration("Postal Address"),
                ),
                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: stateController,
                        decoration: _inputDecoration("State"),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: dateController,
                        decoration: _inputDecoration("Date"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                TextField(
                  controller: signatureController,
                  decoration: _inputDecoration("Signature"),
                ),

                const SizedBox(height: 32),

                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Submit
                      },
                      child: const Text("Submit"),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton(
                      onPressed: _resetForm,
                      child: const Text("Reset"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
