import 'dart:convert';

import 'package:cons_app/Widget/expert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/api_provider.dart';
import '../Provider/language_provider.dart';

class ExpertsScreen extends StatefulWidget {
  const ExpertsScreen({Key? key, required this.consName, required this.id})
      : super(key: key);

  final String consName;
  final int id;

  @override
  State<ExpertsScreen> createState() => _ExpertsScreenState();
}

class _ExpertsScreenState extends State<ExpertsScreen> {
  List li = [];

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.consName),
          backgroundColor: Colors.purple.withOpacity(0.8),
          elevation: 0,
        ),
        body: FutureBuilder(
            future: getExpert(),
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.waiting
                  ? (const Center(
                      child: CircularProgressIndicator(
                        color: Colors.purple,
                      ),
                    ))
                  : snapshot.hasData
                      ? li.isEmpty
                          ? Center(
                              child: Text(
                                lan.isEn
                                    ? 'there is no expert'
                                    : 'لا يوجد خبراء هنا',
                                style: const TextStyle(
                                    color: Colors.black54, fontSize: 18),
                              ),
                            )
                          : Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.purple,
                                    Colors.white,
                                    Colors.white
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: ListView.builder(
                                itemCount: li.length,
                                itemBuilder: (ctx, index) {
                                  return Expert(
                                    name: li[index]['name'],
                                    imgPath: '',
                                    id: li[index]['id'],
                                  );
                                },
                              ),
                            )
                      : const Center(
                          child: Text('error'),
                        );
            }),
      ),
    );
  }

  Future getExpert() async {
    var pr = Provider.of<ApiProvider>(context, listen: true);
    var response = await pr.showExpert(widget.id);
    if (pr.isBack) {
      //print(jsonDecode(response.body)['experts']);
      //ex.forEach((k, v) => list.add(v['name']));
      //ex.forEach((k, v) => listId.add(v['id']));
      li = jsonDecode(response.body)['experts'];
      //print(list);
      //print(this.listId);
      return response.body;
    } else {
      throw Exception('can not load data');
    }
  }
}
