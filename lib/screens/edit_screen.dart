import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talkr_demo/utils/colors.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  String? singleImage;
  final firebase = FirebaseFirestore.instance;

  create() async {
    try {
      await firebase
          .collection("new")
          .doc(name.text)
          .set({"name": name.text, "email": email.text});
    } catch (e) {
      print(e);
    }
  }

  update() async {
    try {
      await firebase
          .collection("new")
          .doc(name.text)
          .update({"name": name.text, "email": email.text});
    } catch (e) {
      print(e);
    }
  }

  delete() async {
    try {
      firebase.collection("new").doc(name.text).delete();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 35,
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text(
          "Edit",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Lato",
            // fontStyle: FontStyle.italic,
            fontSize: 20.0,
          ),
        ),
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Center(
              heightFactor: 1.3,
              child: GestureDetector(
                  onTap: () async {
                    XFile? _image = await singleImagePick();
                    if (_image != null && _image.path.isNotEmpty) {
                      singleImage = await uploadImage(_image);
                      setState(() {});
                    }
                  },
                  child: ClipOval(
                      child: Container(
                    width: size.width / 4,
                    height: size.height / 7.5,
                    color: Colors.black12,
                    child: singleImage != null && singleImage!.isNotEmpty
                        ? Image.network(
                            singleImage!,
                            fit: BoxFit.fill,
                          )
                        : Icon(
                            Icons.add_a_photo,
                            size: 40,
                          ),
                  ))),
            ),
            Container(
                margin: EdgeInsets.only(top: 200, left: 30, right: 30),
                height: size.height / 15,
                width: size.width,
                child: Text(
                  "Change Profile Picture",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            Container(
              margin: EdgeInsets.only(top: 260, left: 30, right: 30),
              height: size.height / 15,
              width: size.width,
              child: TextField(
                controller: name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  labelText: "Username",
                ),
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 320, left: 30, right: 30),
              height: size.height / 15,
              width: size.width,
              //color: Colors.black54,
              child: TextField(
                controller: email,
                decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 400, left: 30, right: 30),
              height: size.height / 15,
              width: size.width,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.deepPurpleAccent),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
                onPressed: () {
                  create();
                  name.clear();
                  email.clear();
                },
                child: Text(
                  "Submit",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 460, left: 30, right: 30),
              height: size.height / 15,
              width: size.width,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.deepPurpleAccent),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
                onPressed: () {
                  update();
                  name.clear();
                  email.clear();
                },
                child: Text(
                  "Update",
                  style: TextStyle(
                      color: Colors.black,
                      backgroundColor: Colors.deepPurpleAccent),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 520, left: 30, right: 30),
              height: size.height / 15,
              width: size.width,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.deepPurpleAccent),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
                onPressed: () {
                  delete();
                  name.clear();
                  email.clear();
                },
                child: Text(
                  "Delete",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<XFile?> singleImagePick() async {
  return await ImagePicker().pickImage(source: ImageSource.gallery);
}

Future<String> uploadImage(XFile image) async {
  Reference db = FirebaseStorage.instance.ref('test/${getImageName(image)}');
  await db.putFile(File(image.path));
  return await db.getDownloadURL();
}

String getImageName(XFile image) {
  return image.path.split("/").last;
}
