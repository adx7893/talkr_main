import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:talkr_demo/resources/auth_methods.dart';
import 'package:talkr_demo/responsive/mobile_screen_layout.dart';
import 'package:talkr_demo/responsive/responsive_layout.dart';
import 'package:talkr_demo/responsive/web_screen_layout.dart';
import 'register_page.dart';
import 'package:talkr_demo/utils/colors.dart';
import 'package:talkr_demo/utils/global_variable.dart';
import 'package:talkr_demo/utils/utils.dart';
import 'package:talkr_demo/widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    if (res == 'success') {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
              mobileScreenLayout: MobileScreenLayout(),
              webScreenLayout: WebScreenLayout(),
            ),
          ),
          (route) => false);

      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            height: 350,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.fill)),
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: 30,
                  width: 80,
                  height: 150,
                  child: Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/light-1.png'))),
                  ),
                ),
                Positioned(
                  left: 140,
                  width: 80,
                  height: 100,
                  child: Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/light-2.png'))),
                  ),
                ),
                Positioned(
                  right: 40,
                  top: 40,
                  width: 80,
                  height: 100,
                  child: Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/clock.jpeg'))),
                  ),
                ),
              ],
            ),
          ),
          Stack(children: [
            Padding(
              // padding: MediaQuery.of(context).size.width > webScreenSize
              //     ? EdgeInsets.symmetric(
              //         horizontal: MediaQuery.of(context).size.width / 3)
              //     : const EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(),
                    flex: 2,
                  ),
                  const SizedBox(
                    height: 250,
                  ),
                  TextFieldInput(
                    hintText: 'Enter your email',
                    textInputType: TextInputType.emailAddress,
                    textEditingController: _emailController,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFieldInput(
                    hintText: 'Enter your password',
                    textInputType: TextInputType.text,
                    textEditingController: _passwordController,
                    isPass: true,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  InkWell(
                    child: Container(
                      child: !_isLoading
                          ? const Text(
                              'Log in',
                            )
                          : const CircularProgressIndicator(
                              color: primaryColor,
                            ),
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        color: Colors.deepPurpleAccent,
                      ),
                    ),
                    onTap: loginUser,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Flexible(
                    child: Container(),
                    flex: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: const Text(
                          'Dont have an account?',
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const SignupScreen(),
                          ),
                        ),
                        child: Container(
                          child: const Text(
                            ' Signup.',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
