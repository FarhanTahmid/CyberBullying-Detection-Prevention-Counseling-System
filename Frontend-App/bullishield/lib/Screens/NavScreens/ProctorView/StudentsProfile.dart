import 'package:flutter/material.dart';

class StudentProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('assets/ProfilePicture.png'),
            ),
            SizedBox(height: 16),
            Text(
              'Farhan Ishrak',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'ID: 123456',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 16),
            _buildProfileItem('Department', 'ECE'),
            SizedBox(height: 8),
            _buildProfileItem('Email', 'farhanishrak@nsu.edu'),
            SizedBox(height: 8),
            _buildProfileItem('Phone Number', '01 234 567 890'),
            SizedBox(height: 8),
            _buildProfileItem('Address', '123 Street, Mohammadpur, Dhaka'),
            SizedBox(height: 8),
            _buildProfileItem("Parent's Phone Number", '01 987 654 321'),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(String label, String value) {
    return Row(
      children: [
        Text(
          '$label:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
