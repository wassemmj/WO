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
  List listId = [];

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
                      ? Container(
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
                              return Expert(name: li[index],imgPath: '', id: listId[index],);
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
    var ex = jsonDecode(jsonEncode(jsonDecode(response.body)['experts']));
    var list = [];
    var listId = [];
    if (pr.isBack) {
      ex.forEach((k, v) => list.add(v['name']));
      ex.forEach((k, v) => listId.add(v['id']));
      li = list;
      this.listId = listId;
      print(li);
      print(this.listId);
      return response.body;
    } else {
      throw Exception('can not load data');
    }
  }
}
