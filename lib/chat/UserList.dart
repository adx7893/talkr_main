// ignore_for_file: file_names, avoid_print

import 'DatabaseManager.dart';
import 'package:flutter/material.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List userProfileList = [];

  @override
  void initState() {
    super.initState();
    fetchDatabaseList();
  }

  fetchDatabaseList() async {
    dynamic result = await DatabaseManager().getUsersList();

    if (result != null) {
      setState(() {
        userProfileList = result;
      });
    } else {
      print('Unable to Retrieve');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: const Text(
          "Chat",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        color: Colors.white,
        child: ListView.builder(
            itemCount: userProfileList.length,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Card(
                    child: ListTile(
                      title: Text('${userProfileList[index]['name']}'),
                      subtitle: Text('${userProfileList[index]['email']}'),
                      leading: const CircleAvatar(
                        child: Image(
                          image: AssetImage("assets/images/clock.jpeg"),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
