import 'package:flutter/material.dart';
import 'package:qalb/screens/chat_page.dart';
import 'package:qalb/screens/group_page.dart';
import 'package:qalb/screens/settings/settings.dart';

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
      title: 'Qalb',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
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
    "chat": const ChatPage(),
    "call": const CallPage(),
    "group": const GroupPage(),
    "channel": const ChannelPage(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "Qalb",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
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
                      const SettingsPage(), // 🔽 your settings page
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
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Drawer Header'),
            ),
            ListTile(title: const Text('Home')),
            ListTile(title: const Text('Business')),
            ListTile(title: const Text('School')),
          ],
        ),
      ),
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
