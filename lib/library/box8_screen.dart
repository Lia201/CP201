import 'package:flutter/material.dart';

class Box8Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Box #8'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text(
          'Content for Box #8',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
