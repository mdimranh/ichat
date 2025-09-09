import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:qalb/screens/group_page.dart';
import 'package:qalb/screens/home/chat_page.dart';
import 'package:qalb/screens/profile/profile.dart';

import 'navigation/bottom_nav_bar.dart';
import 'screens/add/add_page.dart';
import 'screens/call_page.dart';
import 'screens/channel_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iChat',
      theme: ThemeData(
        primarySwatch: Colors.green,
        // useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.green,
        // useMaterial3: true,
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.system,
      home: const MyHomePage(),
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // backgroundColor: Colors.green,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            thickness: 0.5,
            height: 0.5,
            color: Colors.black.withOpacity(0.1),
          ),
        ),
        actionsPadding: const EdgeInsets.only(right: 20),
        title: Text(
          "iChat",
          style: TextStyle(
            color: Color(Colors.green.value),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const ProfilePage(), // 🔽 your settings page
                ),
              );
            },
            child: const CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage("https://i.pravatar.cc/300"),
            ),
          ),
        ],
      ),
      // drawer: Drawer(
      //   // Add a ListView to the drawer. This ensures the user can scroll
      //   // through the options in the drawer if there isn't enough vertical
      //   // space to fit everything.
      //   child: ListView(
      //     // Important: Remove any padding from the ListView.
      //     padding: EdgeInsets.zero,
      //     children: [
      //       const DrawerHeader(
      //         decoration: BoxDecoration(color: Colors.blue),
      //         child: Text('Drawer Header'),
      //       ),
      //       ListTile(title: const Text('Home')),
      //       ListTile(title: const Text('Business')),
      //       ListTile(title: const Text('School')),
      //     ],
      //   ),
      // ),
      body: _pages[_selectedKey] ?? const SizedBox(),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPage()),
          );
        },
        child: HugeIcon(
          icon: HugeIcons.strokeRoundedPlusSign,
          color: Colors.white,
          size: 24,
          strokeWidth: 4,
        ),
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

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        // Show SnackBar example
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Hello from FAB!'),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
              bottom: 100, // Adjust based on your bottom bar height
              left: 20,
              right: 20,
            ),
          ),
        );
      },
      child: Icon(Icons.add),
      backgroundColor: Colors.blue,
    );
  }
}
