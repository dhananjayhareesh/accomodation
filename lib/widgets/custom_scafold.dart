import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;

  const CustomScaffold({
    super.key,
    required this.body,
    this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: const Color(0xFFFBE4CD),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background logo with low opacity
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              // IMPORTANT: Make sure 'assets/png/logo.png' is added to your pubspec.yaml
              child: Image.asset(
                'assets/png/logo.png', // Replace with your logo image
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // This will show a placeholder color if the image fails to load
                  return Container(color: Colors.transparent);
                },
              ),
            ),
          ),
          // Ensure the body is scrollable and safe from system UI
          SafeArea(
            child: body,
          ),
        ],
      ),
    );
  }
}
