import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';
import 'package:qalb/db/helper.dart';
import 'package:qalb/screens/add/add_page.dart';
import 'package:qalb/screens/call_page.dart';
import 'package:qalb/screens/channel_page.dart';
import 'package:qalb/screens/group_page.dart';
import 'package:qalb/screens/home/chat_page.dart';
import 'package:qalb/screens/profile/profile.dart';
import 'package:qalb/screens/welcome/welcome.dart';
import 'package:qalb/theme_manager.dart';

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
    return ChangeNotifierProvider(
      create: (context) => ThemeManager(),
      child: Consumer<ThemeManager>(
        builder: (context, themeManager, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'DeenCircle',
            theme: themeManager.currentTheme,
            // Remove themeMode and darkTheme to prevent system override
            home: isLoggedIn ? const MyHomePage() : const WelcomePage(),
          );
        },
      ),
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
      appBar: AppBar(
        title: Text(
          "DeenCircle",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(
            thickness: 0.5,
            height: 0.5,
            color: Theme.of(context).dividerColor,
          ),
        ),
        actionsPadding: const EdgeInsets.only(right: 20),
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
              backgroundImage: NetworkImage(
                "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=580&q=80",
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPage()),
          );
        },
        shape: const CircleBorder(),
        elevation: 0,
        child: HugeIcon(
          icon: HugeIcons.strokeRoundedAdd01,
          color: Colors.white,
          size: 30,
          strokeWidth: 2,
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
}
