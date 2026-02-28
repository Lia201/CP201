import 'package:flutter/material.dart';

class File3Screen extends StatelessWidget {
  const File3Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('File 1'),
        backgroundColor: Colors.blue,
      ),
      body: const Center(
        child: Text(
          'Welcome to File 1 Screen!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
