import 'dart:convert';
import 'dart:io';
import 'package:bullishield/Screens/HomePage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Signup/signup_screen.dart';
import 'package:http/http.dart' as http;
import 'package:bullishield/user.dart';
import 'package:bullishield/backend.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  // Defining Controller
  final userIdController = TextEditingController();
  final passwordController = TextEditingController();

  // Defining URLS

  void login() async {
    Backend backend = Backend();
    String backendMeta = backend.backendMeta;
    String loginUrl = "$backendMeta/apis/login/";
    try {
      var response = await http.post(Uri.parse(loginUrl), body: {
        'username': userIdController.text.trim(),
        'password': passwordController.text.trim(),
      });

      if ((response.statusCode) == 202) {
        var data = jsonDecode(response.body);
        print(data);

        // get user details via the api
        var userDataURL = (backendMeta) +
            '/apis/user_details/' +
            userIdController.text.trim();
        var getUserData = await http.get(Uri.parse(userDataURL));
        var status = getUserData.statusCode;
        if (getUserData.statusCode == 202) {
          var userResponseData = jsonDecode(getUserData.body);

          //Set the variables in User Class
          var recentUser = User();
          recentUser.user_id = userResponseData['user_id'];
          recentUser.organization_name = userResponseData['organization_name'];
          recentUser.full_name = userResponseData['full_name'];
          recentUser.user_picture = userResponseData['user_picture'];
          recentUser.birth_date = userResponseData['birth_date'];
          recentUser.contact_no = userResponseData['contact_no'];
          recentUser.email_address = userResponseData['email_address'];
          recentUser.home_address = userResponseData['home_address'];
          recentUser.gender = userResponseData['gender'];
          recentUser.is_proctor = userResponseData['is_proctor'];
        }
        if(Platform.isWindows){
          
        }
        if(Platform.isAndroid){
            Fluttertoast.showToast(
            msg: "Login Successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey[700],
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
        
        //TODO:
        //go to backends and get user information on arguments, fix api
        //get response from the api and initialize and test 6s

        // var get_user_info
        // User current_user = User();
        //Go to the homepage upon successful login
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else if ((response.statusCode) == 401) {
        //show toast message upon unsuccessful login

        Fluttertoast.showToast(
          msg: "Wrong credentials! Try again!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey[700],
          textColor: Colors.red,
          fontSize: 16.0,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Please check your network connection and Try again!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey[700],
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Please check your network connection and Try again!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[700],
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            controller: userIdController,
            decoration: InputDecoration(
              hintText: "User ID",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              controller: passwordController,
              decoration: InputDecoration(
                hintText: "Password",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          Hero(
            tag: "login_btn",
            child: ElevatedButton(
              onPressed: login,
              child: Text(
                "Login".toUpperCase(),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SignUpScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
