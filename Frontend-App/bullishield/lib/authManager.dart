import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:bullishield/backend.dart';
import 'package:bullishield/Screens/HomePage/homepage.dart';
import 'Screens/Welcome/welcome_screen.dart';
import 'package:flutter/material.dart';

class AuthenticationChecker {
  final String username;
  final String token;
  Timer? _timer;

  AuthenticationChecker({required this.username, required this.token});

  void start() {
    _timer = Timer.periodic(Duration(seconds: 30), (_) {
      _checkAuthentication();
    });
  }

  Future<void> _checkAuthentication() async {
    print("checking");
    try {
      Backend backend = Backend();
      String backendMeta = backend.backendMeta;
      final response = await http.get(
        Uri.parse('$backendMeta/apis/authentication'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final isAuthenticated = data['authenticated'] ?? false;

        // Update your UI based on the authentication status
        // For example, show different screens or UI elements
        if (isAuthenticated) {
          // HomePage();
          print("paisi");
        } else {
          // Show welcome screen
          WelcomeScreen();
        }
      } else {
        WelcomeScreen();
      }
    } catch (e) {
      // Handle any error that occurs during the API request
      if (Platform.isAndroid) {
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
      if (Platform.isWindows) {
        print("Check your internet connection");
      }
    }
  }

  void stop() {
    _timer?.cancel();
  }
}
