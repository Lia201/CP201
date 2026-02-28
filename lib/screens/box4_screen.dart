// In screens/box4_screen.dart
import 'package:flutter/material.dart';

class Box4Screen extends StatelessWidget {
  const Box4Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Box 4')),
      body: const Center(child: Text('This is Box 4 screen')),
    );
  }
}
