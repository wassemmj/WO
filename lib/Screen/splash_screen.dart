

import 'package:cons_app/Screen/singup_screen.dart';
import 'package:flutter/material.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';

class OpenScreen extends StatelessWidget {
  const OpenScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      home: Scaffold(
        body: EasySplashScreen(
          logo: Image.asset('images/welcome-hand-drawn-lettering-against-watercolor-background-eps-vector-52782797.jpg'),
          logoWidth: 150,
          showLoader: true,
          loaderColor: Colors.black,
          loadingText:  const Text('Loading...', style: TextStyle(color: Colors.black, fontSize: 25),),
          durationInSeconds: 3,
          navigator: const SignUp(),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
