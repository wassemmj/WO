import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscure = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [Colors.purple, Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.center,
        )),
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Text(
                'Log In',
                style: GoogleFonts.bebasNeue(fontSize: 52, color: Colors.white),
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter Email',
                hintStyle: TextStyle(
                  color: Colors.grey[300],
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
              style: const TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter Password',
                hintStyle: TextStyle(
                  color: Colors.grey[300],
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
              style: const TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 20),
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
                    'Log In',
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              // onTap: () {
              //   if(_formKey.currentState!.validate()) {
              //     ScaffoldMessenger.of(context).showSnackBar(
              //         const SnackBar(
              //           content: Text("Log in Successfully",style: TextStyle(fontSize: 15),),
              //           duration: Duration(seconds: 1),
              //         )
              //     );
              //     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> const CatScreen()));
              //     _formKey.currentState!.save();
              //     emailController.clear();
              //     passwordController.clear();
              //   } else {
              //     ScaffoldMessenger.of(context).showSnackBar(
              //         const SnackBar(
              //           content: Text("Try Again!",style: TextStyle(fontSize: 15),),
              //           duration: Duration(seconds: 1),
              //         )
              //     );
              //   }
              // },
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Not a member?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                InkWell(
                  child: Text(
                    'Register Now',
                    style: TextStyle(
                      color: Colors.purple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // onTap: () {
                  //   Navigator.of(context).pushReplacement(MaterialPageRoute(
                  //       builder: (_) => widget.user? const SingUpScreen():const SingUpExpert()));
                  // },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
