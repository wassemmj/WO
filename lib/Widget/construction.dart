import 'package:cons_app/Screen/experts_screen.dart';
import 'package:flutter/material.dart';

class Construction extends StatelessWidget {
  const Construction({Key? key, required this.constructionName, required this.id})
      : super(key: key);

  final String constructionName;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListTile(
        title: Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
              color: const Color.fromARGB(100, 0, 0, 65),
              borderRadius: BorderRadius.circular(25)),
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
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => ExpertsScreen(id: id,consName: constructionName))),
      ),
    );
  }
}
