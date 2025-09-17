import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:qalb/screens/chat/chat.dart';
import 'package:qalb/widgets/avatar.dart';

class HomeChatPage extends StatelessWidget {
  HomeChatPage({super.key});

  final List chatListData = [
    {
      "id": "1",
      "name": "John Doe",
      "image": "https://i.pravatar.cc/150?img=1",
      "lastMessage": "Hello",
      "lastMessageTime": "2:30 PM",
      "isOnline": true,
      "isFavorite": true,
      "isMuted": false,
    },
    {
      "id": "2",
      "name": "Alice Smith",
      "image": "https://i.pravatar.cc/150?img=2",
      "lastMessage": "See you tomorrow at 3 PM.",
      "lastMessageTime": "1:15 PM",
      "isOnline": false,
      "isFavorite": true,
      "isMuted": true,
    },
    {
      "id": "3",
      "name": "Michael Johnson",
      "image": "https://i.pravatar.cc/150?img=3",
      "lastMessage": "How are you?",
      "lastMessageTime": "12:40 PM",
      "isOnline": true,
      "isFavorite": false,
      "isMuted": false,
    },
    {
      "id": "4",
      "name": "Emily Davis",
      "image": "https://i.pravatar.cc/150?img=4",
      "lastMessage": "Thanks!",
      "lastMessageTime": "11:05 AM",
      "isOnline": false,
      "isFavorite": false,
      "isMuted": false,
    },
    {
      "id": "5",
      "name": "David Wilson",
      "image": "https://i.pravatar.cc/150?img=5",
      "lastMessage": "On my way",
      "lastMessageTime": "10:20 AM",
      "isOnline": true,
      "isFavorite": false,
      "isMuted": false,
    },
    {
      "id": "6",
      "name": "Sophia Martinez",
      "image": "https://i.pravatar.cc/150?img=6",
      "lastMessage": "Let’s meet up",
      "lastMessageTime": "9:55 AM",
      "isOnline": true,
      "isFavorite": false,
      "isMuted": false,
    },
    {
      "id": "7",
      "name": "Daniel Brown",
      "image": "https://i.pravatar.cc/150?img=7",
      "lastMessage": "Good night",
      "lastMessageTime": "Yesterday",
      "isOnline": false,
      "isFavorite": false,
      "isMuted": false,
    },
    {
      "id": "8",
      "name": "Olivia Taylor",
      "image": "https://i.pravatar.cc/150?img=8",
      "lastMessage": "Call me",
      "lastMessageTime": "10:45 PM",
      "isOnline": true,
      "isFavorite": false,
      "isMuted": false,
    },
    {
      "id": "9",
      "name": "James Anderson",
      "image": "https://i.pravatar.cc/150?img=9",
      "lastMessage": "Where are you?",
      "lastMessageTime": "9:15 PM",
      "isOnline": false,
      "isFavorite": false,
      "isMuted": false,
    },
    {
      "id": "10",
      "name": "Isabella Thomas",
      "image": "https://i.pravatar.cc/150?img=10",
      "lastMessage": "I’ll send it",
      "lastMessageTime": "8:05 PM",
      "isOnline": true,
      "isFavorite": false,
      "isMuted": false,
    },
    {
      "id": "11",
      "name": "Ethan Moore",
      "image": "https://i.pravatar.cc/150?img=11",
      "lastMessage": "Let’s go",
      "lastMessageTime": "7:30 PM",
      "isOnline": true,
      "isFavorite": false,
      "isMuted": false,
    },
    {
      "id": "12",
      "name": "Mia Jackson",
      "image": "https://i.pravatar.cc/150?img=12",
      "lastMessage": "Cool 👍",
      "lastMessageTime": "6:40 PM",
      "isOnline": false,
      "isFavorite": false,
      "isMuted": false,
    },
    {
      "id": "13",
      "name": "Benjamin White",
      "image": "https://i.pravatar.cc/150?img=13",
      "lastMessage": "Yes",
      "lastMessageTime": "5:50 PM",
      "isOnline": true,
      "isFavorite": false,
      "isMuted": false,
    },
    {
      "id": "14",
      "name": "Charlotte Harris",
      "image": "https://i.pravatar.cc/150?img=14",
      "lastMessage": "No worries",
      "lastMessageTime": "4:30 PM",
      "isOnline": false,
      "isFavorite": false,
      "isMuted": true,
    },
    {
      "id": "15",
      "name": "Henry Clark",
      "image": "https://i.pravatar.cc/150?img=15",
      "lastMessage": "Haha 😂",
      "lastMessageTime": "3:10 PM",
      "isOnline": true,
      "isFavorite": false,
      "isMuted": false,
    },
    {
      "id": "16",
      "name": "Amelia Lewis",
      "image": "https://i.pravatar.cc/150?img=16",
      "lastMessage": "Okay",
      "lastMessageTime": "2:50 PM",
      "isOnline": true,
      "isFavorite": false,
      "isMuted": false,
    },
    {
      "id": "17",
      "name": "Alexander Lee",
      "image": "https://i.pravatar.cc/150?img=17",
      "lastMessage": "What’s up?",
      "lastMessageTime": "1:25 PM",
      "isOnline": false,
      "isFavorite": false,
      "isMuted": false,
    },
    {
      "id": "18",
      "name": "Harper Walker",
      "image": "https://i.pravatar.cc/150?img=18",
      "lastMessage": "See you soon",
      "lastMessageTime": "12:05 PM",
      "isOnline": true,
      "isFavorite": false,
      "isMuted": false,
    },
    {
      "id": "19",
      "name": "William Hall",
      "image": "https://i.pravatar.cc/150?img=19",
      "lastMessage": "Done",
      "lastMessageTime": "11:55 AM",
      "isOnline": false,
      "isFavorite": false,
      "isMuted": false,
    },
    {
      "id": "20",
      "name": "Evelyn Allen",
      "image": "https://i.pravatar.cc/150?img=20",
      "lastMessage": "Great!",
      "lastMessageTime": "10:40 AM",
      "isOnline": true,
      "isFavorite": false,
      "isMuted": true,
    },
    {
      "id": "21",
      "name": "Sebastian Young",
      "image": "https://i.pravatar.cc/150?img=21",
      "lastMessage": "Alright",
      "lastMessageTime": "9:20 AM",
      "isOnline": true,
      "isFavorite": false,
      "isMuted": false,
    },
    {
      "id": "22",
      "name": "Abigail King",
      "image": "https://i.pravatar.cc/150?img=22",
      "lastMessage": "Talk later",
      "lastMessageTime": "8:15 AM",
      "isOnline": false,
      "isFavorite": false,
      "isMuted": false,
    },
    {
      "id": "23",
      "name": "Jack Wright",
      "image": "https://i.pravatar.cc/150?img=23",
      "lastMessage": "Be safe",
      "lastMessageTime": "7:05 AM",
      "isOnline": true,
      "isFavorite": false,
      "isMuted": false,
    },
    {
      "id": "24",
      "name": "Ella Scott",
      "image": "https://i.pravatar.cc/150?img=24",
      "lastMessage": "I agree",
      "lastMessageTime": "6:50 AM",
      "isOnline": false,
      "isFavorite": false,
      "isMuted": false,
    },
    {
      "id": "25",
      "name": "Lucas Green",
      "image": "https://i.pravatar.cc/150?img=25",
      "lastMessage": "Perfect",
      "lastMessageTime": "5:30 AM",
      "isOnline": true,
      "isFavorite": false,
      "isMuted": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // 🔍 Search Section
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(50),
                ),
                filled: true,
                fillColor: Colors.black.withOpacity(0.06),
                prefixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).iconTheme.color,
                  size: 24,
                ),
                hintText: "Search",
                isDense: true,
              ),
            ),
          ),
        ),

        // 💬 Chat List
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final user = chatListData[index];
            return _userItem(
              id: user["id"].toString(),
              name: user["name"].toString(),
              lastMessage: user["lastMessage"].toString(),
              lastMessageTime: user["lastMessageTime"].toString(),
              imageUrl: user["image"].toString(),
              isActive: user["isOnline"] as bool,
              isFavorite: user["isFavorite"] as bool,
              isMuted: user["isMuted"] as bool,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatPage(
                      userId: user["id"].toString(),
                      name: user["name"].toString(),
                      imageUrl: user["image"].toString(),
                    ),
                  ),
                );
              },
              context: context,
            );
          }, childCount: chatListData.length),
        ),
      ],
    );
  }

  Widget _userItem({
    required String id,
    required String name,
    required String lastMessage,
    required String lastMessageTime,
    required String imageUrl,
    required bool isFavorite,
    required bool isMuted,
    required VoidCallback onTap,
    bool isActive = true,
    required BuildContext context,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
                    Text(name, style: Theme.of(context).textTheme.titleMedium),
                    Row(
                      children: [
                        Text(
                          lastMessage,
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).textTheme.labelSmall?.color?.withOpacity(0.7),
                              ),
                        ),
                        const SizedBox(width: 10),
                        Icon(
                          Icons.circle,
                          size: 6,
                          color: Theme.of(
                            context,
                          ).textTheme.labelSmall?.color?.withOpacity(0.7),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "2:30 PM",
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).textTheme.labelSmall?.color?.withOpacity(0.7),
                              ),
                        ),
                        const SizedBox(width: 5),
                        const Icon(
                          Icons.done_all,
                          size: 16,
                          color: Colors.black54,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (isFavorite)
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      HugeIcon(
                        icon: HugeIcons.strokeRoundedPin02,
                        color: Theme.of(context).iconTheme.color as Color,
                        size: 22,
                        strokeWidth: 2,
                      ),
                    ],
                  ),
                if (isMuted)
                  Row(
                    children: [
                      SizedBox(width: 10),
                      HugeIcon(
                        icon: HugeIcons.strokeRoundedNotificationOff01,
                        color: Theme.of(context).iconTheme.color as Color,
                        size: 20,
                        strokeWidth: 2,
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
