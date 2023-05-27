import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ComplainForm extends StatefulWidget {
  @override
  _ComplainFormState createState() => _ComplainFormState();
}

class _ComplainFormState extends State<ComplainForm> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _idController = TextEditingController();
  TextEditingController _bullyNameController = TextEditingController();
  TextEditingController _bullyIdController = TextEditingController();
  TextEditingController _bullyingDateTimeController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  List<File> _images = [];
  String? _selectedHarassmentType;

  Future<void> _getImages() async {
    final picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage();

    if (pickedImages != null) {
      setState(() {
        _images =
            pickedImages.map((pickedImage) => File(pickedImage.path)).toList();
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _idController.dispose();
    _bullyNameController.dispose();
    _bullyIdController.dispose();
    _bullyingDateTimeController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Container(
          margin: EdgeInsets.all(16.0),
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.purple.shade100.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              SizedBox(height: 20),
              Text(
                'Fill out this form carefully',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.purple,
                ),
                textScaleFactor: 1.4,
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Your Name',
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _idController,
                decoration: InputDecoration(
                  labelText: 'Your ID',
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _bullyNameController,
                decoration: InputDecoration(
                  labelText: 'Name of bully',
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _bullyIdController,
                decoration: InputDecoration(
                  labelText: 'ID of bully',
                ),
              ),
              SizedBox(height: 30),
              Text('Add a Picture of Bully', style: TextStyle(fontSize: 18)),
              SizedBox(height: 20),
              Container(
                height: 100,
                width: 200,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.purple,
                  ),
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _images.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(4),
                      child: Image.file(
                        _images[index],
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: _getImages,
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.purple.shade200,
                    ),
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    size: 50,
                    color: Colors.purple.shade800,
                  ),
                ),
              ),
              SizedBox(height: 30),
              TextFormField(
                controller: _bullyingDateTimeController,
                decoration: InputDecoration(
                  labelText: 'Date and Time of being Bullied',
                ),
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _selectedHarassmentType,
                decoration: InputDecoration(
                  labelText: 'Type of harassment',
                ),
                onChanged: (newValue) {
                  setState(() {
                    _selectedHarassmentType = newValue;
                  });
                },
                items: [
                  DropdownMenuItem(
                    value: 'Physical',
                    child: Text('Physical'),
                  ),
                  DropdownMenuItem(
                    value: 'Verbal',
                    child: Text('Verbal'),
                  ),
                  DropdownMenuItem(
                    value: 'Cyber',
                    child: Text('Cyber'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text('Add Valid Images', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.purple,
                  ),
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _images.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(4),
                      child: Image.file(
                        _images[index],
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: _getImages,
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.purple.shade200,
                    ),
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    size: 50,
                    color: Colors.purple.shade800,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text('Add description of your complaint',
                  style: TextStyle(fontSize: 18)),
              SizedBox(height: 15),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Describe here',
                ),
                maxLines: null,
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Process the form data here
                      String name = _nameController.text;
                      String id = _idController.text;
                      String bullyName = _bullyNameController.text;
                      String bullyId = _bullyIdController.text;
                      String bullyingDateTime =
                          _bullyingDateTimeController.text;
                      String description = _descriptionController.text;
                      String? harassmentType = _selectedHarassmentType;

                      // Perform any desired action with the form data

                      // Clear the form fields
                      _nameController.clear();
                      _idController.clear();
                      _bullyNameController.clear();
                      _bullyIdController.clear();
                      _bullyingDateTimeController.clear();
                      _descriptionController.clear();
                      setState(() {
                        _images = []; // Clear the selected images
                        _selectedHarassmentType =
                            null; // Clear the selected harassment type
                      });
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
