import 'package:flutter/material.dart';
import 'package:bullishield/widgets/complain_form.dart';

class ComplainFormScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complain Form'),
      ),
      body: ComplainForm(),
    );
  }
}
