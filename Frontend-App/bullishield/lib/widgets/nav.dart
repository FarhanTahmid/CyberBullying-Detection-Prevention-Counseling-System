// ignore_for_file: prefer_const_constructors
import 'dart:io';
import 'dart:ui';

import 'package:bullishield/Screens/HomePage/homepage.dart';
import 'package:bullishield/backend.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bullishield/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Screens/Login/login_screen.dart';
import '../Screens/NavScreens/ChatBotScreen.dart';
import '../Screens/NavScreens/ComplainFormScreen.dart';
import '../Screens/NavScreens/NotificationScreen.dart';
import '../Screens/NavScreens/ProfileScreen.dart';
import '../Screens/NavScreens/ProctorView/ProctorScreen.dart';
import 'complain_form.dart';

class MyDrawer extends StatefulWidget {
  final User currentUser;

  const MyDrawer({Key? key, required this.currentUser}) : super(key: key);
  @override
  State<MyDrawer> createState() => MyDrawerState();
}

class MyDrawerState extends State<MyDrawer> {
  String username = '';
  String email = '';

  String userImageUrl = '';

  void getUserDetails() {
    Backend backend = Backend();
    String backendMeta = backend.backendMeta;
    User currentUser = widget.currentUser;
    username = currentUser.full_name;
    email = currentUser.email_address;
    userImageUrl = currentUser.user_picture;
  }

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  Future<void> removeUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.purple.shade100,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.purpleAccent),
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              child: UserAccountsDrawerHeader(
                  accountName: Text(username),
                  accountEmail: Text(email),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(userImageUrl),
                  )),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
              },
              leading: Icon(
                CupertinoIcons.house_fill,
                color: Colors.purple.shade900,
              ),
              title: Text(
                "Home",
                textScaleFactor: 1.2,
                style: TextStyle(
                  color: Colors.purple.shade900,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                // Add your desired action here
                // For example, navigate to the Profile screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProfileScreen(currentUser: widget.currentUser),
                  ),
                );
              },
              leading: Icon(
                CupertinoIcons.profile_circled,
                color: Colors.purple.shade900,
              ),
              title: Text(
                "Profile",
                textScaleFactor: 1.2,
                style: TextStyle(
                  color: Colors.purple.shade900,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // Add your desired action here
                // For example, navigate to the Notifications screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationScreen(),
                  ),
                );
              },
              child: ListTile(
                leading: Icon(
                  CupertinoIcons.bell_circle_fill,
                  color: Colors.purple.shade900,
                ),
                title: Text(
                  "Notifications",
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Colors.purple.shade900,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // Add your desired action here
                // For example, navigate to the Notifications screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatBotScreen(),
                  ),
                );
              },
              child: ListTile(
                leading: Icon(
                  CupertinoIcons.chat_bubble_2_fill,
                  color: Colors.purple.shade900,
                ),
                title: Text(
                  "Talk to ChatBot",
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Colors.purple.shade900,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // Add your desired action here
                // For example, navigate to the Notifications screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ComplainFormScreen(currentUser: widget.currentUser),
                  ),
                );
              },
              child: ListTile(
                leading: Icon(
                  CupertinoIcons.add_circled_solid,
                  color: Colors.purple.shade900,
                ),
                title: Text(
                  "Add New Complain",
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Colors.purple.shade900,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // Add your desired action here
                // For example, navigate to the Notifications screen
                if (widget.currentUser.is_proctor) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProctorScreen(),
                    ),
                  );
                } else {
                  if (Platform.isWindows) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("You are not a Proctor!"),
                    ));
                  } else if (Platform.isAndroid) {
                    Fluttertoast.showToast(
                      msg: "You are not a Proctor!",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.grey[700],
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  }
                }
              },
              child: ListTile(
                leading: Icon(
                  CupertinoIcons.person_crop_rectangle,
                  color: Colors.purple.shade900,
                ),
                title: Text(
                  "Proctor page",
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Colors.purple.shade900,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // Add your desired action here
                // For example, navigate to the Notifications screen
                removeToken();
                removeUsername();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              child: ListTile(
                leading: Icon(
                  CupertinoIcons.eject_fill,
                  color: Colors.purple.shade900,
                ),
                title: Text(
                  "Logout",
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Colors.purple.shade900,
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
