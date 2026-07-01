
import 'package:flutter/material.dart';

void main() {
  runApp(const FASTPOS());
}

class FASTPOS extends StatelessWidget {
  const FASTPOS({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('FAST POS')),
        body: const Center(child: Text('FAST POS Running')),
      ),
    );
  }
}
