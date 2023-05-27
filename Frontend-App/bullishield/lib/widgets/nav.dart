// ignore_for_file: prefer_const_constructors
import 'package:bullishield/Screens/HomePage/homepage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bullishield/user.dart';

import '../Screens/AddMore/addnewcomplain.dart';
import '../Screens/Login/login_screen.dart';
import '../Screens/NavScreens/ChatBotScreen.dart';
import '../Screens/NavScreens/ComplainFormScreen.dart';
import '../Screens/NavScreens/NotificationScreen.dart';
import '../Screens/NavScreens/ProfileScreen.dart';
import 'complain_form.dart';

class MyDrawer extends StatelessWidget {
  void getUserdata() async {
    var userName = User().user_id;
    print(userName);
  }

  @override
  Widget build(BuildContext context) {
    getUserdata();
    final imageUrl = "https://avatars.githubusercontent.com/u/96833618?v=4";
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
                  accountName: Text("Farhana"),
                  accountEmail: Text("farhana.akbar@northsouth.edu"),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(imageUrl),
                  )),
            ),
            ListTile(
              onTap: () {
                // Add your desired action here
                // For example, navigate to the Home screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
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
                    builder: (context) => ProfileScreen(),
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
                    builder: (context) => ComplainFormScreen(),
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
