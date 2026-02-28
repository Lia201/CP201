import 'package:flutter/material.dart';
import 'dart:async';
import 'mainscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false, // Remove the debug banner
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const PasswordScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 93, 176, 255), // Set the background color to a2d2ff
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/cyberpoint2.jpg',
              width: 255, // Set the width of the image
              height: 200, // Set the height of the image
              fit: BoxFit.fill, // Ensure the image covers the container
            ),
            const SizedBox(height: 20), // Add some space between the image and the text
            const Text(
              '7/17/2024',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  String _password = '';

  void _onKeyPress(String value) {
    setState(() {
      if (_password.length < 5) { // Increase length check to 5
        _password += value;
      }
    });
  }

  void _onConfirm() {
    if (_password == '05812') { // Replace '5821' with '05812'
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Incorrect Password')),
      );
      setState(() {
        _password = '';
      });
    }
  }

  void _onDelete() {
    setState(() {
      if (_password.isNotEmpty) {
        _password = _password.substring(0, _password.length - 1);
      }
    });
  }

  Widget _buildNumberButton(String number) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 75,
        height: 75,
        child: TextButton(
          onPressed: () => _onKeyPress(number),
          style: TextButton.styleFrom(
            backgroundColor: Colors.blue, // Blue color for number buttons
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // Square shape
            ),
          ),
          child: Text(number, style: const TextStyle(fontSize: 24, color: Colors.white)),
        ),
      ),
    );
  }

  Widget _buildActionButton(String label, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 150,
        height: 75,
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 56, 159, 255),  // Light blue color for delete and confirm buttons
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // Square shape
            ),
          ),
          child: Text(label, style: const TextStyle(fontSize: 20, color: Colors.white)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 93, 176, 255), // Set the background color to a2d2ff
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter Password',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20), // Space between title and password display
            Text(
              '*' * _password.length,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20), // Space between password display and buttons
            Container(
              width: MediaQuery.of(context).size.width * 0.8, // Adjust width dynamically
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 112, 186, 255),
                borderRadius: BorderRadius.circular(8), // Match border radius
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildNumberButton('1'),
                      _buildNumberButton('2'),
                      _buildNumberButton('3'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildNumberButton('4'),
                      _buildNumberButton('5'),
                      _buildNumberButton('6'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildNumberButton('7'),
                      _buildNumberButton('8'),
                      _buildNumberButton('9'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 75, height: 75), // Empty space
                      _buildNumberButton('0'),
                      const SizedBox(width: 75, height: 75), // Empty space
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20), // Add space between number buttons and action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildActionButton('Delete', _onDelete),
                _buildActionButton('Confirm', _onConfirm),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
