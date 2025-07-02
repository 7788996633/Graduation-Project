import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:graduation/constant.dart';
import 'package:graduation/data/models/chat_model.dart';
import 'package:graduation/reverbService.dart';
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
    _listenToMessages();
  }

  void _listenToMessages() {
    _reverbService.stream.listen((data) {
      print("📩 البيانات المستلمة: $data");
      try {
        final decoded = jsonDecode(data);

        if (decoded['event'] == 'new.message') {
          final innerData = jsonDecode(decoded['data']);
          final messageJson = innerData['message'];

          setState(() {
            _messages.add(ChatModel.fromJson(messageJson));
          });
        }
      } catch (e) {
        print('❌ خطأ في تحليل الرسالة: $e');
      }
    }, onError: (error) {
      print("❌ خطأ في WebSocket: $error");
    }, onDone: () {
      print("🔌 الاتصال تم إغلاقه.");
    });
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isNotEmpty) {
      final message = {
        'sender': 'Flutter',
        'content': text,
        'timestamp': DateTime.now().toIso8601String(),
      };
      _reverbService.sendMessage(message);
      _messageController.clear();
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
