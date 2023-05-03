// ignore_for_file: prefer_const_constructors
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  void getUserdata() async {
    String user_data_url = "http://127.0.0.1:8000/apis/user_details/";

    var response = await http.get(Uri.parse(user_data_url));
    print(response.statusCode);
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
                  accountName: Text("Farhana Akbar"),
                  accountEmail: Text("farhana.akbar@northsouth.edu"),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(imageUrl),
                  )),
            ),
            ListTile(
              leading: Icon(
                CupertinoIcons.home,
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
            ListTile(
              leading: Icon(
                CupertinoIcons.bell_circle,
                color: Colors.purple.shade900,
              ),
              title: Text(
                "Notifications",
                textScaleFactor: 1.2,
                style: TextStyle(
                  color: Colors.purple.shade900,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
