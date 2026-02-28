import 'package:flutter/material.dart';

class Box9Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ERROR 404',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
        centerTitle: true, // Ensures the title is centered in the AppBar
        iconTheme: IconThemeData(
          color: Colors.white, // Sets the back arrow to white
        ),
      ),
      body: Center(
        child: Text(
          'DL MD ē bono void DM NYI nai ai nai QyúeH wañ wir-gi ē bono :X',
          style: TextStyle(
            fontSize: 10,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 0, 0), // Set the screen background to white
    );
  }
}
