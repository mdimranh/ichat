import 'package:flutter/material.dart';
import 'package:qalb/screens/chat/chat.dart'; // import chat page

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  // 🔽 Mock user data with profile images + ID
  final List<Map<String, String>> mockUsers = const [
    {
      "id": "1",
      "name": "John Doe",
      "type": "Mobile",
      "image": "https://i.pravatar.cc/150?img=1",
    },
    {
      "id": "2",
      "name": "Alice Smith",
      "type": "Work",
      "image": "https://i.pravatar.cc/150?img=2",
    },
    {
      "id": "3",
      "name": "Michael Brown",
      "type": "Home",
      "image": "https://i.pravatar.cc/150?img=3",
    },
    {
      "id": "4",
      "name": "Sophia Johnson",
      "type": "Mobile",
      "image": "https://i.pravatar.cc/150?img=4",
    },
    {
      "id": "5",
      "name": "David Wilson",
      "type": "Other",
      "image": "https://i.pravatar.cc/150?img=5",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Connection"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            thickness: 0.5,
            height: 0.5,
            color: Colors.black.withOpacity(0.1),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔽 First Section
            Column(
              children: [
                _buildListItem(
                  icon: Icons.person_add_alt_1,
                  text: "New person",
                  subtitle: "Add a person by phone number.",
                  color: Colors.green.shade600,
                ),
                const SizedBox(height: 15),
                _buildListItem(
                  icon: Icons.group_add,
                  text: "New group",
                  subtitle: "Create group to send messages, media and call.",
                  color: Colors.green.shade600,
                ),
                const SizedBox(height: 15),
                _buildListItem(
                  icon: Icons.library_add,
                  text: "New channel",
                  subtitle: "Create channel to send post and media.",
                  color: Colors.green.shade600,
                ),
              ],
            ),
            const SizedBox(height: 25),

            // 🔽 Second Section
            const Text(
              "All contacts",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 15),

            // 🔽 Render user mock data
            Expanded(
              child: ListView.separated(
                itemCount: mockUsers.length,
                separatorBuilder: (_, __) => const SizedBox(height: 15),
                itemBuilder: (context, index) {
                  final user = mockUsers[index];
                  return _userItem(
                    id: user["id"]!,
                    name: user["name"]!,
                    type: user["type"]!,
                    imageUrl: user["image"]!,
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem({
    required IconData icon,
    required String text,
    String? subtitle,
    required Color color,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(icon, size: 25, color: color),
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
                    color: Colors.black.withOpacity(0.8),
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
              ],
            ),
          ],
        ),
        Icon(
          Icons.keyboard_arrow_right,
          size: 28,
          color: Colors.black.withOpacity(0.5),
        ),
      ],
    );
  }

  Widget _userItem({
    required String id,
    required String name,
    required String type,
    required String imageUrl,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(imageUrl),
                backgroundColor: Colors.green.shade100,
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
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                  Text(
                    type,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Icon(Icons.chat, size: 20, color: Colors.black.withOpacity(0.7)),
        ],
      ),
    );
  }
}
