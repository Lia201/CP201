// In screens/box2_screen.dart
import 'package:flutter/material.dart';

class Box2Screen extends StatelessWidget {
  const Box2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Box 2')),
      body: const Center(child: Text('This is Box 2 screen')),
    );
  }
}
