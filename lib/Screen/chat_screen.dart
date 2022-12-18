import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/language_provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(lan.isEn?'Chat':'دردشة'),
          backgroundColor: Colors.purple.withOpacity(0.8),
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {},
              tooltip: lan.isEn? "voice call":'مكالمة صوتية',
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
      ),
    );
  }
}
