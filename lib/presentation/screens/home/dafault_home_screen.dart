import 'package:flutter/material.dart';

class DefaultScreen extends StatelessWidget {
  const DefaultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Default Home',
        ),
      ),
      body: const Center(
        child: Text(
          'Welcome to Default Home',
        ),
      ),
    );
  }
}
