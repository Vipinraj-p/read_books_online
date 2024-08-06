import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:read_books_online/presentation/home_screen.dart';
import 'package:read_books_online/presentation/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        height: size.height,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            child: Padding(
              padding: EdgeInsets.only(
                  top: size.height * 0.2,
                  left: size.width * 0.05,
                  right: size.width * 0.05),
              child: Column(
                children: [
                  TextFormField(
                    style: GoogleFonts.ubuntuCondensed(
                        color: Colors.white, fontSize: 14),
                    enabled: true,
                    controller: emailController,
                    decoration: InputDecoration(
                        enabled: true,
                        labelText: 'Email Address',
                        floatingLabelStyle: GoogleFonts.ubuntu(
                          color: const Color.fromARGB(255, 226, 228, 230),
                        ),
                        labelStyle: GoogleFonts.ubuntu(
                          color: const Color.fromARGB(255, 226, 228, 230),
                        ),
                        prefixIcon: const Icon(
                          Icons.person_outline_rounded,
                          color: Color.fromARGB(255, 226, 228, 230),
                          size: 25,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5))),
                  ),
                  SizedBox(height: size.height * 0.05),
                  TextFormField(
                    style: GoogleFonts.ubuntuCondensed(
                        color: Colors.white, fontSize: 14),
                    enabled: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                        enabled: false,
                        labelText: 'Password',
                        floatingLabelStyle: GoogleFonts.ubuntu(
                          color: const Color.fromARGB(255, 226, 228, 230),
                        ),
                        labelStyle: GoogleFonts.ubuntu(
                          color: const Color.fromARGB(255, 226, 228, 230),
                        ),
                        prefixIcon: const Icon(
                          Icons.lock_outline_rounded,
                          color: Color.fromARGB(255, 226, 228, 230),
                          size: 25,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5))),
                  ),
                  SizedBox(height: size.height * 0.05),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text)
                              .then(
                            (value) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HomeScreen(),
                                  ));
                            },
                          ).onError(
                            (error, stackTrace) {
                              log('Error : ${error.toString()}');
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Text(
                                        'Wrong input\nError:${error.toString()}'),
                                  );
                                },
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 75, 77, 105),
                            shape: ContinuousRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            fixedSize: const Size(double.infinity, 50)),
                        child: Text(
                          'Sign In ',
                          style: GoogleFonts.ubuntu(
                              color: Colors.white, fontSize: 18),
                        )),
                  ),
                  SizedBox(height: size.height * 0.1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: size.width * 0.25,
                        child: const Divider(
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Or Continue with',
                        style: GoogleFonts.ubuntu(
                          color: const Color.fromARGB(255, 185, 187, 189),
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                          width: size.width * 0.25,
                          child: const Divider(
                            color: Colors.black,
                          )),
                    ],
                  ),
                  SizedBox(height: size.height * 0.025),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          log('Sign in with Google');
                        },
                        child: SizedBox(
                            height: size.height * 0.04,
                            width: size.height * 0.04,
                            child: Image.asset(
                                'assets/authentication_logo/GoogleLogo.png')),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.03),
                  RichText(
                      text: TextSpan(
                          style: GoogleFonts.ubuntu(
                              color: const Color.fromARGB(255, 185, 187, 189),
                              fontSize: 14),
                          children: [
                        const TextSpan(text: 'Don\'t have an account ?'),
                        TextSpan(
                            text: ' Register Now ',
                            style: TextStyle(
                                color: Colors.blue[700], fontSize: 15),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignupScreen(),
                                    ));
                                log('Sign Up', name: 'SignUp');
                              }),
                      ]))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
