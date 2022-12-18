import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/language_provider.dart';
import '../Widget/reservation_item.dart';

class ReservationsScreen extends StatelessWidget {
  const ReservationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple.withOpacity(0.8),
          title: Text(lan.getText('reservation').toString()),
          elevation: 0,
        ),
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple, Colors.white, Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: const [
                ReservationItem(),
                ReservationItem(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
