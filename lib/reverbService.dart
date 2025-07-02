import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

class ReverbService {
  late WebSocketChannel _channel;

  Stream get stream => _channel.stream;

  void connect(String url) {
    _channel = WebSocketChannel.connect(Uri.parse(url));
    print("✅ تم الاتصال بـ Reverb على: $url");
  }

  void sendMessage(Map<String, dynamic> message) {
    if (_channel.closeCode == null) {
      _channel.sink.add(jsonEncode(message));
    } else {
      print("❌ الاتصال مغلق، لا يمكن الإرسال.");
    }
  }

  void disconnect() {
    _channel.sink.close();
  }
}
