import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:graduation/constant.dart';
import 'package:graduation/data/models/chat_model.dart';
import 'package:graduation/reverbService.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final ReverbService _reverbService;
  final TextEditingController _messageController = TextEditingController();
  final List<ChatModel> _messages = [];

  @override
  void initState() {
    super.initState();
    _reverbService = ReverbService();
    _reverbService.connect(
      'ws://$ip:7000/app/abc123def456xyz789?protocol=7&client=js&version=7.0&flash=false',
    );
    _sendMessage();
    _fetchMessages();
  }

  Future<void> _fetchMessages() async {
    final url = Uri.parse('http://$ip:8000/api/messages/1'); // 1 هو userId
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        final List<ChatModel> loadedMessages = jsonData.map((item) {
          return ChatModel.fromJson(item);
        }).toList();

        setState(() {
          _messages.addAll(loadedMessages);
        });
      } else {
        print("❌ فشل في تحميل الرسائل: ${response.body}");
      }
    } catch (e) {
      print("❌ خطأ في تحميل الرسائل: $e");
    }
  }

  void _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isNotEmpty) {
      final message = {
        'sender_id': 1,
        'receiver_id': 2,
        'content': text,
      };

      final url = Uri.parse('http://$ip:8000/api/messages'); // Laravel API

      try {
        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(message),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          print("✅ الرسالة أُرسلت وتم بثها");
          _messageController.clear();
        } else {
          print("❌ فشل في الإرسال: ${response.body}");
        }
      } catch (e) {
        print("❌ خطأ أثناء الإرسال: $e");
      }
    }
  }

  @override
  void dispose() {
    _reverbService.disconnect();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('الدردشة')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ListTile(
                  title: Text(message.message),
                  subtitle: Text(message.senderId.toString()),
                  trailing: Text(
                    DateFormat('HH:mm').format(message.createdAt!),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(hintText: 'أدخل رسالة...'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
