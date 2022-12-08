import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ExpertProfileScreen extends StatefulWidget {
  const ExpertProfileScreen({Key? key}) : super(key: key);

  @override
  State<ExpertProfileScreen> createState() => _ExpertProfileScreenState();
}

class _ExpertProfileScreenState extends State<ExpertProfileScreen> {
  final ImagePicker picker = ImagePicker();
  File? pickedImage;



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.white,],
            begin: Alignment.topLeft,
            end: Alignment.center,
          )),

      padding: const EdgeInsets.all(25),
      child: Column(
        children: [

        ],
      ),
    );
  }
}
