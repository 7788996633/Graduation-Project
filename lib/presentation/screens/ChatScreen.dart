import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:graduation/constant.dart';
import 'package:graduation/reverbService.dart';
import 'package:graduation/data/models/chat_model.dart';

class ChatScreen extends StatefulWidget {
  final int myUserId;
  final int receiverId;
  final String receiverName;

  ChatScreen({
    required this.myUserId,
    required this.receiverId,
    required this.receiverName,
  });

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
    _fetchMessages();
    _listenToMessages();
  }

  void _listenToMessages() {
    _reverbService.stream.listen((data) {
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
        print('❌ خطأ في تحليل الرسالة من WebSocket: $e');
      }
    }, onError: (error) {
      print("❌ خطأ في WebSocket: $error");
    }, onDone: () {
      print("🔌 تم إغلاق الاتصال بـ WebSocket.");
    });
  }

  Future<void> _fetchMessages() async {
    final url = Uri.parse('http://$ip:8000/api/messages/${widget.receiverId}');
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
        'sender_id': widget.myUserId,
        'receiver_id': widget.receiverId,
        'content': text,
      };

      final url = Uri.parse('http://$ip:8000/api/messages');

      try {
        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(message),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
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
      appBar: AppBar(
        title: Text('المحادثة مع ${widget.receiverName}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isMe = message.senderId == widget.myUserId;

                return Align(
                  alignment:
                      isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    padding: EdgeInsets.all(12),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    decoration: BoxDecoration(
                      color: isMe ? Colors.blue[200] : Colors.grey[300],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                        bottomLeft:
                            isMe ? Radius.circular(12) : Radius.circular(0),
                        bottomRight:
                            isMe ? Radius.circular(0) : Radius.circular(12),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: isMe
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Text(
                          message.message,
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 4),
                        Text(
                          DateFormat('HH:mm').format(message.createdAt!),
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'أدخل رسالة...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: IconButton(
                    icon: Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
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
