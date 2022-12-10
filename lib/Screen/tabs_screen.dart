import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:cons_app/Screen/constructions_screen.dart';
import 'package:cons_app/Screen/favorites_screen.dart';
import 'package:flutter/material.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedIndex = 0;
  late List<Map<String,Object>> _tabs;
  CircularBottomNavigationController? _navigationController;

  List<String> constList = [
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
    _tabs = [
      {
        'title':'Constructions',
        'body': ConstructionsScreen(li: constList),
      },
      {
        'title':'Favorites',
        'body': const FavoritesScreen(favoriteList: [],),
      },
    ];
    return Scaffold(
      appBar: AppBar(
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
            "Constructions",
            Colors.purple,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.normal,
            ),
          ),
          TabItem(
            Icons.favorite,
            "Favorites",
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
      drawer: const Drawer(),
    );
  }
}
