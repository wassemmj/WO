import 'package:cons_app/Widget/expert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/language_provider.dart';

class ExpertsScreen extends StatelessWidget {
  const ExpertsScreen({Key? key, required this.expert, required this.consName}) : super(key: key);

  final String consName;
  final List<Map<String,Object>> expert;

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(consName),
          backgroundColor: Colors.purple.withOpacity(0.8),
          elevation: 0,
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.white, Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ListView.builder(
            itemCount: expert.length,
            itemBuilder: (ctx,index) {
              return Expert(name: expert[index]['name'] as String,imgPath: expert[index]['imgPath'].toString(),);
            },
          ),
        ),
      ),
    );
  }
}
