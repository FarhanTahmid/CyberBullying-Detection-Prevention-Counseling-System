import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../constants.dart';

class ListWidget extends StatelessWidget {
  final List list;

  const ListWidget({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.purple.shade50,
      child: ListTile(
        onTap: () {
          print("Complain Card Opened");
        },
        title: Text(
          "Complain-01",
          textScaleFactor: 1.5,
          style: TextStyle(
            color: Colors.deepPurple,
          ),
        ),
        subtitle: Text(
          "Campus harassment complain agianst ID: 2031458642",
          style: TextStyle(
            color: Colors.blueGrey,
          ),
        ),
        trailing: Text(
          "Processing",
          textScaleFactor: 1.3,
          style: TextStyle(
            color: Colors.amber,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    ButtonBar(
      buttonPadding: EdgeInsets.zero,
      children: [
        ElevatedButton(
          onPressed: () {},
          child: "Add".text.make(),
        )
      ],
    );
  }
}
