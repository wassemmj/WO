import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/api_provider.dart';
import '../Provider/language_provider.dart';
import '../Widget/reservation_item.dart';

class ReservationsScreen extends StatefulWidget {
  const ReservationsScreen({Key? key}) : super(key: key);

  @override
  State<ReservationsScreen> createState() => _ReservationsScreenState();
}

class _ReservationsScreenState extends State<ReservationsScreen> {
  List li = [];
  List list = [];

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
        body: FutureBuilder(
            future: getAllApp(),
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.waiting
                  ? (const Center(
                      child: CircularProgressIndicator(
                        color: Colors.purple,
                      ),
                    ))
                  : SafeArea(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.purple, Colors.white, Colors.white],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: li.isEmpty
                            ? Center(
                                child: Text(
                                  lan.isEn
                                      ? 'there is no appointment'
                                      : 'لا يوجد مواعيد',
                                  style: const TextStyle(
                                      color: Colors.black54, fontSize: 18),
                                ),
                              )
                            : ListView.builder(
                          itemCount: li.length,
                          itemBuilder: (context,index) {
                            var t = li[0]['from'];
                            var d = li[0]['session_date'];
                            List l = list[0][li[0]['day']];
                            var lg = l[0]['user'];
                            var name = lg['name'];
                            return ReservationItem(name: name, t: t, d: d);
                          },
                        ),
                      ),
                    );
            }),
      ),
    );
  }

  Future getAllApp() async {
    var provider = Provider.of<ApiProvider>(context, listen: false);
    var r = await provider.showApp();
    var map = jsonDecode(r.body);
    if (provider.isBack) {
      list = map['sessions_to_give'];
      li = map["sessions_to_take"];
      print(li);
      print(list);
      return r;
    } else {
      print(r.body);
    }
  }
}
