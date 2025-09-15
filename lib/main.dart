import 'package:flutter/material.dart';
import 'package:qalb/db/helper.dart';
import 'package:qalb/screens/add/add_page.dart';
import 'package:qalb/screens/call_page.dart';
import 'package:qalb/screens/channel_page.dart';
import 'package:qalb/screens/group_page.dart';
import 'package:qalb/screens/home/chat_page.dart';
import 'package:qalb/screens/welcome/welcome.dart';

import 'navigation/bottom_nav_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = DBHelper();
  final bool isLoggedIn = await db.isLoggedIn();

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeenCircle',
      theme: ThemeData(
        primarySwatch: Colors.green,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.green,
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.light,
      home: isLoggedIn ? const MyHomePage() : const WelcomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _selectedKey = "chat";
  final List<String> _keys = ["chat", "call", "group", "channel"];

  final Map<String, Widget> _pages = {
    "chat": HomeChatPage(),
    "call": const CallPage(),
    "group": const GroupPage(),
    "channel": const ChannelPage(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedKey] ?? const SizedBox(),
      appBar: AppBar(title: const Text("DeenCircle")),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPage()),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavBar(
        currentIndex: _keys.indexOf(_selectedKey),
        onTap: (index) {
          setState(() {
            _selectedKey = _keys[index];
          });
        },
      ),
    );
  }
}
