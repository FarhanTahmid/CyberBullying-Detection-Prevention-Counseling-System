import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import '../Complain/complain.dart';

class ComplainForm extends StatefulWidget {
  @override
  _ComplainFormState createState() => _ComplainFormState();
}

class _ComplainFormState extends State<ComplainForm> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _idController = TextEditingController();
  TextEditingController _bullyNameController = TextEditingController();
  TextEditingController _bullyIdController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _idController.dispose();
    _bullyNameController.dispose();
    _bullyIdController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Complain Form'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Your Name',
              ),
            ),
            TextFormField(
              controller: _idController,
              decoration: InputDecoration(
                labelText: 'Your ID',
              ),
            ),
            TextFormField(
              controller: _bullyNameController,
              decoration: InputDecoration(
                labelText: 'Name of bully',
              ),
            ),
            TextFormField(
              controller: _bullyIdController,
              decoration: InputDecoration(
                labelText: 'ID of bully',
              ),
            ),
            SizedBox(height: 20),
            Text('Proofs', style: TextStyle(fontSize: 18)),
            // Add your implementation for uploading images
            SizedBox(height: 20),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Add description of your complain',
              ),
              maxLines: null,
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            // Process the form data here
            String name = _nameController.text;
            String id = _idController.text;
            String bullyName = _bullyNameController.text;
            String bullyId = _bullyIdController.text;
            String description = _descriptionController.text;

            // Perform any desired action with the form data

            // Clear the form fields
            _nameController.clear();
            _idController.clear();
            _bullyNameController.clear();
            _bullyIdController.clear();
            _descriptionController.clear();

            // Close the form
            Navigator.of(context).pop();
          },
          child: Text('Submit'),
        ),
        TextButton(
          onPressed: () {
            // Close the form without submitting
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return ComplainForm();
              },
            );
          },
          child: Text('Open Complain Form'),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}
