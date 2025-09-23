import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:qalb/screens/add/new_person.dart';
import 'package:qalb/screens/chat/chat.dart';
import 'package:qalb/widgets/avatar.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  // 🔽 Mock user data with profile images + ID
  final List<Map<String, dynamic>> mockUsers = const [
    {
      "id": "1",
      "name": "John Doe",
      "type": "Mobile",
      "image": "https://i.pravatar.cc/150?img=1",
      "isActive": true,
    },
    {
      "id": "2",
      "name": "Alice Smith",
      "type": "Work",
      "image": "https://i.pravatar.cc/150?img=2",
      "isActive": false,
    },
    {
      "id": "3",
      "name": "Michael Brown",
      "type": "Home",
      "image": "https://i.pravatar.cc/150?img=3",
      "isActive": true,
    },
    {
      "id": "4",
      "name": "Sophia Johnson",
      "type": "Mobile",
      "image": "https://i.pravatar.cc/150?img=4",
      "isActive": false,
    },
    {
      "id": "5",
      "name": "David Wilson",
      "type": "Other",
      "image": "https://i.pravatar.cc/150?img=5",
      "isActive": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New", style: Theme.of(context).textTheme.titleLarge),
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
        actions: [
          IconButton(
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedQrCode01,
              color: Theme.of(context).iconTheme.color as Color,
              size: 24,
              strokeWidth: 2,
            ),
            onPressed: () => _openQrScanner(context),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔽 First Section
          Column(
            children: [
              _buildListItem(
                icon: HugeIcon(
                  icon: HugeIcons.strokeRoundedUserAdd02,
                  color: Theme.of(context).colorScheme.primary,
                  size: 24,
                  strokeWidth: 2,
                ),
                text: "New person",
                subtitle: "Add a person by phone number.",
                color: Theme.of(context).colorScheme.primary.withAlpha(20),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddNewPersonPage(),
                    ),
                  );
                },
                context: context,
              ),
              _buildListItem(
                icon: HugeIcon(
                  icon: HugeIcons.strokeRoundedAddTeam,
                  color: Theme.of(context).colorScheme.primary,
                  size: 24,
                  strokeWidth: 2,
                ),
                text: "New group",
                subtitle: "Create group to send messages, media and call.",
                color: Theme.of(context).colorScheme.primary.withAlpha(20),
                context: context,
              ),
              _buildListItem(
                icon: HugeIcon(
                  icon: HugeIcons.strokeRoundedUserAdd02,
                  color: Theme.of(context).colorScheme.primary,
                  size: 24,
                  strokeWidth: 2,
                ),
                text: "New channel",
                subtitle: "Create channel to send post and media.",
                color: Theme.of(context).colorScheme.primary.withAlpha(20),
                context: context,
              ),
            ],
          ),
          const SizedBox(height: 25),

          // 🔽 Second Section
          const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              "All contacts",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(height: 15),

          // 🔽 Render user mock data
          Expanded(
            child: ListView.separated(
              itemCount: mockUsers.length,
              separatorBuilder: (_, __) => const SizedBox(height: 0),
              itemBuilder: (context, index) {
                final user = mockUsers[index];
                return _userItem(
                  id: user["id"]!,
                  name: user["name"]!,
                  type: user["type"]!,
                  imageUrl: user["image"]!,
                  isActive: user["isActive"]!,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChatPage(
                          userId: user["id"]!,
                          name: user["name"]!,
                          imageUrl: user["image"]!,
                        ),
                      ),
                    );
                  },
                  context: context,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _openQrScanner(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // prevent tap outside to close
      builder: (context) {
        final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
        QRViewController? controller;

        return Dialog(
          insetPadding: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.95,
            height: MediaQuery.of(context).size.height * 0.7,
            child: Column(
              children: [
                // 🔹 Top Bar with Back Button
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    // color: Colors.green.shade600,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          controller?.dispose();
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          // color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const Text(
                        "Scan QR Code",
                        style: TextStyle(
                          fontFamily: "Poppins", // 👈 custom font
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          // color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 24), // keep title centered
                    ],
                  ),
                ),

                // 🔹 Scanner View
                Expanded(
                  flex: 5,
                  child: QRView(
                    key: qrKey,
                    onQRViewCreated: (ctrl) {
                      controller = ctrl;
                      controller?.scannedDataStream.listen((scanData) {
                        Navigator.pop(context); // close dialog
                        controller?.dispose();

                        // 🔽 Handle scanned result
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "QR Code: ${scanData.code}",
                              style: const TextStyle(fontFamily: "Poppins"),
                            ),
                          ),
                        );
                      });
                    },
                  ),
                ),
                // Expanded(flex: 5, child: Container()),

                // 🔹 Bottom Section
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Scan iChat QR Code to connect",
                        style: TextStyle(
                          fontFamily: "Poppins", // 👈 custom font
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildListItem({
    required HugeIcon icon,
    required String text,
    String? subtitle,
    required Color color,
    VoidCallback? onTap,
    required BuildContext context,
  }) {
    return InkWell(
      onTap: () => onTap?.call(),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          top: 10,
          bottom: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(child: icon),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.titleLarge!.color,
                      ),
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(
                              color: Theme.of(
                                context,
                              ).textTheme.titleLarge!.color?.withAlpha(150),
                            ),
                      ),
                  ],
                ),
              ],
            ),
            Icon(
              Icons.keyboard_arrow_right,
              size: 28,
              color: Theme.of(context).iconTheme.color,
            ),
          ],
        ),
      ),
    );
  }

  Widget _userItem({
    required String id,
    required String name,
    required String type,
    required String imageUrl,
    required VoidCallback onTap,
    bool isActive = true,
    required BuildContext context,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Avatar(
                  imageUrl: imageUrl,
                  isOnline: isActive,
                  context: context,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.titleLarge!.color,
                      ),
                    ),
                    Text(
                      type,
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(
                          context,
                        ).textTheme.titleLarge!.color?.withAlpha(150),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            HugeIcon(
              icon: HugeIcons.strokeRoundedMessage02,
              size: 24,
              color: Theme.of(context).iconTheme.color as Color,
            ),
          ],
        ),
      ),
    );
  }
}
