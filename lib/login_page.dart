import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:talkr_demo/fire_auth.dart';
import 'package:talkr_demo/validator.dart';
import 'package:talkr_demo/register_page.dart';
import 'package:talkr_demo/profile_page.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ProfilePage(
            user: user,
          ),
        ),
      );
    }

    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(children: <Widget>[
              Container(
                height: 400,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/background.png'),
                        fit: BoxFit.fill)),
                child: Stack(children: <Widget>[
                  Positioned(
                    left: 30,
                    width: 80,
                    height: 200,
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/light-1.png'))),
                    ),
                  ),
                  Positioned(
                    left: 140,
                    width: 80,
                    height: 150,
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/light-2.png'))),
                    ),
                  ),
                  Positioned(
                    right: 40,
                    top: 40,
                    width: 80,
                    height: 150,
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/clock.jpeg'))),
                    ),
                  ),
                ]),
              ),
              FutureBuilder(
                future: _initializeFirebase(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom:
                                    90.0), //do not change anything in this line
                            child: Center(
                              child: Text(
                                "Talkr",
                                style: GoogleFonts.montserrat(
                                    color: Colors.deepPurpleAccent,
                                    fontWeight: FontWeight.w200,
                                    fontSize: 80,
                                    fontStyle: FontStyle.normal),
                              ),
                            ),
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  controller: _emailTextController,
                                  focusNode: _focusEmail,
                                  textAlign: TextAlign.center,
                                  validator: (value) => Validator.validateEmail(
                                    email: value,
                                  ),
                                  decoration: InputDecoration(
                                    icon: new Icon(
                                      Icons.email,
                                      color: Colors.deepPurple,
                                    ),
                                    hintText: "Email",
                                    fillColor: Colors.black12,
                                    filled: true,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        10.0, 5.0, 10.0, 5.0),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 1.5)),
                                    errorBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(60),
                                      borderSide: BorderSide(
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                TextFormField(
                                  controller: _passwordTextController,
                                  focusNode: _focusPassword,
                                  textAlign: TextAlign.center,
                                  obscureText: true,
                                  validator: (value) =>
                                      Validator.validatePassword(
                                    password: value,
                                  ),
                                  decoration: InputDecoration(
                                    icon: new Icon(
                                      Icons.lock,
                                      color: Colors.deepPurple,
                                    ),
                                    hintText: "Password",
                                    fillColor: Colors.black12,
                                    filled: true,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        10.0, 5.0, 10.0, 5.0),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 1.5)),
                                    errorBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(60),
                                      borderSide: BorderSide(
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 24.0),
                                _isProcessing
                                    ? CircularProgressIndicator(
                                        backgroundColor: Colors.transparent,
                                        color: Colors.black,
                                        strokeWidth: 2,
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                _focusEmail.unfocus();
                                                _focusPassword.unfocus();

                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  setState(() {
                                                    _isProcessing = true;
                                                  });

                                                  User? user = await FireAuth
                                                      .signInUsingEmailPassword(
                                                    email: _emailTextController
                                                        .text,
                                                    password:
                                                        _passwordTextController
                                                            .text,
                                                  );

                                                  setState(() {
                                                    _isProcessing = false;
                                                  });

                                                  if (user != null) {
                                                    Navigator.of(context)
                                                        .pushReplacement(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ProfilePage(
                                                                user: user),
                                                      ),
                                                    );
                                                  }
                                                }
                                              },
                                              child: Text(
                                                'Login',
                                                style: TextStyle(
                                                    fontSize: 20.0,
                                                  color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 10.0),
                                          Expanded(
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        RegisterPage(),
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                'Register',
                                                style: TextStyle(
                                                    fontSize: 20.0,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
