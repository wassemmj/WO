import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/language_provider.dart';

class ReservationItem extends StatelessWidget {
  const ReservationItem({Key? key, required this.name, required this.t, required this.d}) : super(key: key);

  final String name;
  final String t;
  final String d;

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: const Color.fromARGB(100, 0, 0, 65),
          borderRadius: BorderRadius.circular(25)
      ),
      child: Row(
        children:[
          Text(
            '$name   :',
            textDirection: lan.isEn? TextDirection.ltr:TextDirection.rtl,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600
            ),
          ),
          Text(
            '    $d  $t',
            textDirection: lan.isEn? TextDirection.ltr:TextDirection.rtl,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
