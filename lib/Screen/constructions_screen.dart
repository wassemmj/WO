import 'package:flutter/material.dart';

import '../Widget/construction.dart';

class ConstructionsScreen extends StatelessWidget {
  const ConstructionsScreen({Key? key, required this.li}) : super(key: key);

  final List<String> li;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: li.length,
      itemBuilder: (ctx,index) {
        return Column(
          children: [
            Construction(constructionName: li[index],),
          ],
        );
      },
    );
  }
}
