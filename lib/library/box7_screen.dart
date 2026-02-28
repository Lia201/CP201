import 'package:flutter/material.dart';

class Box7Screen extends StatelessWidget {
  const Box7Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Box #7'),
        backgroundColor: Colors.blue,
      ),
      body: const Center(
        child: Text(
          'Content for Box #7',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
