import 'dart:convert';
import 'dart:io';

import 'package:cons_app/Models/expert_models.dart';
import 'package:cons_app/Screen/tabs_screen.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../Provider/api_provider.dart';
import '../Provider/language_provider.dart';

class ExpertProfileScreen extends StatefulWidget {
  const ExpertProfileScreen({Key? key, required this.name}) : super(key: key);

  final String name;

  @override
  State<ExpertProfileScreen> createState() => _ExpertProfileScreenState();
}

class _ExpertProfileScreenState extends State<ExpertProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker picker = ImagePicker();
  File? pickedImage;

  var addressController = TextEditingController();
  var phoneController = TextEditingController();
  var skillController = TextEditingController();
  var moneyController = TextEditingController();
  Duration? duration;

  bool _isC1 = false;
  bool _isC2 = false;
  bool _isC3 = false;
  bool _isC4 = false;
  bool _isC5 = false;

  List li = [];

  List conId = [];

  List<Map<String, String>> time = [
    {"day": "saturday", "start": "from", "end": "to"},
    {"day": "sunday", "start": "from", "end": "to"},
    {"day": "monday", "start": "from", "end": "to"},
    {"day": "tuesday", "start": "from", "end": "to"},
    {"day": "wednesday", "start": "from", "end": "to"},
    {"day": "thursday", "start": "from", "end": "to"},
    {"day": "friday", "start": "from", "end": "to"},
  ];

  @override
  void initState() {
    getCat(true);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
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
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${widget.name},${lan.getText('ex_item1')}',
                      style: GoogleFonts.bebasNeue(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                                color: Colors.white70, shape: BoxShape.circle),
                            child: ClipOval(
                              child: SizedBox.fromSize(
                                size: const Size.fromRadius(50),
                                child: pickedImage == null
                                    ? Image.asset('images/i.png',
                                        fit: BoxFit.cover)
                                    : Image.file(
                                        pickedImage!,
                                        fit: BoxFit.scaleDown,
                                      ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton.icon(
                            onPressed: () async {
                              final XFile? image = await picker.pickImage(
                                  source: ImageSource.gallery);
                              if (image == null) {
                                return;
                              }
                              setState(() {
                                pickedImage = File(image.path);
                              });
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.purple)),
                            icon: const Icon(Icons.image),
                            label: Text(lan.isEn ? 'Image' : 'صورة'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: lan.getText('ex_item2_h').toString(),
                        hintStyle: const TextStyle(
                          color: Colors.black54,
                        ),
                        labelText: lan.getText('ex_item2_l').toString(),
                        labelStyle: const TextStyle(
                          color: Colors.purple,
                          fontSize: 20,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.purple),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        focusColor: Colors.purple,
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple),
                        ),
                      ),
                      cursorColor: Colors.purple,
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      validator: (val) {
                        final bool phoneValid =
                            RegExp(r"^[0-9.]").hasMatch(val!);
                        if (val.isEmpty) {
                          return lan.isEn
                              ? 'phone Number is Required'
                              : 'الهاتف مطلوب';
                        } else if (!phoneValid || val.length < 10) {
                          return lan.isEn
                              ? 'Not a Valid Phone Number'
                              : 'الهاتف غير صحيح';
                        }
                      },
                      style: const TextStyle(color: Colors.black54),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: lan.getText('ex_item3_h').toString(),
                        hintStyle: const TextStyle(
                          color: Colors.black54,
                        ),
                        labelText: lan.getText('ex_item3_l').toString(),
                        labelStyle: const TextStyle(
                          color: Colors.purple,
                          fontSize: 20,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.purple),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        focusColor: Colors.purple,
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple),
                        ),
                      ),
                      cursorColor: Colors.purple,
                      controller: addressController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return lan.isEn
                              ? 'Address is Required'
                              : 'العنوان مطلوب';
                        }
                      },
                      style: const TextStyle(color: Colors.black54),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: lan.isEn ? 'Enter Skills' : 'ادخل مهاراتك',
                        hintStyle: const TextStyle(
                          color: Colors.black54,
                        ),
                        labelText: lan.isEn ? 'Skills' : 'المهارات',
                        labelStyle: const TextStyle(
                          color: Colors.purple,
                          fontSize: 20,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.purple),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        focusColor: Colors.purple,
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple),
                        ),
                      ),
                      cursorColor: Colors.purple,
                      controller: skillController,
                      maxLines: 4,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return lan.isEn
                              ? 'Skill is Required'
                              : 'المهارات مطلوبة';
                        }
                      },
                      style: const TextStyle(color: Colors.black54),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: lan.isEn ? 'Enter session price' : 'ادخل سعر الجلسة',
                        hintStyle: const TextStyle(
                          color: Colors.black54,
                        ),
                        labelText: lan.isEn ? 'session price' : 'سعر الجلسة',
                        labelStyle: const TextStyle(
                          color: Colors.purple,
                          fontSize: 20,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.purple),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        focusColor: Colors.purple,
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple),
                        ),
                      ),
                      cursorColor: Colors.purple,
                      controller: moneyController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return lan.isEn
                              ? 'session price required'
                              : 'سعر الجلسة مطلوب';
                        }
                      },
                      style: const TextStyle(color: Colors.black54),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          lan.isEn ? 'availability :' : 'متواجد : ',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            Duration? d = await showDurationPicker(
                              context: context,
                              initialTime: const Duration(minutes: 0),
                            );
                            setState(() {
                              duration = d;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("duration $d")));
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.purple),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                          ),
                          child:
                              Text(lan.isEn ? 'session duration' : 'مدة جلستك'),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        duration != null
                            ? Text(
                                "${duration?.inMinutes.toString()} Min",
                                style: const TextStyle(fontSize: 15),
                              )
                            : Container(),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.purple,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Column(
                        children: [
                          buildTime(0),
                          buildTime(1),
                          buildTime(2),
                          buildTime(3),
                          buildTime(4),
                          buildTime(5),
                          buildTime(6),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          lan.isEn ? 'consulting :' : ' مستشار ب :',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    FutureBuilder(
                        future: getCat(lan.isEn),
                        builder: (context, snapshot) {
                          return snapshot.connectionState ==
                                  ConnectionState.waiting
                              ? const Center(child: CircularProgressIndicator())
                              : Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.purple,
                                    ),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Column(
                                    children: [
                                      CheckboxListTile(
                                          title: Text(
                                            lan.isEn
                                                ? li[0]['titleE']
                                                : li[0]['titleA'],
                                            style: const TextStyle(
                                                color: Colors.purple,
                                                fontSize: 20),
                                          ),
                                          value: _isC1,
                                          activeColor: Colors.purple,
                                          checkColor: Colors.white,
                                          onChanged: (val) {
                                            setState(() {
                                              _isC1 = val!;
                                            });
                                            if (val!) {
                                              conId.add(li[0]['id']);
                                            } else {
                                              if (conId.contains(li[0]['id'])) {
                                                conId.remove(li[0]['id']);
                                              }
                                            }
                                          }),
                                      CheckboxListTile(
                                          title: Text(
                                            lan.isEn
                                                ? li[1]['titleE']
                                                : li[1]['titleA'],
                                            style: const TextStyle(
                                                color: Colors.purple,
                                                fontSize: 20),
                                          ),
                                          value: _isC2,
                                          activeColor: Colors.purple,
                                          checkColor: Colors.white,
                                          onChanged: (val) {
                                            setState(() {
                                              _isC2 = val!;
                                            });
                                            if (val!) {
                                              conId.add(li[1]['id']);
                                            } else {
                                              if (conId.contains(li[1]['id'])) {
                                                conId.remove(li[1]['id']);
                                              }
                                            }
                                          }),
                                      CheckboxListTile(
                                          title: Text(
                                            lan.isEn
                                                ? li[2]['titleE']
                                                : li[2]['titleA'],
                                            style: const TextStyle(
                                                color: Colors.purple,
                                                fontSize: 20),
                                          ),
                                          value: _isC3,
                                          activeColor: Colors.purple,
                                          checkColor: Colors.white,
                                          onChanged: (val) {
                                            setState(() {
                                              _isC3 = val!;
                                            });
                                            if (val!) {
                                              conId.add(li[2]['id']);
                                            } else {
                                              if (conId.contains(li[2]['id'])) {
                                                conId.remove(li[2]['id']);
                                              }
                                            }
                                          }),
                                      CheckboxListTile(
                                          title: Text(
                                            lan.isEn
                                                ? li[3]['titleE']
                                                : li[3]['titleA'],
                                            style: const TextStyle(
                                                color: Colors.purple,
                                                fontSize: 20),
                                          ),
                                          value: _isC4,
                                          activeColor: Colors.purple,
                                          checkColor: Colors.white,
                                          onChanged: (val) {
                                            setState(() {
                                              _isC4 = val!;
                                            });
                                            if (val!) {
                                              conId.add(li[3]['id']);
                                            } else {
                                              if (conId.contains(li[3]['id'])) {
                                                conId.remove(li[3]['id']);
                                              }
                                            }
                                          }),
                                      CheckboxListTile(
                                          title: Text(
                                            lan.isEn
                                                ? li[4]['titleE']
                                                : li[4]['titleA'],
                                            style: const TextStyle(
                                                color: Colors.purple,
                                                fontSize: 20),
                                          ),
                                          value: _isC5,
                                          activeColor: Colors.purple,
                                          checkColor: Colors.white,
                                          onChanged: (val) {
                                            setState(() {
                                              _isC5 = val!;
                                            });
                                            if (val!) {
                                              conId.add(li[4]['id']);
                                            } else {
                                              if (conId.contains(li[4]['id'])) {
                                                conId.remove(li[4]['id']);
                                              }
                                            }
                                          }),
                                    ],
                                  ),
                                );
                        }),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: addExpert,
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
        ),
      ),
    );
  }

  Future<void> addExpert() async {
    String mobile = phoneController.text;
    String address = addressController.text;
    String brief = skillController.text;
    String money = moneyController.text;
    var provider = Provider.of<ApiProvider>(context, listen: false);
    var lan = Provider.of<LanguageProvider>(context, listen: false);
    var dd = _duration(duration!);
    ExpertModels expertModels = ExpertModels(
      mobile: mobile,
      address: address,
      brief: brief,
      sessionPeriod: dd,
      time: time,
      consId: conId,
      money: money,
      pickedImage: pickedImage!,
    );
    print(dd);
    var r = await provider.registerExpert(expertModels);
    print(li);
    print(conId);
    print(jsonEncode(time));
    if(duration==null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          lan.isEn ? "choose duration" : 'اختر مدة للجلسة ',
          style: const TextStyle(fontSize: 15),
        ),
        duration: const Duration(seconds: 1),
      ));
      return;
    }
    if (time.every(
        (element) => element['start'] == 'from' || element['end'] == 'to')) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          lan.isEn ? "You Should fill all item" : 'يجب ملئ كل القيم',
          style: const TextStyle(fontSize: 15),
        ),
        duration: const Duration(seconds: 1),
      ));
      return;
    }
    if (conId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          lan.isEn
              ? "You Should choose one or more consultation"
              : 'ينصح باختيار واحدة على الاقل',
          style: const TextStyle(fontSize: 15),
        ),
        duration: const Duration(seconds: 1),
      ));
      return;
    }
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (provider.isBack) {
        //var map = jsonDecode(r.body);
        //print(map);
        print(r);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'register successfully',
            textDirection: TextDirection.ltr,
            style: const TextStyle(fontSize: 15),
          ),
          duration: const Duration(seconds: 1),
        ));
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const TabsScreen()));
      } else {
        print(r);
      }
      print(dd);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "Try Again!",
          textDirection: TextDirection.ltr,
          style: TextStyle(fontSize: 15),
        ),
        duration: Duration(seconds: 1),
      ));
    }
  }

  Widget buildTime(int i) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            time[i]['day']!,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: TextButton.icon(
            onPressed: () async {
              TimeOfDay? pickedTime = await showTimePicker(
                initialEntryMode: TimePickerEntryMode.input,
                context: context,
                initialTime: TimeOfDay.fromDateTime(DateTime.now()),
              );
              if (pickedTime == null) return;
              setState(() {
                time[i]['start'] = pickedTime.to24hours();
              });
            },
            icon: const Icon(
              Icons.access_time_rounded,
              color: Colors.purple,
            ),
            label: Text(
              time[i]['start']!,
              style: const TextStyle(color: Colors.purple),
            ),
          ),
        ),
        Expanded(
          child: TextButton.icon(
            onPressed: () async {
              TimeOfDay? pickedTime = await showTimePicker(
                initialEntryMode: TimePickerEntryMode.input,
                context: context,
                initialTime: TimeOfDay.fromDateTime(DateTime.now()),
              );
              if (pickedTime == null) return;
              setState(() {
                time[i]['end'] = pickedTime.to24hours();
              });
            },
            icon: const Icon(
              Icons.access_time_rounded,
              color: Colors.purple,
            ),
            label: Text(
              time[i]['end']!,
              style: const TextStyle(color: Colors.purple),
            ),
          ),
        ),
      ],
    );
  }

  Future getCat(bool isEn) async {
    var pr = Provider.of<ApiProvider>(context, listen: false);
    var response = await pr.category(isEn);
    if (pr.isBack) {
      var cat = jsonDecode(response.body);
      li = cat[0];
      //return response;
    } else {
      throw Exception('can not load data');
    }
  }

  String _duration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes";
  }
}

extension TimeOfDayConverter on TimeOfDay {
  String to24hours() {
    final hour = this.hour.toString().padLeft(2, "0");
    final min = this.minute.toString().padLeft(2, "0");
    return "$hour:$min";
  }
}
