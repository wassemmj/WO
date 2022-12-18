import 'package:cons_app/Screen/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../Provider/language_provider.dart';

class ExpertDetails extends StatefulWidget {
  const ExpertDetails({Key? key, required this.expertName}) : super(key: key);

  final String expertName;

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
              onPressed: ()=>setState(()=>fav = !fav),
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
            label: const Text(
              '9:35 am',
              style: TextStyle(color: Colors.black54),
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
            label: const Text(
              '1:35 pm',
              style: TextStyle(color: Colors.black54),
            ),
          ),
        ),
      ],
    );
  }
}

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({Key? key}) : super(key: key);

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  String time = intl.DateFormat('hh:mm a').format(DateTime.now()).toString();
  DateTime _selectedDate = DateTime.now();

  double rate = 0;

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr:TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(lan.isEn?'Reservation':'للحجز'),
          backgroundColor: Colors.purple.withOpacity(0.8),
          elevation: 0,
        ),
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Colors.purple,
                Colors.white,
              ],
              begin: Alignment.topLeft,
              end: Alignment.center,
            )),
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      lan.isEn ? "Date :": 'تاريخ : ',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      intl.DateFormat.yMd().format(_selectedDate),
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                        onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            builder: (ctx, w) {
                              return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: const ColorScheme.light(
                                      primary: Colors.purple,
                                    ),
                                    textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                        primary: Colors.purple, // button text color
                                      ),
                                    ),
                                  ),
                                  child: w!);
                            },
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2025),
                          );
                          if (pickedDate != null) {
                            setState(() => _selectedDate = pickedDate);
                          }
                        },
                        icon: const Icon(
                          Icons.date_range_rounded,
                          color: Colors.white,
                          size: 20,
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      lan.isEn ? "Time :": 'الوقت',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      time,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      onPressed: _getTimeFromUser,
                      icon: const Icon(
                        Icons.access_time_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                InkWell(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Colors.purple,
                          Colors.white70,
                          Colors.purple,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: Text(
                        lan.isEn?'Done':'تم',
                        style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (ctx) {
                        return AlertDialog(
                          title: Text(lan.isEn?'Rate This Expert':'هل تريد تقييم هذا الخبير',style: const TextStyle(color: Colors.purple),),
                          content: RatingBar(
                            minRating: 0,
                            maxRating: 5,
                            initialRating: 0,
                            allowHalfRating: true,
                            ratingWidget: RatingWidget(
                              full: const Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              half: const Icon(Icons.star_half,color: Colors.yellow,),
                              empty: const Icon(
                                Icons.star_border,
                              ),
                            ),
                            onRatingUpdate: (double value) => rate = value,
                            itemCount: 5,
                            itemSize: 40,
                            itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                            glow: false,
                            updateOnDrag: true,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                    lan.isEn?"Thanks for rating":'شكرا لتقييمك',
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                  duration:const Duration(seconds: 1),
                                ));
                                Navigator.of(ctx).pop();
                              },
                              child:  Text(
                                lan.isEn?'Done':"تم",
                                style: const TextStyle(color: Colors.purple, fontSize: 20),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                              child: Text(
                                lan.isEn?'Cancel':'الغاء',
                                style: const TextStyle(color: Colors.purple, fontSize: 20),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getTimeFromUser() async {
    TimeOfDay? pickedTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      builder: (ctx, child) {
        return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: Colors.purple,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: Colors.purple, // button text color
                ),
              ),
            ),
            child: child!);
      },
      initialTime: TimeOfDay.fromDateTime(DateTime(2022)),
    );
    String formattedTime = pickedTime!.format(context);
    setState(() {
      time = formattedTime;
    });
  }
}
