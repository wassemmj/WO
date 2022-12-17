import 'dart:convert';

import 'package:cons_app/Models/log_in_model.dart';
import 'package:cons_app/Screen/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../Provider/api_provider.dart';
import 'singup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  bool obscure = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [Colors.purple, Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.center,
            )),
            padding: const EdgeInsets.all(25),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 100),
                    child: Text(
                      'Log In',
                      style: GoogleFonts.bebasNeue(
                          fontSize: 52, color: Colors.white),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter Email',
                      hintStyle: const TextStyle(
                        color: Colors.black54,
                      ),
                      labelText: 'Email',
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
                    controller: emailController,
                    validator: (val) {
                      final bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(val!);
                      if (val.isEmpty) {
                        return 'Email is Required';
                      } else if (!emailValid) {
                        return 'Not a Valid Email';
                      }
                    },
                    style: const TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter Password',
                      hintStyle: const TextStyle(
                        color: Colors.black54,
                      ),
                      labelText: 'Password',
                      labelStyle: const TextStyle(
                        color: Colors.purple,
                        fontSize: 20,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscure ? Icons.visibility : Icons.visibility_off,
                          color: Colors.purple,
                        ),
                        onPressed: () {
                          setState(() {
                            obscure = !obscure;
                          });
                        },
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
                    obscureText: obscure,
                    controller: passwordController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Password is Required';
                      } else if (val.length < 8) {
                        return 'Short Password';
                      }
                    },
                    style: const TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: _login,
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
                          'Log In',
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Not a member?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                      InkWell(
                        child: const Text(
                          'Register Now',
                          style: TextStyle(
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (_) => const SignUp()));
                        },
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

  Future<void> _login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    LogInModel logInModel = LogInModel(email: email, password: password);
    var provider = Provider.of<ApiProvider>(context, listen: false);
    var r = await provider.login(logInModel);
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        if(provider.isBack) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              "Log in Successfully",
              style: TextStyle(fontSize: 15),
            ),
            duration: Duration(seconds: 1),
          ));
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const TabsScreen()));
        }else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              "wrong account!",
              style: TextStyle(fontSize: 15),
            ),
            duration: Duration(seconds: 1),
          ));
        }
      }
    }
  }
}
