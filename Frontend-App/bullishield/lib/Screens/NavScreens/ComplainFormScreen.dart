import 'package:bullishield/user.dart';
import 'package:flutter/material.dart';
import 'package:bullishield/widgets/complain_form.dart';

class ComplainFormScreen extends StatelessWidget {
  final User currentUser;
  const ComplainFormScreen({required this.currentUser});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complain Form'),
      ),
      body: ComplainForm(currentUser: currentUser),
    );
  }
}
