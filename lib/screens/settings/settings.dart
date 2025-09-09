import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(
            thickness: 0.5,
            height: 0.5,
            color: Colors.black.withOpacity(0.1),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Column(
              children: const [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=580&q=80",
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Muhammad Imran Hossain",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "@mdimranh",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Account Section
            _settingSection("Account", [
              {
                "title": "Profile",
                "icon": Icons.person,
                "description": "View and edit your profile",
              },
              {
                "title": "Password",
                "icon": Icons.lock,
                "description": "Change your password",
              },
            ]),

            const SizedBox(height: 20),

            // Security Section
            _settingSection("Security", [
              {
                "title": "Two-Factor Authentication",
                "icon": Icons.security,
                "description": "Add extra security",
              },
              {
                "title": "Devices",
                "icon": Icons.devices,
                // no description → optional
              },
            ]),
          ],
        ),
      ),
    );
  }

  Widget _settingSection(String title, List<Map<String, dynamic>> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title
        Padding(
          padding: const EdgeInsets.only(bottom: 8, left: 18),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
        ),
        Column(
          children: items.map((item) {
            return InkWell(
              onTap: () {
                // Handle navigation
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 18,
                ),
                child: Row(
                  children: [
                    Icon(item["icon"], color: Colors.green, size: 22),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item["title"],
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          if (item["description"] != null) ...[
                            // const SizedBox(height: 2),
                            Text(
                              item["description"],
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
