import 'package:cons_app/Screen/expert_profile_screen.dart';
import 'package:cons_app/Screen/login_screen.dart';
import 'package:cons_app/Screen/singup_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.purpleAccent,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.purple),
        scaffoldBackgroundColor: Colors.grey.shade100,
        primarySwatch: Colors.grey,
      ),
      home: const ExpertProfileScreen(),
    );
  }
}
