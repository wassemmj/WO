import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/language_provider.dart';

class ReservationItem extends StatelessWidget {
  const ReservationItem({Key? key}) : super(key: key);

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
            lan.isEn?'User-Name : ':'حساب المستخدم :  ',
            textDirection: lan.isEn? TextDirection.ltr:TextDirection.rtl,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600
            ),
          ),
          Text(
            '14/5/2022 3:35AM',
            textDirection: lan.isEn? TextDirection.ltr:TextDirection.rtl,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
