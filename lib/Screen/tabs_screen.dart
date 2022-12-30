import 'dart:convert';

import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:cons_app/Screen/constructions_screen.dart';
import 'package:cons_app/Screen/favorites_screen.dart';
import 'package:cons_app/Widget/MyDrawer.dart';
import 'package:cons_app/Widget/expert.dart';
import 'package:flutter/material.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:provider/provider.dart';

import '../Provider/api_provider.dart';
import '../Provider/language_provider.dart';
import '../Widget/construction.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedIndex = 0;
  late List<Map<String, Object>> _tabs;
  CircularBottomNavigationController? _navigationController;

  List<String> constList = [
    'Medical Constructions',
    'Financial Constructions',
    'Medical Constructions',
    'Financial Constructions',
    'Medical Constructions',
    'Medical Constructions',
    'Financial Constructions',
    'Medical Constructions',
    'Financial Constructions',
    'Medical Constructions',
  ];

  @override
  void initState() {
    _navigationController = CircularBottomNavigationController(_selectedIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    _tabs = [
      {
        'title': lan.getText('constructions').toString(),
        'body': const ConstructionsScreen(),
      },
      {
        'title': lan.getText('favorites').toString(),
        'body': const FavoritesScreen(),
      },
    ];
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: MySearchDelegate());
                },
                icon: const Icon(Icons.search))
          ],
          title: Text(_tabs[_selectedIndex]['title'] as String),
          centerTitle: true,
          backgroundColor: Colors.purple.withOpacity(0.8),
          elevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              //color: Colors.white,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple, Colors.white, Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: _tabs[_selectedIndex]['body'] as Widget,
            ),
          ),
        ),
        bottomNavigationBar: CircularBottomNavigation(
          barHeight: 60,
          [
            TabItem(
              Icons.category,
              lan.getText("constructions").toString(),
              Colors.purple,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.normal,
              ),
            ),
            TabItem(
              Icons.favorite,
              lan.getText("favorites").toString(),
              Colors.purple,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
          controller: _navigationController,
          selectedPos: _selectedIndex,
          barBackgroundColor: Colors.white,
          animationDuration: const Duration(milliseconds: 300),
          selectedCallback: (selected) {
            setState(() {
              _selectedIndex = selected!;
            });
          },
        ),
        drawer: const MyDrawer(
          name: 'obada',
          imgPath:
              'images/welcome-hand-drawn-lettering-against-watercolor-background-eps-vector-52782797.jpg',
        ),
      ),
    );
  }
}

class MySearchDelegate extends SearchDelegate {
  List<String> searchResult = [
    'Sport Consulting',
    'Legal Consulting',
    'mmm',
    'استشارة طبية',
    'سامر',
  ];

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              if (query.isEmpty) {
                close(context, null);
              } else {
                query = '';
              }
            })
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, null),
      );

  @override
  Widget buildResults(BuildContext context) {
    return Result(
      query: query,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = searchResult.where((searchResult) {
      final result = searchResult.toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();
    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          return ListTile(
            title: Text(suggestion),
            onTap: () {
              query = suggestion;
              showResults(context);
            },
          );
        });
  }
}

class Result extends StatefulWidget {
  const Result({Key? key, required this.query}) : super(key: key);

  final String query;

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  List li = [];
  List li2 = [];

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return FutureBuilder(
      future: search(lan.isEn),
      builder: (context, snapshot) {
        List l = li.where((element) {
          List ll = element['name'].toString().split('');
          // print(ll);
          List lll = widget.query.split('');
          // print(lll);
          for (int i = 0; i < lll.length; i++) {
            if (lll[i] != ll[i] || lll.length > ll.length) {
              return false;
            }
          }
          return true;
        }).toList();
        List l2 = li2.where((element) {
          List ll = lan.isEn
              ? element['titleE'].toString().toLowerCase().split('')
              : element['titleA'].toString().split('');
          // print(ll);
          List lll = widget.query.toLowerCase().split('');
          // print(lll);
          for (int i = 0; i < lll.length; i++) {
            if (lll[i] != ll[i] || lll.length > ll.length) {
              return false;
            }
          }
          return true;
        }).toList();
        print('${l.length} \\\\\\\\\ ${l2.length}');
        return snapshot.connectionState == ConnectionState.waiting
            ? (const Center(
                child: CircularProgressIndicator(
                  color: Colors.purple,
                ),
              ))
            : l.isNotEmpty
                ? ListView.builder(
                    itemCount: l.length,
                    itemBuilder: (context, index) {
                      return Expert(
                          name: l[index]['name'],
                          imgPath:
                              '${Provider.of<ApiProvider>(context, listen: true).url}/storage/${l[index]['image']}',
                          id: l[index]['id']);
                    },
                  )
                : l2.isNotEmpty
                    ? ListView.builder(
                        itemCount: l2.length,
                        itemBuilder: (context, index) {
                          return Construction(
                            constructionName: lan.isEn
                                ? l2[index]['titleE']
                                : l2[index]['titleA'],
                            id: l2[index]['id'],
                          );
                        },
                      )
                    : const Center(
                        child: Text(
                          "Not found",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      );
      },
    );
  }

  Future search(bool isEn) async {
    var provider = Provider.of<ApiProvider>(context, listen: false);
    var r = await provider.search();
    var response = await provider.category(isEn);
    var map = jsonDecode(r.body);
    if (provider.isBack) {
      li = map['experts'];
      var cat = jsonDecode(response.body);
      li2 = cat[0];
      print(li);
    }
  }
}
