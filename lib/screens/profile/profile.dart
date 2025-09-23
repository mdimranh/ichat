import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';
import 'package:qalb/db/helper.dart';
import 'package:qalb/theme_manager.dart';

final db = DBHelper();

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu", style: Theme.of(context).textTheme.titleLarge),
        backgroundColor: Theme.of(context).colorScheme.surface,
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
          HugeIcon(
            icon: HugeIcons.strokeRoundedQrCode,
            color: Theme.of(context).iconTheme.color as Color,
            size: 24,
            strokeWidth: 2,
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: db.getUserDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error loading user data: ${snapshot.error}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('No user data found'));
          }

          final user = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                        "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=580&q=80",
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "${user['firstName'] ?? ''} ${user['lastName'] ?? ''}"
                          .trim(),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      user['username'] ?? '',
                      style: Theme.of(context).textTheme.bodyMedium,
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
                      color: Theme.of(context).iconTheme.color as Color,
                      size: 24,
                      strokeWidth: 2,
                    ),
                    "description": "View and edit your profile",
                  },
                  {
                    "title": "Password",
                    "icon": HugeIcon(
                      icon: HugeIcons.strokeRoundedLockPassword,
                      color: Theme.of(context).iconTheme.color as Color,
                      size: 24,
                      strokeWidth: 2,
                    ),
                    "description": "Change your password",
                  },
                ], context),

                // Security Section
                _settingSection("Security", [
                  {
                    "title": "Two-Factor Authentication",
                    "icon": HugeIcon(
                      icon: HugeIcons.strokeRoundedTwoFactorAccess,
                      color: Theme.of(context).iconTheme.color as Color,
                      size: 24,
                      strokeWidth: 2,
                    ),
                    "description": "Add extra security",
                  },
                  {
                    "title": "Devices",
                    "icon": HugeIcon(
                      icon: HugeIcons.strokeRoundedDeviceAccess,
                      color: Theme.of(context).iconTheme.color as Color,
                      size: 24,
                      strokeWidth: 2,
                    ),
                    "description": "Manage your devices",
                  },
                ], context),

                // Settings
                _settingSection("Settings", [
                  {
                    "title": "Accessibility",
                    "icon": HugeIcon(
                      icon: HugeIcons.strokeRoundedUniversalAccess,
                      color: Theme.of(context).iconTheme.color as Color,
                      size: 24,
                      strokeWidth: 2,
                    ),
                    "description": "Adjust accessibility settings",
                  },
                  {
                    "title": "Notifications",
                    "icon": HugeIcon(
                      icon: HugeIcons.strokeRoundedNotification02,
                      color: Theme.of(context).iconTheme.color as Color,
                      size: 24,
                      strokeWidth: 2,
                    ),
                    "description": "Manage your notifications",
                  },
                  {
                    "title": "Data and Storage",
                    "icon": HugeIcon(
                      icon: HugeIcons.strokeRoundedDatabaseSetting,
                      color: Theme.of(context).iconTheme.color as Color,
                      size: 24,
                      strokeWidth: 2,
                    ),
                    "description": "Control how your data is used",
                  },
                  {
                    "title": "Theme",
                    "icon": HugeIcon(
                      icon: HugeIcons.strokeRoundedMoon,
                      color: Theme.of(context).iconTheme.color as Color,
                      size: 24,
                      strokeWidth: 2,
                    ),
                    "description":
                        Theme.of(context).brightness == Brightness.dark
                        ? "Dark"
                        : "Light",
                    "onTap": () async {
                      final selectedTheme = await showDialog<ThemeMode>(
                        context: context,
                        builder: (context) {
                          ThemeMode tempSelection =
                              Theme.of(context).brightness == Brightness.dark
                              ? ThemeMode.dark
                              : ThemeMode.light;

                          return StatefulBuilder(
                            builder: (context, setState) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                title: Text(
                                  "Choose Theme",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    RadioListTile<ThemeMode>(
                                      value: ThemeMode.light,
                                      groupValue: tempSelection,
                                      title: const Text("Light"),
                                      secondary: const Icon(
                                        Icons.light_mode_outlined,
                                      ),
                                      onChanged: (value) {
                                        setState(() => tempSelection = value!);
                                      },
                                      contentPadding: EdgeInsets.zero,
                                    ),
                                    RadioListTile<ThemeMode>(
                                      value: ThemeMode.dark,
                                      groupValue: tempSelection,
                                      title: const Text("Dark"),
                                      secondary: const Icon(
                                        Icons.dark_mode_outlined,
                                      ),
                                      onChanged: (value) {
                                        setState(() => tempSelection = value!);
                                      },
                                      contentPadding: EdgeInsets.zero,
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, null),
                                    child: const Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, tempSelection),
                                    child: const Text("OK"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );

                      if (selectedTheme != null) {
                        final themeManager = context.read<ThemeManager>();
                        if (selectedTheme == ThemeMode.dark) {
                          themeManager.setTheme(true);
                        } else if (selectedTheme == ThemeMode.light) {
                          themeManager.setTheme(false);
                        } else {
                          themeManager.setTheme(false);
                        }
                      }
                    },
                  },
                ], context),
                const SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _settingSection(
    String title,
    List<Map<String, dynamic>> items,
    BuildContext context,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 10, 0),
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(
                  context,
                ).textTheme.bodyMedium?.color?.withAlpha(200),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Column(
            children: items.map((item) {
              return InkWell(
                onTap: () {
                  item["onTap"]?.call();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      item["icon"],
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item["title"],
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            if (item["description"] != null) ...[
                              Text(
                                item["description"],
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.color
                                          ?.withAlpha(160),
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
