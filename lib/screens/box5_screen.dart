// In screens/box5_screen.dart
import 'package:flutter/material.dart';

class Box5Screen extends StatelessWidget {
  const Box5Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Box 5')),
      body: const Center(child: Text('This is Box 5 screen')),
    );
  }
}
