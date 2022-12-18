import 'package:cons_app/Screen/login_screen.dart';
import 'package:cons_app/Screen/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Provider/language_provider.dart';

class OpenScreen extends StatefulWidget {
  const OpenScreen({Key? key}) : super(key: key);

  @override
  State<OpenScreen> createState() => _OpenScreenState();
}

class _OpenScreenState extends State<OpenScreen> {
  bool t = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Directionality(
          textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
          child: EasySplashScreen(
            logo: Image.asset(
                'images/welcome-hand-drawn-lettering-against-watercolor-background-eps-vector-52782797.jpg'),
            logoWidth: 150,
            showLoader: true,
            loaderColor: Colors.black,
            loadingText: Text(
              lan.getText('splash_screen_item1') as String,
              style: const TextStyle(color: Colors.black, fontSize: 25),
            ),
            durationInSeconds: 3,
            navigator: (!t) ? const LoginScreen() : const TabsScreen(),
            backgroundColor: Colors.white,
          ),
        ),
      ),
    );
  }

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      t = prefs.getBool('login')!;
    });
  }
}
