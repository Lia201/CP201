import 'package:flutter/material.dart';

class Box7Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Box #7'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text(
          'Content for Box #7',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
