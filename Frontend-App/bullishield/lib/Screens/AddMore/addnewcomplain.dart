import 'dart:io';

import 'package:bullishield/widgets/nav.dart';
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
  TextEditingController _descriptionController = TextEditingController();
  List<File> _images = [];

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
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
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
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: _getImages,
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      size: 50,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text('Description', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
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
            setState(() {
              _images = []; // Clear the selected images
            });
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
