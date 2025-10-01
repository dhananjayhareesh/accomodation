import 'package:flutter/material.dart';

class VacationScreen extends StatefulWidget {
  const VacationScreen({super.key});

  @override
  State<VacationScreen> createState() => _VacationScreenState();
}

class _VacationScreenState extends State<VacationScreen> {
  String vacateMethod = "room"; // default method
  final TextEditingController inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color(0xFFF6F7FB),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Page Header (outside card)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Vacation Screen",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${DateTime.now().toString().split(' ')[0]}",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),

            // Card (Form Section)
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(28),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Select Vacate Method",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 15),

                          // Radio buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildRadioOption("room", "Room No."),
                              _buildRadioOption("group", "Group No."),
                              _buildRadioOption("bill", "Bill No."),
                            ],
                          ),

                          const SizedBox(height: 25),

                          // Dynamic Input
                          TextField(
                            controller: inputController,
                            decoration: InputDecoration(
                              labelText: vacateMethod == "room"
                                  ? "Enter Room Number"
                                  : vacateMethod == "group"
                                      ? "Enter Group Number"
                                      : "Enter Bill Number",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),

                          const SizedBox(height: 40),

                          // Big Vacate Button
                          Center(
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  _showConfirmationDialog(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  //   backgroundColor: Colors.blueAccent,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 18, horizontal: 32),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  elevation: 5,
                                ),
                                child: const Text(
                                  "Vacate",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioOption(String value, String label) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: vacateMethod,
          onChanged: (v) {
            setState(() => vacateMethod = v.toString());
          },
        ),
        Text(label, style: const TextStyle(fontSize: 15)),
      ],
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          "Confirm Vacation",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text(
          "The flat is occupied by: K. LAKSHMANA RAO\n"
          "Paid Upto: 15/12/2019\n\n"
          "Do you want to vacate now?",
          style: TextStyle(fontSize: 15),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("No"),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text("Yes"),
          ),
        ],
      ),
    );
  }
}
