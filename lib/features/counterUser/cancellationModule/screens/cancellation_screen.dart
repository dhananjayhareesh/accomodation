import 'package:flutter/material.dart';

class CancellationScreen extends StatefulWidget {
  const CancellationScreen({super.key});

  @override
  State<CancellationScreen> createState() => _CancellationScreenState();
}

class _CancellationScreenState extends State<CancellationScreen> {
  final TextEditingController billNumberController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController sexController = TextEditingController();
  final TextEditingController roomNumberController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController daysController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();
  final TextEditingController maleController = TextEditingController();
  final TextEditingController femaleController = TextEditingController();
  final TextEditingController childrenController = TextEditingController();
  final TextEditingController totalController = TextEditingController();
  final TextEditingController paidTypeController = TextEditingController();
  final TextEditingController amountPaidController = TextEditingController();
  final TextEditingController amountRefundedController =
      TextEditingController();
  final TextEditingController remarkController = TextEditingController();

  void _resetForm() {
    billNumberController.clear();
    nameController.clear();
    placeController.clear();
    sexController.clear();
    roomNumberController.clear();
    rateController.clear();
    fromDateController.clear();
    daysController.clear();
    toDateController.clear();
    maleController.clear();
    femaleController.clear();
    childrenController.clear();
    totalController.clear();
    paidTypeController.clear();
    amountPaidController.clear();
    amountRefundedController.clear();
    remarkController.clear();
    setState(() {});
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
                // Page Title
                Center(
                  child: Text(
                    "Cancellation of Allotment Bill",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                const SizedBox(height: 24),

                TextField(
                  controller: billNumberController,
                  decoration: _inputDecoration("Bill Number"),
                ),
                const SizedBox(height: 16),

                TextField(
                  controller: nameController,
                  decoration: _inputDecoration("Name"),
                ),
                const SizedBox(height: 16),

                TextField(
                  controller: placeController,
                  decoration: _inputDecoration("Place"),
                ),
                const SizedBox(height: 16),

                TextField(
                  controller: sexController,
                  decoration: _inputDecoration("Sex"),
                ),
                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: roomNumberController,
                        decoration: _inputDecoration("Hall / Room Number"),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: rateController,
                        keyboardType: TextInputType.number,
                        decoration: _inputDecoration("Rate (Rs)"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

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
                        controller: daysController,
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

                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: maleController,
                        keyboardType: TextInputType.number,
                        decoration: _inputDecoration("Male"),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: femaleController,
                        keyboardType: TextInputType.number,
                        decoration: _inputDecoration("Female"),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: childrenController,
                        keyboardType: TextInputType.number,
                        decoration: _inputDecoration("Children"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                TextField(
                  controller: totalController,
                  decoration: _inputDecoration("Total"),
                ),
                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: paidTypeController,
                        decoration: _inputDecoration("Paid (C/Q/D)"),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: amountPaidController,
                        keyboardType: TextInputType.number,
                        decoration: _inputDecoration("Amount Paid"),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: amountRefundedController,
                        keyboardType: TextInputType.number,
                        decoration: _inputDecoration("Amount Refunded"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                TextField(
                  controller: remarkController,
                  maxLines: 3,
                  decoration: _inputDecoration("Remarks"),
                ),
                const SizedBox(height: 24),

                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Handle cancel allotment
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 14),
                      ),
                      child: const Text("Cancel Allotment"),
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
