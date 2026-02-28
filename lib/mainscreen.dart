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
// Notification Screens
import 'notifications/notif1_screen.dart' as notif1;
import 'notifications/notif2_screen.dart' as notif2;
import 'notifications/notif3_screen.dart' as notif3;
import 'notifications/notif4_screen.dart' as notif4;
import 'notifications/notif5_screen.dart' as notif5;
import 'notifications/notif6_screen.dart' as notif6;
import 'notifications/notif7_screen.dart' as notif7;
import 'notifications/notif8_screen.dart' as notif8;
import 'notifications/notif9_screen.dart' as notif9;
import 'notifications/notif10_screen.dart' as notif10;

// Fade-in page route used for all navigation
class FadeRoute extends PageRouteBuilder {
  final Widget page;
  FadeRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 300),
        );
}

void main() {
  runApp(const MaterialApp(
    home: MainScreen(),
  ));
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _controller;

  final _homeKey = GlobalKey<_HomeScreenState>();
  final _settingsKey = GlobalKey<_SettingsScreenState>();
  final _notificationsKey = GlobalKey<_NotificationsScreenState>();
  final _profileKey = GlobalKey<_ProfileScreenState>();
  final _messagesKey = GlobalKey<_MessagesScreenState>();

  late final List<Widget> _children;

  @override
  void initState() {
    super.initState();
    _children = [
      HomeScreen(key: _homeKey),
      SettingsScreen(key: _settingsKey),
      NotificationsScreen(key: _notificationsKey),
      ProfileScreen(key: _profileKey),
      MessagesScreen(key: _messagesKey),
    ];
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
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

  void _onLongPress(int index) {
    setState(() {
      _currentIndex = index;
    });
    switch (index) {
      case 0:
        _homeKey.currentState?.addItem();
        break;
      case 1:
        _settingsKey.currentState?.addItem();
        break;
      case 2:
        _notificationsKey.currentState?.addItem();
        break;
      case 3:
        _profileKey.currentState?.addItem();
        break;
      case 4:
        _messagesKey.currentState?.addItem();
        break;
    }
  }

  void _onExclamationButtonPressed() {
    Navigator.push(
      context,
      FadeRoute(page: const InfoScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 93, 176, 255),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
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
                color: const Color.fromARGB(255, 0, 247, 255),
                fontSize: 32,
                shadows: [
                  Shadow(
                    blurRadius: 20.0 + 10.0 * sin(_controller.value * 2 * pi),
                    color: const Color.fromARGB(255, 0, 247, 255),
                    offset: const Offset(0, 0),
                  ),
                  Shadow(
                    blurRadius: 30.0 + 15.0 * sin(_controller.value * 2 * pi),
                    color: const Color.fromARGB(150, 0, 247, 255),
                    offset: const Offset(0, 0),
                  ),
                  Shadow(
                    blurRadius: 40.0 + 20.0 * sin(_controller.value * 2 * pi),
                    color: const Color.fromARGB(100, 0, 247, 255),
                    offset: const Offset(0, 0),
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
            icon: GestureDetector(
              onLongPress: () => _onLongPress(0),
              child: const Padding(
                padding: EdgeInsets.all(15.0),
                child: Icon(Icons.now_widgets, size: 40),
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.blue,
            icon: GestureDetector(
              onLongPress: () => _onLongPress(1),
              child: const Padding(
                padding: EdgeInsets.all(15.0),
                child: Icon(Icons.filter_2, size: 40),
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.blue,
            icon: GestureDetector(
              onLongPress: () => _onLongPress(2),
              child: const Padding(
                padding: EdgeInsets.all(15.0),
                child: Icon(Icons.accessibility_new_sharp, size: 40),
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.blue,
            icon: GestureDetector(
              onLongPress: () => _onLongPress(3),
              child: const Padding(
                padding: EdgeInsets.all(15.0),
                child: Icon(Icons.menu_book_rounded, size: 40),
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.blue,
            icon: GestureDetector(
              onLongPress: () => _onLongPress(4),
              child: const Padding(
                padding: EdgeInsets.all(15.0),
                child: Icon(Icons.star_outlined, size: 40),
              ),
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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _items = ['#1', '#2', '#3', '#4', '#5'];

  void addItem() {
    setState(() {
      _items.add('#${_items.length + 1}');
    });
  }

  void _navigateToDetailScreen(BuildContext context, String title) {
    Widget screen;
    switch (title) {
      case '#1':
        screen = const box1.Box1Screen();
        break;
      case '#2':
        screen = const box2.Box2Screen();
        break;
      case '#3':
        screen = const box3.Box3Screen();
        break;
      case '#4':
        screen = const box4.Box4Screen();
        break;
      case '#5':
        screen = const box5.Box5Screen();
        break;
      default:
        screen = _PlaceholderScreen(title: title);
    }
    Navigator.push(context, FadeRoute(page: screen));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 93, 176, 255),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < _items.length; i++) ...[
                if (i > 0) const SizedBox(height: 15),
                _buildSquare(context, _items[i]),
              ],
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
        color: const Color.fromARGB(255, 112, 186, 255),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 28),
          ),
        ),
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final List<Map<String, dynamic>> _entries = [
    {'title': 'Void œ Atsura', 'subtitle': 'Gãcho Zacktaroā SinQua', 'iconIndex': 1},
    {'title': 'Ē Yōukáñ', 'subtitle': 'Gãcho Zacktaroā SinQua', 'iconIndex': 2},
    {'title': 'Sãi ōū Yeeo', 'subtitle': 'C-2/LD', 'iconIndex': 3},
    {'title': 'Ē rex hyū ōū Ohurakai Kitashi', 'subtitle': 'DL', 'iconIndex': 4},
  ];

  void addItem() {
    setState(() {
      final n = _entries.length + 1;
      _entries.add({'title': 'New Library $n', 'subtitle': '', 'iconIndex': 0});
    });
  }

  void _navigateToLibraryScreen(BuildContext context, String title) {
    Widget screen;
    switch (title) {
      case 'Void œ Atsura':
        screen = const box6.Box6Screen();
        break;
      case 'Ē Yōukáñ':
        screen = const box7.Box7Screen();
        break;
      case 'Sãi ōū Yeeo':
        screen = const box8.Box8Screen();
        break;
      case 'Ē rex hyū ōū Ohurakai Kitashi':
        screen = const box9.Box9Screen();
        break;
      default:
        screen = _PlaceholderScreen(title: title);
    }
    Navigator.push(context, FadeRoute(page: screen));
  }

  void _onFacebookIconPressed(BuildContext context, int iconIndex) {
    if (iconIndex == 0) return;
    Widget screen;
    switch (iconIndex) {
      case 1:
        screen = const Icon1Screen();
        break;
      case 2:
        screen = const Icon2Screen();
        break;
      case 3:
        screen = const Icon3Screen();
        break;
      case 4:
        screen = const Icon4Screen();
        break;
      default:
        return;
    }
    Navigator.push(context, FadeRoute(page: screen));
  }

  Widget _buildSquare(BuildContext context, Map<String, dynamic> entry) {
    final title = entry['title'] as String;
    final subtitle = entry['subtitle'] as String;
    final iconIndex = entry['iconIndex'] as int;
    return Stack(
      children: [
        InkWell(
          onTap: () => _navigateToLibraryScreen(context, title),
          child: Container(
            width: double.infinity,
            height: 150,
            color: const Color.fromARGB(255, 112, 186, 255),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 62, 102, 225),
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (iconIndex > 0)
          Positioned(
            bottom: 10,
            left: 10,
            child: GestureDetector(
              onTap: () => _onFacebookIconPressed(context, iconIndex),
              child: const Icon(
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
      color: const Color.fromARGB(255, 93, 176, 255),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < _entries.length; i++) ...[
                if (i > 0) const SizedBox(height: 15),
                _buildSquare(context, _entries[i]),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final List<String> _fileNames = [
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

  void addItem() {
    setState(() {
      _fileNames.add('Custom Name ${_fileNames.length + 1}');
    });
  }

  void _navigateToFileScreen(BuildContext context, String fileName) {
    Widget screen;
    switch (fileName) {
      case 'Pass Pagiē':
        screen = const file1.File1Screen();
        break;
      case 'Custom Name 2':
        screen = const file2.File2Screen();
        break;
      case 'Custom Name 3':
        screen = const file3.File3Screen();
        break;
      case 'Custom Name 4':
        screen = const file4.File4Screen();
        break;
      case 'Custom Name 5':
        screen = const file5.File5Screen();
        break;
      case 'Custom Name 6':
        screen = const file6.File6Screen();
        break;
      case 'Custom Name 7':
        screen = const file7.File7Screen();
        break;
      case 'Custom Name 8':
        screen = const file8.File8Screen();
        break;
      case 'Custom Name 9':
        screen = const file9.File9Screen();
        break;
      case 'Custom Name 10':
        screen = const file10.File10Screen();
        break;
      default:
        screen = _PlaceholderScreen(title: fileName);
    }
    Navigator.push(context, FadeRoute(page: screen));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 93, 176, 255),
      child: GridView.builder(
        padding: const EdgeInsets.all(20.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemCount: _fileNames.length,
        itemBuilder: (context, index) {
          String fileName = _fileNames[index];
          return GestureDetector(
            onTap: () => _navigateToFileScreen(context, fileName),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 112, 186, 255),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.insert_drive_file_rounded,
                      color: Colors.white,
                      size: 100,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      fileName,
                      style: const TextStyle(
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

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  int _itemCount = 10;

  static const List<Widget> _predefinedScreens = [
    notif1.Notif1Screen(),
    notif2.Notif2Screen(),
    notif3.Notif3Screen(),
    notif4.Notif4Screen(),
    notif5.Notif5Screen(),
    notif6.Notif6Screen(),
    notif7.Notif7Screen(),
    notif8.Notif8Screen(),
    notif9.Notif9Screen(),
    notif10.Notif10Screen(),
  ];

  void addItem() {
    setState(() {
      _itemCount++;
    });
  }

  void _navigateToScreen(BuildContext context, int index) {
    final Widget screen;
    if (index < _predefinedScreens.length) {
      screen = _predefinedScreens[index];
    } else {
      screen = _PlaceholderScreen(title: 'Notification ${index + 1}');
    }
    Navigator.push(context, FadeRoute(page: screen));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 93, 176, 255),
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        itemCount: _itemCount,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 1.0,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _navigateToScreen(context, index),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 112, 186, 255),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                children: [
                  Expanded(
                    child: Center(
                      child: Icon(
                        Icons.add_photo_alternate_outlined,
                        color: Colors.white70,
                        size: 48,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      'Chara Name',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final List<String> _items = [];

  void addItem() {
    setState(() {
      _items.add('Message ${_items.length + 1}');
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_items.isEmpty) {
      return const Center(
        child: Text(
          'Messages Screen',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      );
    }
    return Container(
      color: const Color.fromARGB(255, 93, 176, 255),
      child: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 112, 186, 255),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  _items[index],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Placeholder screen for dynamically added items
class _PlaceholderScreen extends StatelessWidget {
  final String title;
  const _PlaceholderScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 93, 176, 255),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: const Center(
        child: Text(
          'Coming Soon',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}

// La Hon

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 93, 176, 255),
      appBar: AppBar(
        title: const Text(
          'Information',
          style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: const SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
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