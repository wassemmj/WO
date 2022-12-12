import 'package:flutter/material.dart';

class Construction extends StatelessWidget {
  const Construction({Key? key, required this.constructionName}) : super(key: key);

  final String constructionName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListTile(
        title: Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: const Color.fromARGB(100, 0, 0, 65),
            borderRadius: BorderRadius.circular(25)
          ),
          child: Text(
            constructionName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
