import 'package:flutter/material.dart';

class SeeDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complain Description'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        margin: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '"Filing a cyber bullying complaint is a crucial step in combatting online harassment and ensuring the safety and well-being of victims. By reporting incidents of cyber bullying, individuals contribute to creating a safer digital environment, promoting awareness, and advocating for a society free from the detrimental effects of online abuse. Filing a cyber bullying complaint is a crucial step in combatting online harassment and ensuring the safety and well-being of victims. By reporting incidents of cyber bullying, individuals contribute to creating a safer digital environment, promoting awareness, and advocating for a society free from the detrimental effects of online abuse."',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
