import 'package:cons_app/Models/sing_up_model.dart';
import 'package:cons_app/Provider/api_provider.dart';
import 'package:cons_app/Screen/expert_profile_screen.dart';
import 'package:cons_app/Screen/login_screen.dart';
import 'package:cons_app/Screen/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../Provider/language_provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  bool obscure = true;
  bool coObscure = true;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final userNameController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isExpert = false;

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
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
                    Container(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: Text(
                        lan.getText('sing_up_title').toString(),
                        style: GoogleFonts.bebasNeue(fontSize: 52, color: Colors.white),
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: lan.getText('sing_up_tf_h1').toString(),
                        hintStyle: const TextStyle(
                          color: Colors.black54,
                        ),
                        labelText: lan.getText('sing_up_tf_t1').toString(),
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
                      controller: userNameController,
                      validator: (val) {
                        if(val!.isEmpty) {
                          return lan.getText('sing_up_tf_v1').toString();
                        }
                      },
                      style: const TextStyle(color: Colors.black54),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: lan.getText('sing_up_tf_h2').toString(),
                        hintStyle: const TextStyle(
                          color: Colors.black54,
                        ),
                        labelText: lan.getText('sing_up_tf_t2').toString(),
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
                        final bool emailValid =
                        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(val!);
                        if(val.isEmpty) {
                          return lan.getText('login_tf_v11').toString();
                        } else if(!emailValid) {
                          return lan.getText('login_tf_v12').toString();
                        }
                      },
                      style: const TextStyle(color: Colors.black54),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: lan.getText('sing_up_tf_h3').toString(),
                        hintStyle: const TextStyle(
                          color: Colors.black54,
                        ),
                        labelText: lan.getText('sing_up_tf_t3' ).toString(),
                        labelStyle: const TextStyle(
                          color: Colors.purple,
                          fontSize: 20,
                        ), suffixIcon: IconButton(
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
                        if(val!.isEmpty) {
                          return lan.getText('login_tf_v21').toString();
                        } else if(val.length<8) {
                          return lan.getText('login_tf_v22').toString();
                        }
                      },
                      style: const TextStyle(color: Colors.black54),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: lan.getText('sing_up_tf_h4').toString(),
                        hintStyle: const TextStyle(
                          color: Colors.black54,
                        ),
                        labelText: lan.getText('sing_up_tf_t4').toString(),
                        labelStyle: const TextStyle(
                          color: Colors.purple,
                          fontSize: 20,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            coObscure ? Icons.visibility : Icons.visibility_off,
                            color: Colors.purple,
                          ),
                          onPressed: () {
                            setState(() {
                              coObscure = !coObscure;
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
                      obscureText: coObscure,
                      controller: confirmPasswordController,
                      validator: (val) {
                        if(val!.isEmpty) {
                          return lan.getText('login_tf_v21').toString();
                        } else if(passwordController.value!=confirmPasswordController.value) {
                          return  lan.getText('sing_up_tf_v41').toString();
                        }
                      },
                      style: const TextStyle(color: Colors.black54),
                    ),
                    const SizedBox(height: 20),
                    InkWell (
                      onTap: _registration,
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
                            isExpert? lan.getText('sing_up_next').toString():lan.getText('sing_up_title').toString(),
                            style: const TextStyle(
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
                      children:  [
                        Text(
                          lan.getText('sing_up_item1').toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                        InkWell(
                          child: Text(
                            lan.getText('login_title').toString(),
                            style: const TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: (){Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>const LoginScreen()));},

                          // onTap: () {
                          //   Navigator.of(context).pushReplacement(MaterialPageRoute(
                          //       builder: (_) => widget.user? const SingUpScreen():const SingUpExpert()));
                          // },
                        ),
                      ],
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            lan.isEn?'User':'مستخدم',
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 15,
                            ),
                          ),
                          Switch(
                            value: isExpert,
                            activeColor: Colors.purple,
                            inactiveThumbColor: Colors.black45,
                            inactiveTrackColor: Colors.black45,
                            onChanged: (val) {
                              setState(() {
                                isExpert = val;
                              });
                            },
                          ),
                          Text(
                            lan.isEn?'Expert':'خبير',
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 15,
                            ),
                          ),
                        ],
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

  Future<void> _registration() async {
    String name = userNameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmedPassword = confirmPasswordController.text.trim();
    SingUpModel singUpModel = SingUpModel(name: name, email: email, password: password, confirmedPassword: confirmedPassword);
    var provider = Provider.of<ApiProvider>(context,listen: false);
    var r = await provider.register(singUpModel);
    if(_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if(provider.isBack) {
        if(r.body[4]=="s"){
          if(isExpert) {
            var name = userNameController.value.text.split(' ');
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>ExpertProfileScreen(name: name[0],)));
          } else {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>const TabsScreen()));
          }
        }
        else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('the email has been taken',textDirection: TextDirection.ltr,style: TextStyle(fontSize: 15),),
                duration: Duration(seconds: 1),
              )
          );
        }
      }
    }
  }
}
