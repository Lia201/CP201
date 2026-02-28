import 'package:flutter/material.dart';

class Box8Screen extends StatelessWidget {
  const Box8Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Box #8'),
        backgroundColor: Colors.blue,
      ),
      body: const Center(
        child: Text(
          'Content for Box #8',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
