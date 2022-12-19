import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../Models/date_operartions.dart';
import '../Provider/language_provider.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({Key? key}) : super(key: key);

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  List<int> _getList() {
    List<int> datesList = <int>[];
    int currentDate = DateOperartions().getCurrentDate();
    int totalDays = DateOperartions().getMonthdays();
    for (int j = currentDate; j <= totalDays; j++) {
      datesList.add(j);
    }
    return datesList;
  }

  int _getRemaningDays() {
    int currentDate = DateOperartions().getCurrentDate();
    int totalDays = DateOperartions().getMonthdays();
    int counter = 0;
    for (int j = currentDate; j <= totalDays; j++) {
      counter++;
    }
    return counter;
  }

  int _tabCheck = 0;
  int _tabCheck1 = 0;
  int _isPress = 0;
  double rate = 0;

  List<String> li = ['9:35 am ','4:50 pm','5:00 pm'];
  @override
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
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.purple,
                    Colors.white,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.center,
                ),
              ),
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _getRemaningDays(),
                        itemBuilder: (context, int index) {
                          int _currentDate = DateOperartions().getCurrentDate();
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _tabCheck = index;
                              });
                            },
                            child: displayCard(
                                color: _tabCheck == index
                                    ? Colors.white
                                    : Colors.transparent,
                                date: _getList()[index]),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    flex: 7,
                    child: GridView.builder(
                      itemCount: li.length,
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        childAspectRatio: 4/2
                      ),
                      itemBuilder: (_,i)=>InkWell(
                          child: timeBox(time: li[i],color: _tabCheck1==i ? Colors.white : Colors.white38),
                        onTap: () {
                          setState(() {
                            _tabCheck1 = i;
                          });
                        },
                      )),
                    ),
                  ]),
              ),
            ),
          ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple,
          onPressed: () {
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
          child: const Icon(Icons.done),
        ),
        ),
    );
  }

/*Widget build(BuildContext context) {
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
  }*/

  Widget myCard({Color color = Colors.white, int date = 1}) {
    String dayName = DateOperartions().getDateNAme(index: date);
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              DateOperartions().getMonthdaysDaysName(),
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
            Text(
              date.toString(),
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
            Text(
              dayName.substring(0, 3),
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget timeBox({required String time,required Color color}) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: color,
          border: Border.all(
              color: Colors.purple,
              width: 2
          ),
          borderRadius: BorderRadius.circular(25)
      ),
      child: Text(time,textAlign: TextAlign.center,),
    );
  }

  Widget displayCard({Color color = Colors.purple, int date = 0}) {
    return SizedBox(
        width: 100,
        child: myCard(
          color: color,
          date: date,
        ));
  }
}
