import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:graduation/constant.dart';
import 'ChatScreen.dart';

class EmployeeListScreen extends StatefulWidget {
  final int myUserId;

  EmployeeListScreen({required this.myUserId});

  @override
  _EmployeeListScreenState createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  List<dynamic> employees = [];

  @override
  void initState() {
    super.initState();
    fetchUsersAndFilter();
  }

  Future<void> fetchUsersAndFilter() async {
    final url = Uri.parse('http://$ip:8000/api/users');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> users = jsonDecode(response.body);

        // فلترة المستخدمين حسب roleId != 2 وباستثناء نفسي
        final filtered = users.where((u) {
          return u['role_id'] != 2 && u['id'] != widget.myUserId;
        }).toList();

        setState(() {
          employees = filtered;
        });
      } else {
        print("❌ فشل في جلب المستخدمين: ${response.body}");
      }
    } catch (e) {
      print("❌ خطأ في الاتصال: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("اختر موظفًا")),
      body: employees.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: employees.length,
              itemBuilder: (context, index) {
                final emp = employees[index];
                return ListTile(
                  title: Text(emp['name']),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChatScreen(
                          myUserId: widget.myUserId,
                          receiverId: emp['id'],
                          receiverName: emp['name'],
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
