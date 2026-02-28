import 'package:flutter/material.dart';

class File10Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File 1'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text(
          'Welcome to File 1 Screen!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
