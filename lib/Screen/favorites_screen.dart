import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/language_provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key, required this.favoriteList}) : super(key: key);

  final List favoriteList;

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    if (favoriteList.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 200),
        child: Center(
          child: Text(lan.getText('favorites_item1') as String,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w400,),),
        ),
      );
    }
    else {
      return Container();
    }
  }
}
