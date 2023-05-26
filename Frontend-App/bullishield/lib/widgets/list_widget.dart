import 'package:flutter/material.dart';

class ListWidget extends StatelessWidget {
  final List list;

  const ListWidget({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreen(
              title: "Complain-01",
              subtitle: "Campus harassment complain against ID: 2031458642",
              status: "Processing",
              complainDetails:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
            ),
          ),
        );
      },
      child: Card(
        color: Colors.purple.shade50,
        child: ListTile(
          title: Text(
            "Complain-01",
            textScaleFactor: 1.5,
            style: TextStyle(
              color: Colors.deepPurple,
            ),
          ),
          subtitle: Text(
            "Campus harassment complain against ID: 2031458642",
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
      ),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final String status;
  final String complainDetails;

  const DetailsScreen({
    required this.title,
    required this.subtitle,
    required this.status,
    required this.complainDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          Text(subtitle),
          Text(status),
          Text(complainDetails),
          // Add more widgets as needed for the details screen
        ],
      ),
    );
  }
}
