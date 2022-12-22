import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../Provider/api_provider.dart';
import '../Provider/language_provider.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({Key? key}) : super(key: key);

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

extension TimeOfDayConverter on TimeOfDay {
  String to24hours() {
    final hour = this.hour.toString().padLeft(2, "0");
    final min = this.minute.toString().padLeft(2, "0");
    return "$hour:$min";
  }
}

class _ReservationScreenState extends State<ReservationScreen> {
  String? time ;
  DateTime? _selectedDate;
  double rate = 0;

  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(lan.isEn ? 'Reservation' : 'للحجز'),
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
                      lan.isEn ? "Date :" : 'تاريخ : ',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      _selectedDate==null?'':intl.DateFormat.yMd().format(_selectedDate!),
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
                                        primary:
                                            Colors.purple, // button text color
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
                      lan.isEn ? "Time :" : 'الوقت',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      time==null ? '':time!,
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
                  onTap: ()=>bookApp(lan.isEn),
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
                        lan.isEn ? 'Done' : 'تم',
                        style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
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
      initialEntryMode: TimePickerEntryMode.dial,
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
          child: child!,
        );
      },
      initialTime: TimeOfDay.fromDateTime(DateTime(2022)),
    );
    if(pickedTime==null) return;
    setState(() {
      time = pickedTime.to24hours();
    });
  }

  Future bookApp(bool isEn) async {
    var provider = Provider.of<ApiProvider>(context, listen: false);
    String date =  intl.DateFormat('yyyy-MM-dd').format(_selectedDate!);
    var r = await provider.bookingApp(12,date, time!);
    Map<String,dynamic> map = jsonDecode(r.body);
    print(map);
    print(map['message']);
    print(map['status']);
    if (provider.isBack) {
      if(map['status']==200) {
        showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text(
                isEn
                    ? 'Rate This Expert'
                    : 'هل تريد تقييم هذا الخبير',
                style: const TextStyle(color: Colors.purple),
              ),
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
                  half: const Icon(
                    Icons.star_half,
                    color: Colors.yellow,
                  ),
                  empty: const Icon(
                    Icons.star_border,
                  ),
                ),
                onRatingUpdate: (double value) => rate = value,
                itemCount: 5,
                itemSize: 40,
                itemPadding:
                const EdgeInsets.symmetric(horizontal: 4),
                glow: false,
                updateOnDrag: true,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(
                      content: Text(
                        isEn
                            ? "Thanks for rating"
                            : 'شكرا لتقييمك',
                        style: const TextStyle(fontSize: 15),
                      ),
                      duration: const Duration(seconds: 1),
                    ));
                    Navigator.of(ctx).pop();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    isEn ? 'Done' : "تم",
                    style: const TextStyle(
                        color: Colors.purple, fontSize: 20),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(
                      content: Text(
                        isEn
                            ? "reservation successfully"
                            : 'تم الحجز بنجاح',
                        style: const TextStyle(fontSize: 15),
                      ),
                      duration: const Duration(seconds: 1),
                    ));
                    Navigator.of(ctx).pop();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    isEn ? 'Cancel' : 'الغاء',
                    style: const TextStyle(
                        color: Colors.purple, fontSize: 20),
                  ),
                ),
              ],
            );
          },
        );
      } else if(map['status']==424) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(map['message']),duration: const Duration(seconds: 1),));
      }
    }
  }
}
