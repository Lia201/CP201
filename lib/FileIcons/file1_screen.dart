import 'package:flutter/material.dart';

// Fade-in page route used for all navigation
class _FadeRoute extends PageRouteBuilder {
  final Widget page;
  _FadeRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 300),
        );
}

class File1Screen extends StatefulWidget {
  const File1Screen({super.key});

  @override
  State<File1Screen> createState() => _File1ScreenState();
}

class _File1ScreenState extends State<File1Screen> {
  String _password = '';

  void _onKeyPress(String value) {
    setState(() {
      if (_password.length < 5) {
        _password += value;
      }
    });
  }

  void _onConfirm() {
    if (_password == '05812') {
      Navigator.of(context).pushReplacement(
        _FadeRoute(page: const File1ScreenContent()),
      );
    } else {
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
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
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
            backgroundColor: const Color.fromARGB(255, 56, 159, 255),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
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
      backgroundColor: const Color.fromARGB(255, 93, 176, 255),
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
            const SizedBox(height: 20),
            Text(
              '*' * _password.length,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 112, 186, 255),
                borderRadius: BorderRadius.circular(8),
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
                      const SizedBox(width: 75, height: 75),
                      _buildNumberButton('0'),
                      const SizedBox(width: 75, height: 75),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
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

class File1ScreenContent extends StatefulWidget {
  const File1ScreenContent({super.key});

  @override
  State<File1ScreenContent> createState() => _File1ScreenContentState();
}

class _File1ScreenContentState extends State<File1ScreenContent> {
  final List<String> _descriptions = [
    'Description 1',
    'Description 2',
    'Description 3',
    'Description 4',
    'Description 5',
    'Description 6',
    'Description 7',
    'Description 8',
    'Description 9',
    'Description 10',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 93, 176, 255),
      appBar: AppBar(
        title: const Text(
          'Pass Pagiē',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _descriptions.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 1.0,
        ),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 112, 186, 255),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                const Expanded(
                  child: Center(
                    child: Icon(
                      Icons.add_photo_alternate_outlined,
                      color: Colors.white70,
                      size: 48,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 10.0, left: 8.0, right: 8.0),
                  child: Text(
                    _descriptions[index],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
