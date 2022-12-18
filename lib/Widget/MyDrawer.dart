import 'package:cons_app/Screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/api_provider.dart';
import '../Provider/language_provider.dart';
import '../Screen/reservation_screen.dart';

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
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn?TextDirection.ltr:TextDirection.rtl,
      child: SafeArea(
        child: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: const [Colors.purple, Colors.white, Colors.white],
                        begin: lan.isEn? Alignment.topLeft:Alignment.topRight,
                        end: lan.isEn? Alignment.bottomRight:Alignment.bottomLeft,
                      ),
                    ),
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
                        const SizedBox(width: 20),
                        Text(
                          widget.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 25,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const ReservationsScreen())),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            lan.getText('drawer_item1').toString(),
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Icon(
                            Icons.access_time_rounded,
                            size: 25,
                            color: Colors.black54,
                          )
                        ],
                      ),
                    ),
                  ),
                  const Divider(thickness: 1),
                  Container(
                    alignment: lan.isEn? Alignment.centerLeft:Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(lan.getText('drawer_switch_title')as String,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: (lan.isEn ? 0 : 20),
                      left: (lan.isEn ? 20 : 0),
                      bottom: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          lan.getText('drawer_switch_item2') as String,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Switch(
                          value:
                              Provider.of<LanguageProvider>(context, listen: true)
                                  .isEn,
                          onChanged: (newLan) {
                            Provider.of<LanguageProvider>(context, listen: false)
                                .changeLan(newLan);
                            Navigator.of(context).pop();
                          },
                          activeColor: Colors.purple.withOpacity(0.7),
                          inactiveTrackColor:
                              Provider.of<LanguageProvider>(context, listen: true)
                                      .isEn
                                  ? Colors.white
                                  : Colors.grey,
                        ),
                        Text(
                          lan.getText('drawer_switch_item1') as String,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(thickness: 1),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: InkWell(
                      onTap: logout,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            lan.getText('drawer_item2') as String,
                            style: const  TextStyle(
                              color: Colors.black54,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Icon(
                            Icons.logout,
                            size: 25,
                            color: Colors.black54,
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
                  color: Colors.purple.withOpacity(0.8),
                  child: Text(
                    '${lan.getText('drawer_item3')}  :             15000',
                    style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  )),
            ],
          ),
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
