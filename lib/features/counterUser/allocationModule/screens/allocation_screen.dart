import 'package:flutter/material.dart';

class AllocationScreen extends StatefulWidget {
  const AllocationScreen({super.key});

  @override
  State<AllocationScreen> createState() => _AllocationScreenState();
}

class _AllocationScreenState extends State<AllocationScreen> {
  final TextEditingController groupRegController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final List<TextEditingController> extraNames = [];

  final TextEditingController nationController = TextEditingController();
  final TextEditingController maleController = TextEditingController();
  final TextEditingController femaleController = TextEditingController();
  final TextEditingController childrenController = TextEditingController();
  final TextEditingController roomNumberController = TextEditingController();
  final TextEditingController roomRateController = TextEditingController();
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController noOfDaysController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();
  final TextEditingController amountDueController = TextEditingController();
  final TextEditingController amountCollectedController =
      TextEditingController();
  final TextEditingController remarkController = TextEditingController();

  String nationality = 'Indian';
  String sex = 'Male';
  String allotType = 'Allottee';

  int totalAdults = 0;
  int totalChildren = 0;

  void _addExtraNameField() {
    setState(() {
      extraNames.add(TextEditingController());
    });
  }

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
      groupRegController.clear();
      nameController.clear();
      for (var ctrl in extraNames) {
        ctrl.dispose();
      }
      extraNames.clear();
      nationController.clear();
      maleController.clear();
      femaleController.clear();
      childrenController.clear();
      roomNumberController.clear();
      roomRateController.clear();
      fromDateController.clear();
      noOfDaysController.clear();
      toDateController.clear();
      amountDueController.clear();
      amountCollectedController.clear();
      remarkController.clear();
      nationality = 'Indian';
      sex = 'Male';
      allotType = 'Allottee';
      totalAdults = 0;
      totalChildren = 0;
    });
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      filled: true,
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
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Allocation Screen",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                const SizedBox(height: 24),

                /// Group / Reg No.
                TextField(
                  controller: groupRegController,
                  decoration: _inputDecoration("Group / Reg No."),
                ),

                const SizedBox(height: 24),

                /// Name + add icon
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: nameController,
                        decoration: _inputDecoration("Name"),
                      ),
                    ),
                    IconButton(
                      onPressed: _addExtraNameField,
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ...extraNames.map((ctrl) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: TextField(
                        controller: ctrl,
                        decoration: _inputDecoration("Additional Name"),
                      ),
                    )),

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

                /// Room number and rate
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: roomNumberController,
                        decoration: _inputDecoration("Room Number"),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: roomRateController,
                        keyboardType: TextInputType.number,
                        decoration: _inputDecoration("Room Rate"),
                      ),
                    ),
                  ],
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
                TextField(
                  controller: remarkController,
                  decoration: _inputDecoration("Remarks"),
                  maxLines: 3,
                ),

                const SizedBox(height: 24),

                /// Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Handle allotment action
                      },
                      child: const Text("Allot"),
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
