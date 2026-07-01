
import 'package:flutter/material.dart';

void main() {
  runApp(const AdminPanel());
}

class AdminPanel extends StatelessWidget {
  const AdminPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('FAST POS Admin')),
        body: const Center(child: Text('Dashboard')),
      ),
    );
  }
}
