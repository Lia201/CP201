// In screens/box3_screen.dart
import 'package:flutter/material.dart';

class Box3Screen extends StatelessWidget {
  const Box3Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Box 3')),
      body: const Center(child: Text('This is Box 3 screen')),
    );
  }
}
