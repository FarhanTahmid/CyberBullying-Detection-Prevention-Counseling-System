import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Login/login_screen.dart';
import 'package:http/http.dart' as http;

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);
  @override
  State<SignUpForm> createState() => SignupFormState();
}

class SignupFormState extends State<SignUpForm> {
  // Defining Controllers
  final user_id_controller = TextEditingController();
  final email_controller = TextEditingController();
  final password_controller = TextEditingController();
  final confirm_password_controller = TextEditingController();

  void signup() async {
    var response;

    // first check if two password matches
    if (password_controller.text.trim() ==
        confirm_password_controller.text.trim()) {
      var signup_url = "http://127.0.0.1:8000/apis/signup/";
      // Posting response to backend server
      response = await http.post(Uri.parse(signup_url), body: {
        'username': user_id_controller.text.trim(),
        'password': password_controller.text.trim(),
        'email': email_controller.text.trim()
      });
    } else {
      print("Password Mismatch");
    }

    // Have to show Toast here
    if ((response.statusCode) == 400) {
      print("Username already exists");
    } else if ((response.statusCode) == 201) {
      print("Created");
    } else if ((response.statusCode) == 205) {
      print("Username does not exist in database");
    } else {
      print("No connection");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: user_id_controller,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
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
              controller: email_controller,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              onSaved: (email) {},
              decoration: InputDecoration(
                hintText: "Your email",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.email),
                ),
              ),
            ),
          ),
          TextFormField(
            textInputAction: TextInputAction.done,
            controller: password_controller,
            obscureText: true,
            cursorColor: kPrimaryColor,
            decoration: InputDecoration(
              hintText: "Your password",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(Icons.lock),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: confirm_password_controller,
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                hintText: "Confirm password",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding / 2),
          ElevatedButton(
            onPressed: signup,
            child: Text("Sign Up".toUpperCase()),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
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
