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
  List l = [];

  @override
  void initState() {
    super.initState();
    getAllApp();
  }

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
                                itemCount: Provider.of<ApiProvider>(context,
                                    listen: false)
                                    .isExpert
                                    ? l.length:li.length,
                                itemBuilder: (context, index) {
                                  // var t = li[0]['from'];
                                  // var d = li[0]['session_date'];
                                  // List l = list[0][li[0]['day']];
                                  // var lg = l[0]['user'];
                                  return Provider.of<ApiProvider>(context,
                                              listen: false)
                                          .isExpert
                                      ? ReservationItem(
                                          name: '',
                                          t: l[index]['from'],
                                          d: l[index]['session_date'],
                                          f: () => delApp(l[index]['id']),
                                        )
                                      : ReservationItem(
                                          name: '',
                                          t: li[index]['from'],
                                          d: li[index]['session_date'],
                                          f: () => delApp(li[index]['id']),
                                        );
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
      if (provider.isExpert) {
        li = map['sessions_to_give'];
        if ((li[0]["saturday"] as List).isNotEmpty) {
          l.addAll(li[0]["saturday"]);
        }
        if ((li[1]["sunday"] as List).isNotEmpty) {
          l.addAll(li[1]["sunday"]);
        }
        if ((li[2]["monday"] as List).isNotEmpty) {
          l.addAll(li[2]["monday"]);
        }
        if ((li[3]["tuesday"] as List).isNotEmpty) {
          l.addAll(li[3]["tuesday"]);
        }
        if ((li[4]["wednesday"] as List).isNotEmpty) {
          l.addAll(li[4]["wednesday"]);
        }
        if ((li[5]["thursday"] as List).isNotEmpty) {
          l.addAll(li[5]["thursday"]);
        }
        if ((li[6]["friday"] as List).isNotEmpty) {
          l.addAll(li[6]["friday"]);
        }
        print(l);
      } else {
        li = map["sessions_to_take"];
        print(li);
      }
      print(r.body);
      return r;
    } else {
      print(r.body);
    }
  }

  Future delApp(int id) async {
    var provider = Provider.of<ApiProvider>(context, listen: false);
    var r = await provider.delApp(id);
    var map = jsonDecode(r.body);
    if (provider.isBack) {
      print(map);
    } else {
      print(r.body);
    }
  }
}
