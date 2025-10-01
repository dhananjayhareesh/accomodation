import 'package:flutter/material.dart';

class ExtensionScreen extends StatefulWidget {
  const ExtensionScreen({super.key});

  @override
  State<ExtensionScreen> createState() => _ExtensionScreenState();
}

class _ExtensionScreenState extends State<ExtensionScreen> {
  final TextEditingController initialStayController = TextEditingController();
  final TextEditingController firstBillController = TextEditingController();
  final TextEditingController totalStayController = TextEditingController();
  final TextEditingController flatNoController = TextEditingController();
  final TextEditingController billNoController = TextEditingController();
  final TextEditingController groupNoController = TextEditingController();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController nationController = TextEditingController();
  final TextEditingController maleController = TextEditingController();
  final TextEditingController femaleController = TextEditingController();
  final TextEditingController childrenController = TextEditingController();
  final TextEditingController flatNumberController = TextEditingController();
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController noOfDaysController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();
  final TextEditingController amountDueController = TextEditingController();
  final TextEditingController amountCollectedController =
      TextEditingController();
  final TextEditingController remarksController = TextEditingController();

  String sex = "Male";
  String allotType = "Allottee";
  String nationality = "Indian";

  int totalAdults = 0;
  int totalChildren = 0;

  void _updateTotals() {
    final male = int.tryParse(maleController.text) ?? 0;
    final female = int.tryParse(femaleController.text) ?? 0;
    final children = int.tryParse(childrenController.text) ?? 0;
    setState(() {
      totalAdults = male + female;
      totalChildren = children;
    });
  }

  void _resetForm() {
    setState(() {
      initialStayController.clear();
      firstBillController.clear();
      totalStayController.clear();
      flatNoController.clear();
      billNoController.clear();
      groupNoController.clear();
      nameController.clear();
      nationController.clear();
      maleController.clear();
      femaleController.clear();
      childrenController.clear();
      flatNumberController.clear();
      fromDateController.clear();
      noOfDaysController.clear();
      toDateController.clear();
      amountDueController.clear();
      amountCollectedController.clear();
      remarksController.clear();
      sex = "Male";
      allotType = "Allottee";
      nationality = "Indian";
      totalAdults = 0;
      totalChildren = 0;
    });
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
      isDense: true,
    );
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Header
                Center(
                  child: Text(
                    "Extension Screen",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                const SizedBox(height: 24),

                /// Top Table (Initial stay, Bill etc.)
                Table(
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(2),
                    2: FlexColumnWidth(2),
                  },
                  border: TableBorder.all(color: Colors.grey),
                  children: [
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: initialStayController,
                          decoration: _inputDecoration("Initial Stay From"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: firstBillController,
                          decoration: _inputDecoration("First Bill"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: totalStayController,
                          decoration: _inputDecoration("Total Stay"),
                        ),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: flatNoController,
                          decoration: _inputDecoration("Flat No. to Extend"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: billNoController,
                          decoration: _inputDecoration("Bill No. to Extend"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: groupNoController,
                          decoration: _inputDecoration("Group Number"),
                        ),
                      ),
                    ]),
                  ],
                ),
                const SizedBox(height: 24),

                /// Name
                TextField(
                  controller: nameController,
                  decoration: _inputDecoration("Name"),
                ),
                const SizedBox(height: 16),

                /// Dropdowns
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: nationality,
                        decoration: _inputDecoration("Nationality"),
                        items: const [
                          DropdownMenuItem(
                              value: "Indian", child: Text("Indian")),
                          DropdownMenuItem(
                              value: "Foreigner", child: Text("Foreigner")),
                        ],
                        onChanged: (val) => setState(() => nationality = val!),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: sex,
                        decoration: _inputDecoration("Sex"),
                        items: const [
                          DropdownMenuItem(value: "Male", child: Text("Male")),
                          DropdownMenuItem(
                              value: "Female", child: Text("Female")),
                        ],
                        onChanged: (val) => setState(() => sex = val!),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: allotType,
                        decoration: _inputDecoration("Allottee / Donor"),
                        items: const [
                          DropdownMenuItem(
                              value: "Allottee", child: Text("Allottee")),
                          DropdownMenuItem(
                              value: "Donor", child: Text("Donor")),
                        ],
                        onChanged: (val) => setState(() => allotType = val!),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                TextField(
                  controller: nationController,
                  decoration: _inputDecoration("Nation / State"),
                ),
                const SizedBox(height: 16),

                /// Male / Female / Children
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: maleController,
                        keyboardType: TextInputType.number,
                        decoration: _inputDecoration("Male No."),
                        onChanged: (_) => _updateTotals(),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: femaleController,
                        keyboardType: TextInputType.number,
                        decoration: _inputDecoration("Female No."),
                        onChanged: (_) => _updateTotals(),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: childrenController,
                        keyboardType: TextInputType.number,
                        decoration: _inputDecoration("Children No."),
                        onChanged: (_) => _updateTotals(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text("Total: $totalAdults Adults + $totalChildren Children"),

                const SizedBox(height: 16),

                /// Flat number
                TextField(
                  controller: flatNumberController,
                  decoration: _inputDecoration("Flat Number"),
                ),
                const SizedBox(height: 16),

                /// Dates
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
                        controller: noOfDaysController,
                        keyboardType: TextInputType.number,
                        decoration: _inputDecoration("No. of Days"),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: toDateController,
                        decoration: _inputDecoration("To Date"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                /// Amount
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: amountDueController,
                        keyboardType: TextInputType.number,
                        decoration: _inputDecoration("Amount Due"),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: amountCollectedController,
                        keyboardType: TextInputType.number,
                        decoration: _inputDecoration("Amount Collected"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                /// Remarks
                TextField(
                  controller: remarksController,
                  decoration: _inputDecoration("Remarks"),
                  maxLines: 3,
                ),
                const SizedBox(height: 24),

                /// Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Handle extend logic
                      },
                      child: const Text("Extend Bill"),
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
