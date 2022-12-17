import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Messaging"),
        backgroundColor: Colors.purple.withOpacity(0.8),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            tooltip: "voice call",
            icon: const Icon(Icons.phone),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.white, Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          height: MediaQuery.of(context).size.height,
        ),
      ),
    );
  }
}
