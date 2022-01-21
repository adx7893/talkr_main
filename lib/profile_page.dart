import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'main.dart';

class ProfilePage extends StatefulWidget {
  final User user;

  const ProfilePage({required this.user});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isSigningOut = true;
  List<String> _options = ["HOME", "SEARCH", "POST", "LIKES", "PROFILE"];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black),
      body: Container(
        color: Colors.black,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        buttonBackgroundColor: Colors.black,
        backgroundColor: Colors.black,
        animationDuration: Duration(seconds: 1),
        animationCurve: Curves.easeOut,
        items: <Widget>[
          Icon(Icons.home_filled, color: Colors.deepPurpleAccent),
          Icon(
            Icons.search_rounded,
            color: Colors.deepPurpleAccent,
          ),
          Icon(
            Icons.add_a_photo_rounded,
            color: Colors.deepPurpleAccent,
          ),
          Icon(
            Icons.favorite_border_rounded,
            color: Colors.deepPurpleAccent,
          ),
          Icon(
            Icons.person,
            color: Colors.deepPurpleAccent,
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

/*class _ProfilePageState extends State<ProfilePage> {
  bool _isSigningOut = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome to your profile"),
            SizedBox(height: 500.0),
            _isSigningOut
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        _isSigningOut = true;
                      });

                      await FirebaseAuth.instance.signOut();
                      setState(() {
                        _isSigningOut = false;
                      });
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                    child: Text('Sign out'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}*/
