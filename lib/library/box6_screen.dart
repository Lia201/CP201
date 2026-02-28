import 'package:flutter/material.dart';

class Box6Screen extends StatefulWidget {
  @override
  _Box6ScreenState createState() => _Box6ScreenState();
}

class _Box6ScreenState extends State<Box6Screen> {
  final List<String> paragraphs = [
    'This is the first paragraph. It may be short or long depending on the content you need.',
    'This is the second paragraph. This one might be a bit longer, so the container will adapt to its content size automatically.',
    'This is the third paragraph. Each paragraph container can have different lengths based on the text it holds.',
    'Here is the fourth paragraph. This one could also be quite long or short based on your text requirements.',
    'Finally, this is the fifth paragraph. It can vary in length just like the others.',
  ];

  final String sixthParagraph =
      'This is the sixth paragraph, now replacing the editable "WIR..." section. It follows the same style as the other containers.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 93, 176, 255),
      appBar: AppBar(
        title: Text(
          'YackSá: Void œ Atsura',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20), // Space between the AppBar and the first chapter
              ...paragraphs.asMap().entries.map((entry) {
                int index = entry.key;
                String paragraph = entry.value;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '~Chapter ${index + 1}', // Chapter label
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800, // Increased weight for boldness
                        color: const Color.fromARGB(255, 62, 102, 225), // New color for chapter titles
                      ),
                    ),
                    SizedBox(height: 8), // Space between the chapter title and the container
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 112, 186, 255),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        paragraph,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                    if (index < paragraphs.length - 1) SizedBox(height: 60), // Space after each square except the last
                  ],
                );
              }).toList(),
              SizedBox(height: 10), // Small space between the last square and "Sañ"
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Sañ    ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: Colors.blue,
                  ),
                ),
              ),
              SizedBox(height: 30), // Additional space after "Sañ"
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '-Ren Wir-gâ Kitchan-', // Custom title for the additional section
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800, // Increased weight for boldness
                      color: const Color.fromARGB(255, 62, 102, 225), // New color for title
                    ),
                  ),
                  SizedBox(height: 4), // Smaller space between title and "Ē Zannoubiea"
                  Text(
                    'Ē Zannoubiea',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300, // Lighter weight for the text
                      color: Colors.white, // White color for the text
                    ),
                  ),
                  SizedBox(height: 10), // Space between "Ē Zannoubiea" and the container
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 112, 186, 255),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      sixthParagraph, // Sixth paragraph content
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black45,
                      ),
                    ),
                  ),
                  SizedBox(height: 60), // Space after the additional square
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
