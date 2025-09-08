import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String userId;
  final String name;
  final String imageUrl;

  const ChatPage({
    super.key,
    required this.userId,
    required this.name,
    required this.imageUrl,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  bool _showEmoji = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(
            thickness: 0.5,
            height: 0.5,
            color: Colors.black.withOpacity(0.1),
          ),
        ),
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            CircleAvatar(backgroundImage: NetworkImage(widget.imageUrl)),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text("Active now", style: TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.call), onPressed: () {}),
          IconButton(icon: const Icon(Icons.videocam), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          // 🔽 Example messages
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/bg1.jpg"),
                  fit: BoxFit.cover, // make sure it covers the whole screen
                  opacity: 0.5,
                ),
              ),
              child: ListView(
                padding: const EdgeInsets.all(12),
                children: [
                  MessageBubble(
                    text: "Hello ${widget.name} 👋",
                    isMe: true,
                    time: "10:00 AM",
                  ),
                  const MessageBubble(
                    text: "Hi! How are you?",
                    isMe: false,
                    time: "10:02 AM",
                  ),
                ],
              ),
            ),
          ),

          // 🔽 Input bar
          SafeArea(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Emoji button
                      IconButton(
                        icon: const Icon(
                          Icons.emoji_emotions_outlined,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          setState(() => _showEmoji = !_showEmoji);
                        },
                      ),

                      // File button
                      IconButton(
                        icon: const Icon(
                          Icons.attach_file,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          print("📎 Pick a file");
                        },
                      ),

                      // Text field
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextField(
                            controller: _controller,
                            keyboardType: TextInputType.multiline,
                            minLines: 1, // start with 1 line
                            maxLines: 4, // expand up to 5 lines
                            decoration: const InputDecoration(
                              hintText: "Message...",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),

                      // Send button
                      IconButton(
                        icon: const Icon(Icons.send, color: Colors.green),
                        onPressed: () {
                          print("Send: ${_controller.text}");
                          _controller.clear();
                        },
                      ),
                    ],
                  ),
                ),

                // 🔽 Emoji picker
                if (_showEmoji)
                  SizedBox(
                    height: 350,
                    child: EmojiPicker(
                      textEditingController: _controller,
                      config: Config(
                        height: 300,
                        checkPlatformCompatibility: true,
                        viewOrderConfig: const ViewOrderConfig(),
                        emojiViewConfig: EmojiViewConfig(emojiSizeMax: 28),
                        skinToneConfig: const SkinToneConfig(),
                        categoryViewConfig: const CategoryViewConfig(
                          indicatorColor: Colors.green,
                          iconColorSelected: Colors.green,
                        ),
                        bottomActionBarConfig: const BottomActionBarConfig(
                          buttonColor: Colors.transparent,
                          buttonIconColor: Colors.green,
                          backgroundColor: Colors.white,
                        ),
                        searchViewConfig: const SearchViewConfig(),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String text;
  final String time;
  final bool isMe;

  const MessageBubble({
    super.key,
    required this.text,
    required this.isMe,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isMe ? Colors.green.shade600 : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: isMe ? const Radius.circular(12) : Radius.zero,
            bottomRight: isMe ? Radius.zero : const Radius.circular(12),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 3),
          ],
        ),
        child: Column(
          crossAxisAlignment: isMe
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: TextStyle(
                color: isMe ? Colors.white : Colors.black87,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              time,
              style: TextStyle(
                fontSize: 10,
                color: isMe ? Colors.white70 : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
