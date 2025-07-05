import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:graduation/constant.dart';
import 'package:graduation/data/models/chat_model.dart';

class ChatScreen extends StatefulWidget {
  final int myUserId;
  const ChatScreen({
    super.key,
    required this.myUserId,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<ChatModel> messages = [];
  TextEditingController controller = TextEditingController();
  late ChatModel chat;
  late Socket socket;

  @override
  void initState() {
    super.initState();

    socket.listen((data) {
      final jsonData = json.decode(utf8.decode(data));
      final msg = ChatModel.fromJson(jsonData);

      if ((msg.senderId == chat.receiverId &&
              msg.receiverId == widget.myUserId) ||
          (msg.senderId == widget.myUserId &&
              msg.receiverId == chat.receiverId)) {
        setState(() {
          messages.add(msg);
        });
      }
    });
  }

  void sendMessage() {
    if (controller.text.trim().isEmpty) return;

    final message = ChatModel(
      senderId: widget.myUserId,
      receiverId: chat.receiverId,
      message: controller.text.trim(),
      createdAt: DateTime.now(),
      isRead: false,
      updatedAt: null,
    );
    socket.add(utf8.encode(json.encode(message.toJson())));

    setState(() {
      messages.add(message);
      controller.clear();
    });
  }

  String getSenderName(ChatModel message) {
    if (myRole != 2) {
      return "اسم الشركة";
    } else {
      return "العميل ";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("الدردشة")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              reverse: true,
              itemBuilder: (context, index) {
                final msg = messages[messages.length - 1 - index];
                final isMe = msg.senderId == widget.myUserId;

                return Align(
                  alignment:
                      isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isMe ? Colors.blue[100] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(getSenderName(msg),
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(msg.message),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(child: TextField(controller: controller)),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
