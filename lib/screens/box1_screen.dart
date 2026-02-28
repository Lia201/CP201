// In screens/box1_screen.dart
import 'package:flutter/material.dart';

class Box1Screen extends StatelessWidget {
  const Box1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Box 1')),
      body: const Center(child: Text('This is Box 1 screen')),
    );
  }
}
