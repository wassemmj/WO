import 'package:cons_app/Screen/login_screen.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key, required this.name, required this.imgPath})
      : super(key: key);
  final String name;
  final String imgPath;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
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
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 25,
                ),
                InkWell(
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
                  onTap: () => Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => const LoginScreen())),
                ),
              ],
            ),
            Container(
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
}
