import 'package:flutter/material.dart';
import 'dart:math';

// Importing screens with unique prefixes to avoid ambiguity
import 'screens/box1_screen.dart' as box1;
import 'screens/box2_screen.dart' as box2;
import 'screens/box3_screen.dart' as box3;
import 'screens/box4_screen.dart' as box4;
import 'screens/box5_screen.dart' as box5;
// Library
import 'library/box6_screen.dart' as box6;
import 'library/box7_screen.dart' as box7;
import 'library/box8_screen.dart' as box8;
import 'library/box9_screen.dart' as box9;
// Message Icons
import 'messageicon/icon1_screen.dart';
import 'messageicon/icon2_screen.dart';
import 'messageicon/icon3_screen.dart';
import 'messageicon/icon4_screen.dart';
// File Icons
import 'FileIcons/file1_screen.dart' as file1;
import 'FileIcons/file2_screen.dart' as file2;
import 'FileIcons/file3_screen.dart' as file3;
import 'FileIcons/file4_screen.dart' as file4;
import 'FileIcons/file5_screen.dart' as file5;
import 'FileIcons/file6_screen.dart' as file6;
import 'FileIcons/file7_screen.dart' as file7;
import 'FileIcons/file8_screen.dart' as file8;
import 'FileIcons/file9_screen.dart' as file9;
import 'FileIcons/file10_screen.dart' as file10;

void main() {
  runApp(MaterialApp(
    home: MainScreen(),
  ));
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _controller;

  final List<Widget> _children = [
    HomeScreen(),
    SettingsScreen(),
    NotificationsScreen(),
    ProfileScreen(),
    MessagesScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onExclamationButtonPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InfoScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 93, 176, 255),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.info_outline,
            size: 30,
            color: Color.fromARGB(255, 93, 176, 255),
          ),
          onPressed: _onExclamationButtonPressed,
        ),
        title: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Text(
              'CP AXÕDA',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Color.fromARGB(255, 0, 247, 255),
                fontSize: 32,
                shadows: [
                  Shadow(
                    blurRadius: 20.0 + 10.0 * sin(_controller.value * 2 * pi),
                    color: Color.fromARGB(255, 0, 247, 255),
                    offset: Offset(0, 0),
                  ),
                  Shadow(
                    blurRadius: 30.0 + 15.0 * sin(_controller.value * 2 * pi),
                    color: Color.fromARGB(150, 0, 247, 255),
                    offset: Offset(0, 0),
                  ),
                  Shadow(
                    blurRadius: 40.0 + 20.0 * sin(_controller.value * 2 * pi),
                    color: Color.fromARGB(100, 0, 247, 255),
                    offset: Offset(0, 0),
                  ),
                ],
              ),
            );
          },
        ),
        centerTitle: true,
        toolbarHeight: 110.0,
        backgroundColor: Colors.blue,
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.blue,
            icon: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Icon(Icons.now_widgets, size: 40),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.blue,
            icon: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Icon(Icons.filter_2, size: 40),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.blue,
            icon: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Icon(Icons.accessibility_new_sharp, size: 40),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.blue,
            icon: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Icon(Icons.menu_book_rounded, size: 40),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.blue,
            icon: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Icon(Icons.star_outlined, size: 40),
            ),
            label: '',
          ),
        ],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  void _navigateToDetailScreen(BuildContext context, String title) {
    Widget screen;
    switch (title) {
      case '#1':
        screen = box1.Box1Screen();
        break;
      case '#2':
        screen = box2.Box2Screen();
        break;
      case '#3':
        screen = box3.Box3Screen();
        break;
      case '#4':
        screen = box4.Box4Screen();
        break;
      case '#5':
        screen = box5.Box5Screen();
        break;
      default:
        screen = box1.Box1Screen();
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 93, 176, 255),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSquare(context, '#1'),
              SizedBox(height: 15),
              _buildSquare(context, '#2'),
              SizedBox(height: 15),
              _buildSquare(context, '#3'),
              SizedBox(height: 15),
              _buildSquare(context, '#4'),
              SizedBox(height: 15),
              _buildSquare(context, '#5'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSquare(BuildContext context, String title) {
    return InkWell(
      onTap: () => _navigateToDetailScreen(context, title),
      child: Container(
        width: double.infinity,
        height: 200,
        color: Color.fromARGB(255, 112, 186, 255),
        child: Center(
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 28),
          ),
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  void _navigateToLibraryScreen(BuildContext context, String title) {
    Widget screen;
    switch (title) {
      case 'Void œ Atsura':
        screen = box6.Box6Screen();
        break;
      case 'Ē Yōukáñ':
        screen = box7.Box7Screen();
        break;
      case 'Sãi ōū Yeeo':
        screen = box8.Box8Screen();
        break;
      case 'Ē rex hyū ōū Ohurakai Kitashi':
        screen = box9.Box9Screen();
        break;
      default:
        screen = box6.Box6Screen();
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  String _getSubtitle(String title) {
    switch (title) {
      case 'Void œ Atsura':
      case 'Ē Yōukáñ':
        return 'Gãcho Zacktaroā SinQua';
      case 'Sãi ōū Yeeo':
        return 'C-2/LD';
      case 'Ē rex hyū ōū Ohurakai Kitashi':
        return 'DL';
      default:
        return '';
    }
  }

  void _onFacebookIconPressed(BuildContext context, int iconIndex) {
    Widget screen;
    switch (iconIndex) {
      case 1:
        screen = Icon1Screen();
        break;
      case 2:
        screen = Icon2Screen();
        break;
      case 3:
        screen = Icon3Screen();
        break;
      case 4:
        screen = Icon4Screen();
        break;
      default:
        screen = Icon1Screen();
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  Widget _buildSquare(BuildContext context, String title, int iconIndex) {
    return Stack(
      children: [
        InkWell(
          onTap: () => _navigateToLibraryScreen(context, title),
          child: Container(
            width: double.infinity,
            height: 100,
            color: Color.fromARGB(255, 112, 186, 255),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: const Color.fromARGB(255, 62, 102, 225),
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    _getSubtitle(title),
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: GestureDetector(
            onTap: () => _onFacebookIconPressed(context, iconIndex),
            child: Icon(
              Icons.message_outlined,
              color: Color.fromARGB(255, 72, 167, 255),
              size: 50,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 93, 176, 255),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSquare(context, 'Void œ Atsura', 1),
              SizedBox(height: 15),
              _buildSquare(context, 'Ē Yōukáñ', 2),
              SizedBox(height: 15),
              _buildSquare(context, 'Sãi ōū Yeeo', 3),
              SizedBox(height: 15),
              _buildSquare(context, 'Ē rex hyū ōū Ohurakai Kitashi', 4),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final List<String> fileNames = [
    'Pass Pagiē',
    'Custom Name 2',
    'Custom Name 3',
    'Custom Name 4',
    'Custom Name 5',
    'Custom Name 6',
    'Custom Name 7',
    'Custom Name 8',
    'Custom Name 9',
    'Custom Name 10',
  ];

  void _navigateToFileScreen(BuildContext context, String fileName) {
    Widget screen;
    switch (fileName) {
      case 'Pass Pagiē':
        screen = file1.File1Screen();
        break;
      case 'Custom Name 2':
        screen = file2.File2Screen();
        break;
      case 'Custom Name 3':
        screen = file3.File3Screen();
        break;
      case 'Custom Name 4':
        screen = file4.File4Screen();
        break;
      case 'Custom Name 5':
        screen = file5.File5Screen();
        break;
      case 'Custom Name 6':
        screen = file6.File6Screen();
        break;
      case 'Custom Name 7':
        screen = file7.File7Screen();
        break;
      case 'Custom Name 8':
        screen = file8.File8Screen();
        break;
      case 'Custom Name 9':
        screen = file9.File9Screen();
        break;
      case 'Custom Name 10':
        screen = file10.File10Screen();
        break;
      default:
        screen = file1.File1Screen();
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 93, 176, 255),
      child: GridView.builder(
        padding: const EdgeInsets.all(20.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemCount: fileNames.length,
        itemBuilder: (context, index) {
          String fileName = fileNames[index];
          return GestureDetector(
            onTap: () => _navigateToFileScreen(context, fileName),
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 112, 186, 255),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.insert_drive_file_rounded,
                      color: Colors.white,
                      size: 100,
                    ),
                    SizedBox(height: 10),
                    Text(
                      fileName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Notifications Screen'),
    );
  }
}

class MessagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Messages Screen'),
    );
  }
}

// La Hon

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 93, 176, 255),
      appBar: AppBar(
        title: Text(
          'Information',
          style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                Text(
                  '''Cyber Point ē~ axõda ōū OvVō pi-OX vâ kū A mi-OX ē info ōū 'ss œ point. 
DM ē~ Demo Axõda wañ MD-gi A 02 *C-2* ōū ZpZ ro ē 6.24, ōū NO: 5812 Sãi-OX (e). 
Ē Axõda saHu ē 7/17/0224
Ē Sãi-OX gan OviVã 'C ōū paragañ-na (to gan siáñg eoth ōū ē #1 yeeo 'C ōū paragañ-na) vâ kū trinku ōū MD-gi ē iSska Axõda ōū 'ss fâ 'ss A mi-OX eoth UTFT :)  
Cyber Point wir gan ē infoz ōū 
"Ē Kinaraki Yuma" to ōū EKY bono. Ē ren 'C ōū MD ē Axõda wañ ōū MD-gi ē pagiez gan VOID. To ē eoth 'C wañ ōū *Yū atheh Flashz* "ē~ message ōū yū ōū yū œ Fyū? Yū trinku ē yū leff ē~ Ozax :]"
Vâ yū MD ē *INFO* pagie ē Yuma ōū Asur fâ yū wir taku obt ē nero yadie. 
Ē 10/11/0224 ē 0225 wir gan õ~ 3_ kyojin ōū ē #3 Ani ōū ZpZ yū fvieroū ōo~ chieri+ to van MD-gi *16 sai* Kaiten! 
Rañ yū-gi fyū siáñg ē message to gan ē paragañ code yū van mū ōū wir-gi mū œ nero yadie ōū XD to nai ai nai rañ mū ~ ē OviVã Krilna...                                  UTNT
''',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black45,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 25),
                Text(
                  '''Wañ mū "yū" Wir wir-gi ē message mū laz A *21 sai* to wir-gi rañ mū gan ē fai ekillá A.P.I (yū trinku ē nai...) 
MŪ VAN Ē 21 SAI ŌŪ A KAITEN!''',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}