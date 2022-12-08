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
      .format(DateTime.now().add(const Duration(minutes: 15)))
      .toString();

  var addressController = TextEditingController();
  var phoneController = TextEditingController();
  var skillController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple, Colors.white,],
                  begin: Alignment.topLeft,
                  end: Alignment.center,
                )),
            padding: const EdgeInsets.all(25),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    //padding: const EdgeInsets.only(bottom: 100),
                    child: Text(
                      'Name,Complete Your Profile',
                      style: GoogleFonts.bebasNeue(fontSize: 35, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(color: Colors.white70, shape: BoxShape.circle),
                          child: ClipOval(
                            child: SizedBox.fromSize(
                              size: const Size.fromRadius(50),
                              child: pickedImage == null
                                  ? Image.asset('images/person.jpeg',fit: BoxFit.fitHeight)
                                  : Image.file(pickedImage!),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton.icon(
                          onPressed: () async {
                            final XFile? image =
                            await picker.pickImage(source: ImageSource.gallery);
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
                      final bool phoneValid =
                      RegExp(r"^[0-9.]")
                          .hasMatch(val!);
                      if(val.isEmpty) {
                        return 'phone Number is Required';
                      } else if(!phoneValid) {
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
                      if(val!.isEmpty) {
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
                    maxLines: 4,
                    validator: (val) {
                      if(val!.isEmpty) {
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
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Start Time',
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
                              suffixIcon: IconButton(
                                onPressed: () =>
                                    _getTimeFromUser(isStart: true),
                                icon: const Icon(
                                  Icons.access_time_rounded,
                                  color: Colors.grey,
                                ),
                              )
                          ),
                          cursorColor: Colors.purple,
                          style: const TextStyle(color: Colors.black54),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: _endTime,
                                  hintStyle: const TextStyle(color: Colors.black),
                                  suffixIcon: IconButton(
                                    onPressed: () =>
                                        _getTimeFromUser(isStart: false),
                                    icon: const Icon(
                                      Icons.access_time_rounded,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                cursorColor: Colors.purple,
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
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