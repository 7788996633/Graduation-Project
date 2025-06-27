import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:web_socket_channel/web_socket_channel.dart';


import 'constant.dart';




class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final String socketUrl = 'ws://$ip:7000/app/abc123def456xyz789?protocol=7&client=js&version=7.0&flash=false'; // مثال https://
  final String apiUrl = 'http://your-laravel-server.com/api/chat/send';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatPage(socketUrl: socketUrl, apiUrl: apiUrl),
    );
  }
}

class ChatPage extends StatefulWidget {
  final String socketUrl;
  final String apiUrl;
  const ChatPage({required this.socketUrl, required this.apiUrl, Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late WebSocketChannel channel;
  final TextEditingController _controller = TextEditingController();
  final List<String> messages = [];

  @override
  void initState() {
    super.initState();
    channel = WebSocketChannel.connect(Uri.parse(widget.socketUrl));
    channel.stream.listen((event) {
      try {
        var jsonData = jsonDecode(event);
        if (jsonData['event'] == 'message.sent') {
          var msg = jsonData['data']['message']['content'];
          setState(() {
            messages.add(msg);
          });
        }
      } catch (e) {
        print('Error parsing event: $e');
      }
    }, onError: (error) {
      print('WebSocket error: $error');
    }, onDone: () {
      print('WebSocket closed');
    });
  }

  Future<void> sendMessage() async {
    if (_controller.text.isEmpty) return;

    final response = await http.post(
      Uri.parse(widget.apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'sender': 'FlutterUser',
        'content': _controller.text,
      }),
    );

    if (response.statusCode == 200) {
      _controller.clear();
    } else {
      print('Failed to send message: ${response.body}');
    }
  }

  @override
  void dispose() {
    channel.sink.close();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('دردشة Flutter - Laravel')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) => ListTile(title: Text(messages[index])),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(border: OutlineInputBorder(), hintText: 'اكتب رسالة'),
                ),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: sendMessage,
                child: Text('إرسال'),
              )
            ]),
          )
        ],
      ),
    );
  }
}