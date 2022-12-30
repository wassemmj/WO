import 'dart:convert';

import 'package:cons_app/Widget/expert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/api_provider.dart';
import '../Provider/language_provider.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List fav = [];

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);

    return FutureBuilder(
      future: showFav(),
      builder: (context, snapshot) {
        return snapshot.connectionState == ConnectionState.waiting
            ? (const Center(
                child: CircularProgressIndicator(
                  color: Colors.purple,
                ),
              ))
            : fav.isNotEmpty? Padding(
                    padding: const EdgeInsets.all(15),
                    child: ListView.builder(
                      itemCount: fav.length,
                      itemBuilder: (context, index) {
                        return Expert(
                            name: fav[index]['name'],
                            imgPath: '${Provider.of<ApiProvider>(context, listen: true).url}/storage/${fav[index]['image']}',
                            id: fav[index]['id']);
                      },
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(bottom: 200),
                    child: Center(
                      child: Text(
                        lan.getText('favorites_item1') as String,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  );
      },
    );
  }

  Future showFav() async {
    var provider = Provider.of<ApiProvider>(context, listen: false);
    var r = await provider.showFav();
    print(r.body);
    if (provider.isBack) {
      fav = jsonDecode(r.body)["favorite"];
      print(fav);
    }
  }
}
