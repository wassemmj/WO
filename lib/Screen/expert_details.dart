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
  String address = '';
  String phoneNum = '';
  String skills = '';
  String rate = '';
  late int id;
  List con = [];

  var sun;
  var mon;
  var tus;
  var wed;
  var thr;
  var fri;
  var stu;



  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await showDetails();
    if(Provider.of<ApiProvider>(context,listen: true).isMealFavorites(id)){
      setState(() {
        fav = true;
      });
    } else {
      setState(() {
        fav = false;
      });
    }
    super.initState();
  }

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
                if(!fav) {
                  addFav();
                  setState(() {
                    fav = true;
                  });
                }
                else if(fav) {
                  Provider.of<ApiProvider>(context,listen: false).delFav(id);
                  setState(() {
                    fav=!fav;
                  });
                }
              },
              icon: Icon(fav
                  ? Icons.star
                  : Icons.star_border),
            ),
            IconButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => ReservationScreen(id: id,)),),
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
          child: FutureBuilder(
            future: showDetails(),
            builder:(context,snapshot) {
              return snapshot.connectionState == ConnectionState.waiting
                  ? (const Center(
                child: CircularProgressIndicator(color: Colors.purple,),
              ))
                  : snapshot.hasData
                  ? SingleChildScrollView(
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
                          TextEditingController(text: address),
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
                      controller: TextEditingController(text: phoneNum),
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
                      controller: TextEditingController(text: skills),
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
                    buildShowTime(lan.isEn?'Saturday':'السبت',stu['start'],stu['end'],lan.isEn),
                    buildShowTime(lan.isEn?'Sunday':'الاحد',sun['start'],sun['end'],lan.isEn),
                   buildShowTime(lan.isEn?'Monday':'الاثنين',mon['start'],mon['end'],lan.isEn),
                    buildShowTime(lan.isEn?'Tuesday':'الثلاثاء',tus['start'],tus['end'],lan.isEn),
                    buildShowTime(lan.isEn?'Wednesday':'الاربعاء',wed['start'],wed['end'],lan.isEn),
                   buildShowTime(lan.isEn?'Thursday':'الخميس',thr['start'],thr['end'],lan.isEn),
                   buildShowTime(lan.isEn?'Friday':'الجمعة',fri['start'],fri['end'],lan.isEn),
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
                        Text(
                          '${rate} / 5',
                          style: const TextStyle(fontWeight: FontWeight.w700),
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
                          children: [
                            con.length>0 ?Text(
                              lan.isEn? con[0]['titleE']:con[0]['titleA'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                              ),
                            ):Container(),
                            con.length>1 ?Text(
                              lan.isEn? con[1]['titleE']:con[1]['titleA'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                              ),
                            ):Container(),
                            con.length>2 ?Text(
                              lan.isEn? con[2]['titleE']:con[2]['titleA'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                              ),
                            ):Container(),
                            con.length>3 ?Text(
                              lan.isEn? con[3]['titleE']:con[3]['titleA'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                              ),
                            ):Container(),
                            con.length>4 ?Text(
                              lan.isEn? con[4]['titleE']:con[4]['titleA'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                              ),
                            ):Container(),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ): const Center(
                child: Text('error'),
              );
            },
          ),
        ),
      ),
    );
  }

  Future addFav() async {
    var provider = Provider.of<ApiProvider>(context,listen: false);
    var r = await provider.addFav(widget.id);
    print(r.body);
    if(provider.isBack) {
      var map = jsonDecode(r.body);
      print(map);
    }
  }
  
  Future showDetails() async {
    var provider = Provider.of<ApiProvider>(context,listen: false);
    var r = await provider.showExpertDetails(widget.id);
    //print(r.body);
    if(provider.isBack) {
      var map = jsonDecode(r.body);
      address = map['expert']['address'];
      phoneNum = map['expert']['mobile'];
      skills=map['expert']['brief'];
      rate =map['expert']['rate'].toString();
      id = map['expert']['id'];
      con = map['expert']['categories'];
      print(con);
      var l = [];
      for(int i = 0;i<7;i++) {
        l.add(map['available'][i]);
      }
      stu = l[0]['available_at'];
      sun = l[1]['available_at'];
      mon = l[2]['available_at'];
      tus = l[3]['available_at'];
      wed = l[4]['available_at'];
      thr = l[5]['available_at'];
      fri = l[6]['available_at'];
      print(stu);
      print(sun);
      print(mon);
      print(tus);
      print(wed);
      print(thr);
      print(fri);
      //print(stu['day']);
      print(map);
      return r.body;
    }
  }

  Widget buildShowTime(String day,String st,String end,bool g) {
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
              st,
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
              end,
              style: const TextStyle(color: Colors.black54),
            ),
          ),
        ),
      ],
    );
  }
}
