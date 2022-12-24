import 'dart:convert';

import 'package:cons_app/Screen/chat_screen.dart';
import 'package:cons_app/Screen/rr_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/api_provider.dart';
import '../Provider/language_provider.dart';

class ExpertDetails extends StatefulWidget {
  const ExpertDetails({Key? key, required this.expertName, required this.id}) : super(key: key);

  final String expertName;
  final int id;

  @override
  State<ExpertDetails> createState() => _ExpertDetailsState();
}

class _ExpertDetailsState extends State<ExpertDetails> {
  bool fav = false;

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.expertName),
          backgroundColor: Colors.purple.withOpacity(0.8),
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                addFav();
                if(Provider.of<ApiProvider>(context,listen: false).favList.every((element) => element['id']==1)){
                  setState(() {
                    fav = true;
                  });
                } else {
                  setState(() {
                    fav = false;
                  });
                }
              },
              icon: Icon(fav
                  ? Icons.star
                  : Icons.star_border),
            ),
            IconButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => const ReservationScreen()),),
              tooltip: lan.isEn? "make reservation":'احجز الان',
              icon: const Icon(
                Icons.access_time_rounded,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () =>Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const ChatScreen())),
              tooltip: lan.isEn? "chat with expert":'دردشة',
              icon: const Icon(Icons.message_outlined),
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(25),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple, Colors.white, Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.white70, shape: BoxShape.circle),
                    child: ClipOval(
                      child: SizedBox.fromSize(
                        size: const Size.fromRadius(50),
                        child: Image.asset(
                          'images/i.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: lan.getText('ex_item3_l').toString(),
                        labelStyle: const TextStyle(
                          color: Colors.purple,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        prefixIcon: const Icon(
                          Icons.location_on_outlined,
                          color: Colors.purple,
                        )),
                    enabled: false,
                    controller:
                        TextEditingController(text: 'afif,damascus,syria'),
                    style: const TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: lan.getText('ex_item2_l').toString(),
                        labelStyle: const TextStyle(
                          color: Colors.purple,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        prefixIcon: const Icon(
                          Icons.phone,
                          color: Colors.purple,
                        )),
                    enabled: false,
                    controller: TextEditingController(text: '+963987416589'),
                    style: const TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: lan.isEn?'Skills':'المهارات',
                      labelStyle: const TextStyle(
                        color: Colors.purple,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.purple),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    maxLines: 4,
                    enabled: false,
                    controller: TextEditingController(text: "can play football"),
                    style: const TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        lan.isEn?'availability :':'متواجد : ',
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.purple,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  buildShowTime(lan.isEn?'Sunday':'الاحد',lan.isEn),
                  buildShowTime(lan.isEn?'Monday':'الاثنين',lan.isEn),
                  buildShowTime(lan.isEn?'Tuesday':'الثلاثاء',lan.isEn),
                  buildShowTime(lan.isEn?'Wednesday':'الاربعاء',lan.isEn),
                  buildShowTime(lan.isEn?'Thursday':'الخميس',lan.isEn),
                  buildShowTime(lan.isEn?'Friday':'الجمعة',lan.isEn),
                  buildShowTime(lan.isEn?'Saturday':'السبت',lan.isEn),
                  const Divider(
                    color: Colors.black12,
                    height: 5,
                    thickness: 2,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        lan.isEn?'Rating :':'التقييمات',
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.purple,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      const Text(
                        '4.5 / 5',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        lan.isEn?'consulting :':' مستشار ب :',
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.purple,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        children: const [
                          Text(
                            'Medical Construction',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Financial Construction',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Medical Construction',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future addFav() async {
    var provider = Provider.of<ApiProvider>(context,listen: false);
    var r = await provider.addFav(1);
    print(r.body);
    if(provider.isBack) {
      var map = jsonDecode(r.body);
      print(map);
    }
  }

  Widget buildShowTime(String day,bool g) {
    return Row(
      children: [
        Expanded(
          child: Text(
            '$day :',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: TextButton.icon(
            onPressed: null,
            icon: const Icon(
              Icons.access_time_rounded,
              color: Colors.purple,
            ),
            label: Text(
              g ? '9:35 am':'9:35 ص',
              style: const TextStyle(color: Colors.black54),
            ),
          ),
        ),
        Text(
          g ? 'to':'الى',
          style: const TextStyle(
            color: Colors.black54,
          ),
        ),
        Expanded(
          child: TextButton.icon(
            onPressed: null,
            icon: const Icon(
              Icons.access_time_rounded,
              color: Colors.purple,
            ),
            label: Text(
              g? '1:35 pm':'1:35 م',
              style: const TextStyle(color: Colors.black54),
            ),
          ),
        ),
      ],
    );
  }
}
