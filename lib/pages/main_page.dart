import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:talkr_demo/screens/like_screen.dart';
import 'package:talkr_demo/screens/post_screen.dart';
import 'package:talkr_demo/screens/feed_screen.dart';
import 'package:talkr_demo/screens/search_screen.dart';
import '../screens/profile_screen.dart';

class MainPage extends StatefulWidget {
  final User user;

  const MainPage({required this.user});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _isSigningOut = true;
  List<String> _options = ["HOME", "SEARCH", "POST", "LIKES", "PROFILE"];
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 1;
  final screens = [
    FeedScreen(),
    SearchScreen(),
    PostScreen(),
    LikeScreen(),
    ProfileScreen()
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(Icons.home_filled),
      Icon(Icons.search_rounded),
      Icon(Icons.add_a_photo_rounded),
      Icon(Icons.favorite_border_rounded),
      Icon(Icons.person),
    ];
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(iconTheme: IconThemeData(color: Colors.white)),
        child: CurvedNavigationBar(
          key: navigationKey,
          index: index,
          buttonBackgroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          animationDuration: Duration(milliseconds: 400),
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
          onTap: (index) => setState(() => this.index = index),
        ),
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
