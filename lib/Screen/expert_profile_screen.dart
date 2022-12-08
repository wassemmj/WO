import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ExpertProfileScreen extends StatefulWidget {
  const ExpertProfileScreen({Key? key}) : super(key: key);

  @override
  State<ExpertProfileScreen> createState() => _ExpertProfileScreenState();
}

class _ExpertProfileScreenState extends State<ExpertProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker picker = ImagePicker();
  File? pickedImage;

  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String _endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 120)))
      .toString();

  var addressController = TextEditingController();
  var phoneController = TextEditingController();
  var skillController = TextEditingController();

  bool _isC1 = false;
  bool _isC2 = false;
  bool _isC3 = false;
  bool _isC4 = false;
  bool _isC5 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    'Name,Complete Your Profile',
                    style: GoogleFonts.bebasNeue(
                        fontSize: 35, color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                              color: Colors.white70, shape: BoxShape.circle),
                          child: ClipOval(
                            child: SizedBox.fromSize(
                              size: const Size.fromRadius(50),
                              child: pickedImage == null
                                  ? Image.asset('images/person.jpeg',
                                      fit: BoxFit.fitHeight)
                                  : Image.file(pickedImage!),
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
                          label: const Text('Image'),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter Phone Number',
                      hintStyle: const TextStyle(
                        color: Colors.black54,
                      ),
                      labelText: 'Phone Number',
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
                      final bool phoneValid = RegExp(r"^[0-9.]").hasMatch(val!);
                      if (val.isEmpty) {
                        return 'phone Number is Required';
                      } else if (!phoneValid || val.length < 10) {
                        return 'Not a Valid Phone Number';
                      }
                    },
                    style: const TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter Address',
                      hintStyle: const TextStyle(
                        color: Colors.black54,
                      ),
                      labelText: 'Address',
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
                        return 'Address is Required';
                      }
                    },
                    style: const TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter Skills',
                      hintStyle: const TextStyle(
                        color: Colors.black54,
                      ),
                      labelText: 'Skills',
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
                    maxLines: 2,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Skill is Required';
                      }
                    },
                    style: const TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        'availability :',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton.icon(
                          onPressed: () => _getTimeFromUser(isStart: true),
                          icon: const Icon(
                            Icons.access_time_rounded,
                            color: Colors.purple,
                          ),
                          label: Text(
                            _startTime,
                            style: const TextStyle(color: Colors.purple),
                          ),
                        ),
                      ),
                      const Text(
                        'to',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                        ),
                      ),
                      Expanded(
                        child: TextButton.icon(
                          onPressed: () => _getTimeFromUser(isStart: false),
                          icon: const Icon(
                            Icons.access_time_rounded,
                            color: Colors.purple,
                          ),
                          label: Text(
                            _endTime,
                            style: const TextStyle(color: Colors.purple),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.purple,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      children: [
                        CheckboxListTile(
                          title: const Text('c1',style: TextStyle(color:Colors.purple,fontSize: 20),),
                          value: _isC1,
                          activeColor: Colors.purple,
                          checkColor: Colors.white,
                          onChanged: (val) => setState(() {
                            _isC1 = val!;
                          }),
                        ),
                        CheckboxListTile(
                          title: const Text('c2',style: TextStyle(color:Colors.purple,fontSize: 20),),
                          value: _isC2,
                          activeColor: Colors.purple,
                          checkColor: Colors.white,
                          onChanged: (val) => setState(() {
                            _isC2 = val!;
                          }),
                        ),
                        CheckboxListTile(
                          title: const Text('c3',style: TextStyle(color:Colors.purple,fontSize: 20),),
                          value: _isC3,
                          activeColor: Colors.purple,
                          checkColor: Colors.white,
                          onChanged: (val) => setState(() {
                            _isC3 = val!;
                          }),
                        ),
                        CheckboxListTile(
                          title: const Text('c4',style: TextStyle(color:Colors.purple,fontSize: 20),),
                          value: _isC4,
                          activeColor: Colors.purple,
                          checkColor: Colors.white,
                          onChanged: (val) => setState(() {
                            _isC4 = val!;
                          }),
                        ),
                        CheckboxListTile(
                          title: const Text('c5',style: TextStyle(color:Colors.purple,fontSize: 20),),
                          value: _isC5,
                          activeColor: Colors.purple,
                          checkColor: Colors.white,
                          onChanged: (val) => setState(() {
                            _isC5 = val!;
                          }),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
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
                      child: const Center(
                        child: Text(
                          'Done',
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            "Register Successfully",
                            style: TextStyle(fontSize: 15),
                          ),
                          duration: Duration(seconds: 1),
                        ));
                        //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> const CatScreen()));
                        _formKey.currentState!.save();
                        phoneController.clear();
                        addressController.clear();
                        skillController.clear();
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            "Try Again!",
                            style: TextStyle(fontSize: 15),
                          ),
                          duration: Duration(seconds: 1),
                        ));
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _getTimeFromUser({required bool isStart}) async {
    TimeOfDay? pickedTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: isStart
          ? TimeOfDay.fromDateTime(DateTime.now())
          : TimeOfDay.fromDateTime(
              DateTime.now().add(const Duration(minutes: 15))),
    );
    String formattedTime = pickedTime!.format(context);
    if (isStart) {
      setState(() => _startTime = formattedTime);
    } else if (!isStart) {
      setState(() => _endTime = formattedTime);
    } else
      print('');
  }
}
