import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:talkr_demo/profile_page.dart';
import 'package:talkr_demo/fire_auth.dart';
import 'package:talkr_demo/validator.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with TickerProviderStateMixin {
  final _registerFormKey = GlobalKey<FormState>();

  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _focusName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusName.unfocus();
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigoAccent,
          elevation: 10,
          title: Text(
            'Register',
            style: TextStyle(
              fontSize: 22,
              color: Colors.black54,
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.none,
            ),
          ),
          padding: EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: _registerFormKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _nameTextController,
                        focusNode: _focusName,
                        validator: (value) => Validator.validateName(
                          name: value,
                        ),
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                          hintText: "Name",
                          hintStyle:
                              TextStyle(fontSize: 17.0, color: Colors.white),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(60.0),
                              borderSide: BorderSide(color: Colors.red)),
                          errorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(600.0),
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: _emailTextController,
                        focusNode: _focusEmail,
                        validator: (value) => Validator.validateEmail(
                          email: value,
                        ),
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                          hintText: "Email",
                          hintStyle:
                              TextStyle(fontSize: 17.0, color: Colors.white),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(60.0),
                              borderSide: BorderSide(color: Colors.red)),
                          errorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(600.0),
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: _passwordTextController,
                        focusNode: _focusPassword,
                        obscureText: true,
                        validator: (value) => Validator.validatePassword(
                          password: value,
                        ),
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                          hintText: "Password",
                          hintStyle:
                              TextStyle(fontSize: 17.0, color: Colors.white),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(60.0),
                              borderSide: BorderSide(
                                color: Colors.red,
                              )),
                          errorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(600.0),
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 32.0),
                      _isProcessing
                          ? CircularProgressIndicator(
                              backgroundColor: Colors.transparent,
                              color: Colors.white,
                              strokeWidth: 2,
                            )
                          : Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      setState(() {
                                        _isProcessing = true;
                                      });

                                      if (_registerFormKey.currentState!
                                          .validate()) {
                                        User? user = await FireAuth
                                            .registerUsingEmailPassword(
                                          name: _nameTextController.text,
                                          email: _emailTextController.text,
                                          password:
                                              _passwordTextController.text,
                                        );

                                        setState(() {
                                          _isProcessing = false;
                                        });

                                        if (user != null) {
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ProfilePage(user: user),
                                            ),
                                            ModalRoute.withName('/'),
                                          );
                                        }
                                      }
                                    },
                                    child: Text(
                                      'Sign up',
                                      style: TextStyle(color: Colors.white),
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
          ),
        ),
      ),
    );
  }
}
