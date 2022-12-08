import 'package:cons_app/Screen/expert_profile_screen.dart';
import 'package:cons_app/Screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
                  Container(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: Text(
                      'Sign Up',
                      style: GoogleFonts.bebasNeue(fontSize: 52, color: Colors.white),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter Your Name',
                      hintStyle: const TextStyle(
                        color: Colors.black54,
                      ),
                      labelText: 'UserName',
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
                        return 'Name is Required';
                      }
                    },
                    style: const TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 20),
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
                      final bool emailValid =
                      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(val!);
                      if(val.isEmpty) {
                        return 'Email is Required';
                      } else if(!emailValid) {
                        return 'Not a Valid Email';
                      }
                    },
                    style: const TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter Your Password',
                      hintStyle: const TextStyle(
                        color: Colors.black54,
                      ),
                      labelText: 'Password',
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
                        return 'Password is Required';
                      } else if(val.length<8) {
                        return 'Short Password';
                      }
                    },
                    style: const TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Confirm Your Password',
                      hintStyle: const TextStyle(
                        color: Colors.black54,
                      ),
                      labelText: 'Confirm Password',
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
                        return 'Password is Required';
                      } else if(passwordController.value!=confirmPasswordController.value) {
                        return ' Passwords don\'t match';
                      }
                    },
                    style: const TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 20),
                  InkWell (
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
                          isExpert? 'Continue':'Sign Up',
                          style: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      if(_formKey.currentState!.validate()) {
                        if(!isExpert) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Register Successfully",style: TextStyle(fontSize: 15),),
                                duration: Duration(seconds: 1),
                              )
                          );
                        }
                        _formKey.currentState!.save();
                        emailController.clear();
                        passwordController.clear();
                        if(isExpert) {
                          var name = userNameController.value.text.split(' ');
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>ExpertProfileScreen(name: name[0],)));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Try Again!",style: TextStyle(fontSize: 15),),
                              duration: Duration(seconds: 1),
                            )
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      const Text(
                        'already have an account?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                      InkWell(
                        child: const Text(
                          'Log In',
                          style: TextStyle(
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
                        const Text(
                          'User',
                          style: TextStyle(
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
                        const Text(
                          'Expert',
                          style: TextStyle(
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
    );
  }
}
