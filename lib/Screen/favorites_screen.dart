import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key, required this.favoriteList}) : super(key: key);

  final List favoriteList;

  @override
  Widget build(BuildContext context) {
    if (favoriteList.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(bottom: 200),
        child: Center(
          child: Text('You have no favorites yet!',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400,),),
        ),
      );
    }
    else {
      return Container();
    }
  }
}
