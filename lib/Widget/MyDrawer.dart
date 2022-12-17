import 'package:cons_app/Screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/api_provider.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key, required this.name, required this.imgPath})
      : super(key: key);

  final String name;
  final String imgPath;

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white70,
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: SizedBox.fromSize(
                            size: const Size.fromRadius(30),
                            child: Image.asset(
                              'images/i.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        widget.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: InkWell(
                    onTap: logout,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Log Out',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.logout,
                          size: 25,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
                padding: const EdgeInsets.all(25),
                width: double.infinity,
                color: Colors.purple,
                child: const Text(
                  'Money                15000',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }

  void logout() async {
    var provider = Provider.of<ApiProvider>(context, listen: false);
    var r = await provider.logOut();
    if (provider.isBack) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "Log out Successfully",
          style: TextStyle(fontSize: 15),
        ),
        duration: Duration(seconds: 1),
      ));
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "an error occurred",
          style: TextStyle(fontSize: 15),
        ),
        duration: Duration(seconds: 1),
      ));
    }
  }
}
