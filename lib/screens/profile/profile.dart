import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
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
                "icon": HugeIcon(
                  icon: HugeIcons.strokeRoundedUser,
                  color: Colors.green,
                  size: 24,
                  strokeWidth: 2,
                ),
                "description": "View and edit your profile",
              },
              {
                "title": "Password",
                "icon": HugeIcon(
                  icon: HugeIcons.strokeRoundedLockPassword,
                  color: Colors.green,
                  size: 24,
                  strokeWidth: 2,
                ),
                "description": "Change your password",
              },
            ]),

            const SizedBox(height: 15),

            // Security Section
            _settingSection("Security", [
              {
                "title": "Two-Factor Authentication",
                "icon": HugeIcon(
                  icon: HugeIcons.strokeRoundedTwoFactorAccess,
                  color: Colors.green,
                  size: 24,
                  strokeWidth: 2,
                ),
                "description": "Add extra security",
              },
              {
                "title": "Devices",
                "icon": HugeIcon(
                  icon: HugeIcons.strokeRoundedDeviceAccess,
                  color: Colors.green,
                  size: 24,
                  strokeWidth: 2,
                ),
                // no description → optional
              },
            ]),
          ],
        ),
      ),
    );
  }

  Widget _settingSection(String title, List<Map<String, dynamic>> items) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 10),
          Column(
            children: items.map((item) {
              return Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: InkWell(
                  onTap: () {
                    // Handle navigation
                  },
                  child: Row(
                    children: [
                      // Icon(item["icon"], color: Colors.green, size: 22),
                      item["icon"],
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
      ),
    );
  }
}
