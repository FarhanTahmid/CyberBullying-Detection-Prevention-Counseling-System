<<<<<<< HEAD
import 'package:bullishield/Screens/HomePage/homepage.dart';
import 'package:bullishield/Screens/Login/components/login_form.dart';
import 'package:bullishield/Screens/Login/login_screen.dart';
import 'package:bullishield/Screens/Signup/signup_screen.dart';
=======
import 'Screens/Welcome/welcome_screen.dart';
>>>>>>> f45eb2c865937658ba55513fc4340408644c93b5
import 'package:flutter/material.dart';
import 'package:bullishield/constants.dart';
import 'package:http/http.dart' as http;
<<<<<<< HEAD

import 'Screens/NavScreens/ChatBotScreen.dart';
=======
import 'package:bullishield/authManager.dart';
import 'package:shared_preferences/shared_preferences.dart';
>>>>>>> f45eb2c865937658ba55513fc4340408644c93b5
import 'widgets/list_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthenticationChecker? _authChecker;
  late Future<String> _usernameFuture;
  late Future<String> _tokenFuture;

  // Retrieving the token
  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }

  Future<String> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('username') ?? '';
  }

  @override
  void initState() {
    super.initState();
    _usernameFuture = getUsername();
    _tokenFuture = getToken();
    _performAuthenticationCheck();
  }

  @override
  void dispose() {
    _authChecker?.stop();
    super.dispose();
  }

  void _performAuthenticationCheck() {
    Future.wait([_usernameFuture, _tokenFuture]).then((List<dynamic> snapshot) {
      String username = snapshot[0];
      String token = snapshot[1];

      _authChecker = AuthenticationChecker(
        username: username,
        token: token,
      );
      _authChecker?.start();
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BulliBlock',
      themeMode: ThemeMode.light,
      theme: ThemeData(primarySwatch: Colors.purple),
      darkTheme: ThemeData(
          appBarTheme: AppBarTheme(
            color: Colors.purple,
            iconTheme: IconThemeData(color: Colors.white),
          ),
          primarySwatch: Colors.purple,
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              primary: kPrimaryColor,
              shape: const StadiumBorder(),
              maximumSize: const Size(double.infinity, 56),
              minimumSize: const Size(double.infinity, 56),
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: kPrimaryLightColor,
            iconColor: kPrimaryColor,
            prefixIconColor: kPrimaryColor,
            contentPadding: EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide.none,
            ),
          )),
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => WelcomeScreen(),
      },
    );
  }
}
