import 'dart:convert';
import 'ChatScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:graduation/constant.dart';

class UserListScreen extends StatefulWidget {
  final int myUserId; // المستخدم الحالي

  UserListScreen({required this.myUserId});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  List<dynamic> users = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    final url = Uri.parse('http://$ip:8000/api/users');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          users = jsonDecode(response.body);
        });
      } else {
        print("❌ فشل في جلب المستخدمين");
      }
    } catch (e) {
      print("❌ خطأ: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('اختر مستخدمًا')),
      body: users.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  title: Text(user['name'] ?? 'User ${user['id']}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChatScreen(
                          myUserId: widget.myUserId,
                          receiverId: user['id'],
                          receiverName: user['name'],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
