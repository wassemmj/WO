import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/api_provider.dart';
import '../Provider/language_provider.dart';
import '../Widget/construction.dart';

class ConstructionsScreen extends StatefulWidget {
  const ConstructionsScreen({Key? key}) : super(key: key);

  @override
  State<ConstructionsScreen> createState() => _ConstructionsScreenState();
}

class _ConstructionsScreenState extends State<ConstructionsScreen> {
  List li = [];

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    var isEn = lan.isEn;
    return FutureBuilder(
      future: getCat(isEn),
      builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? (const Center(
                  child: CircularProgressIndicator(color: Colors.purple,),
                ))
              : snapshot.hasData
                  ? ListView.builder(
                      itemCount: li.length,
                      itemBuilder: (ctx, index) {
                        return Column(
                          children: [
                            Construction(
                              constructionName: lan.isEn?li[index]['titleE']:li[index]['titleA'],
                              id: li[index]['id'],
                            ),
                            index + 1 == li.length
                                ? const SizedBox(
                                    height: 170,
                                  )
                                : Container(),
                          ],
                        );
                      },
                    )
                  : const Center(
                      child: Text('error'),
                    );
        }
    );
  }

  Future getCat(bool isEn) async {
    var pr = Provider.of<ApiProvider>(context, listen: true);
    var response = await pr.category(isEn);
    if(pr.isBack){
      var cat = jsonDecode(response.body);
      li = cat[0];
      return response.body;
    } else {
      throw Exception('can not load data');
    }
  }
}
