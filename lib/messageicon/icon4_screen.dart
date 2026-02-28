import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Icon4Screen extends StatefulWidget {
  @override
  _Icon4ScreenState createState() => _Icon4ScreenState();
}

class _Icon4ScreenState extends State<Icon4Screen> {
  final TextEditingController _initialController = TextEditingController();
  List<TextEditingController> _controllers = [];
  List<String> _textData = []; // To store text data for each container

  @override
  void initState() {
    super.initState();
    _loadData(); // Load saved data when screen is initialized
  }

  // Load saved text data from SharedPreferences
  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _textData = prefs.getStringList('icon4_containers') ?? [];

    // Initialize controllers with saved text data
    setState(() {
      _controllers = _textData
          .map((text) => TextEditingController(text: text))
          .toList();
    });
  }

  // Save text data to SharedPreferences
  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _textData = _controllers.map((controller) => controller.text).toList();
    await prefs.setStringList('icon4_containers', _textData);
  }

  // Function to add a new container
  void _addContainer() {
    setState(() {
      _controllers.add(TextEditingController()); // Add a new controller
    });
    _saveData(); // Save data after adding a new container
  }

  // Function to delete a container
  void _deleteContainer(int index) {
    setState(() {
      _controllers.removeAt(index); // Remove the controller at the specified index
    });
    _saveData(); // Save updated data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 93, 176, 255),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text(
          'MaViãz ōū Fyū',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
        child: Column(
          children: [
            SizedBox(height: 20.0), // Space between the top of the screen and the first ListView container
            Expanded(
              child: ListView.builder(
                itemCount: _controllers.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      SizedBox(height: 40.0), // Space between each container in the list
                      Dismissible(
                        key: Key(_controllers[index].hashCode.toString()),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          _deleteContainer(index); // Delete the container on swipe
                        },
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          color: Color.fromARGB(255, 68, 165, 255),
                          child: Icon(Icons.highlight_remove_outlined, color: Colors.white),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 112, 186, 255),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            controller: _controllers[index],
                            maxLines: null,
                            decoration: InputDecoration.collapsed(
                              hintText: 'WIR...',
                            ),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black45,
                            ),
                            onChanged: (text) => _saveData(), // Save data on change
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 40), // Space between the ListView and the bottom button
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: ElevatedButton(
                onPressed: _addContainer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(28),
                ),
                child: Icon(
                  Icons.adjust_outlined,
                  color: Colors.white,
                  size: 50,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
