import 'package:flutter/material.dart';

import 'ParentsMeeting.dart';
import 'SeeDescription.dart';
import 'StudentsProfile.dart';
import 'SubmittedProves.dart';

class ProctorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Proctor Screen'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ComplainCard(
            title: "Complain-01",
            subtitle: "Campus harassment complain against Farhan Tahmid",
            status: "Unchecked",
            complainDetails:
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
            onTap: () {
              // Handle tap on the complain card
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ComplainDetailsScreen(
                    title: "Complain-01",
                    subtitle:
                        "Campus harassment complain against Farhan Tahmid",
                    status: "Unchecked",
                    complainDetails:
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 16),
          ComplainCard(
            title: "Complain-02",
            subtitle: "Academic misconduct complain against John Doe",
            status: "Checked",
            complainDetails:
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
            onTap: () {
              // Handle tap on the complain card
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ComplainDetailsScreen(
                    title: "Complain-02",
                    subtitle: "Academic misconduct complain against John Doe",
                    status: "Checked",
                    complainDetails:
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ComplainCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String status;
  final String complainDetails;
  final VoidCallback onTap;

  ComplainCard({
    required this.title,
    required this.subtitle,
    required this.status,
    required this.complainDetails,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 8),
              Text(
                status,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ComplainDetailsScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final String status;
  final String complainDetails;

  ComplainDetailsScreen({
    required this.title,
    required this.subtitle,
    required this.status,
    required this.complainDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complain Details'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16.0),
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    'Status:',
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    status,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.amber.shade800,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        'Complain from',
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StudentProfile(),
                            ),
                          );
                        },
                        child: Text(
                          "Farhana Akbar",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.cyan.shade900,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(children: [
                Text(
                  'Complain against',
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StudentProfile(),
                      ),
                    );
                  },
                  child: Text(
                    "Farhan Ishrak Tahmid",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.cyan.shade900,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ]),
              SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    'Type of harassment:',
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Cyber Bully",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.pink.shade900,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    'Date and time:',
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    "31st February, 2023.12pm",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    'Place or Platform:',
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    "NSU Campus",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SeeDescription(),
                    ),
                  );
                },
                child: Text(
                  "See Description",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(51, 17, 60, 1),
                    decoration: TextDecoration.none,
                  ),
                  textScaleFactor: 1.2,
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Handle "View Submitted Proves" button tap
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubmittedProves(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.amber,
                    ),
                    child: Text(
                      'View Submitted Proves',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      textScaleFactor: 1.3,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Enter text',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Handle "View Submitted Proves" button tap
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ParentsMeeting(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.cyan,
                    ),
                    child: Text(
                      'Call Both Parents',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      textScaleFactor: 1.3,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Handle "bully is not guilty" button tap
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                    child: Text('Bully is Not Guilty'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle "bully is guilty" button tap
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                    child: Text('Bully is Guilty'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
