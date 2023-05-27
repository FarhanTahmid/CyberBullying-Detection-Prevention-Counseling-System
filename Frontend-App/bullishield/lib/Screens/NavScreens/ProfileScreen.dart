import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _profilePicture;
  bool _isEditing = false;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _nsuIdController = TextEditingController();
  TextEditingController _programController = TextEditingController();
  TextEditingController _cgpaController = TextEditingController();
  TextEditingController _creditController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _emergencyPhoneController = TextEditingController();
  TextEditingController _parentNameController = TextEditingController();
  TextEditingController _parentPhoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = 'Farhana Akbar';
    _nsuIdController.text = '2012482042';
    _programController.text = 'Computer Science and Engineering';
    _cgpaController.text = '3.00';
    _creditController.text = '106';
    _emailController.text = 'farhana.akbar@northsouth.edu';
    _phoneController.text = '1234567890';
    _addressController.text = 'NAC-SAC BRIDGE, NSU';
    _emergencyPhoneController.text = '01987654321';
    _parentNameController.text = 'Mr. Akbar';
    _parentPhoneController.text = '019876543210';
  }

  Future<void> _pickProfilePicture() async {
    final ImagePicker _picker = ImagePicker();

    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile != null) {
        setState(() {
          _profilePicture = File(pickedFile.path);
        });
      }
    } catch (e) {
      print('Error picking profile picture: $e');
    }
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveChanges() {
    // Perform necessary actions to save the changes
    _toggleEdit(); // Exit editing mode after saving
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.done : Icons.edit),
            onPressed: _isEditing ? _saveChanges : _toggleEdit,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
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
                  GestureDetector(
                    onTap: _isEditing ? _pickProfilePicture : null,
                    child: Container(
                      width: 128,
                      height: 128,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.purple.shade100,
                        image: _profilePicture != null
                            ? DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(_profilePicture!),
                              )
                            : null,
                      ),
                      child: _profilePicture == null
                          ? Icon(
                              Icons.person,
                              size: 64,
                              color: Colors.white,
                            )
                          : null,
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildProfileField('Student Name: ', _nameController),
                  _buildDivider(),
                  _buildProfileField('NSU ID: ', _nsuIdController),
                  _buildDivider(),
                  _buildProfileField('Undergrad Program: ', _programController),
                  _buildDivider(),
                  _buildProfileField('CGPA: ', _cgpaController),
                  _buildDivider(),
                  _buildProfileField('Credits Completed: ', _creditController),
                  SizedBox(height: 20),
                  _buildProfileField('Contact Information', null),
                  _buildDivider(),
                  _buildProfileField('NSU Mail: ', _emailController),
                  _buildDivider(),
                  _buildProfileField('Phone: ', _phoneController),
                  _buildDivider(),
                  _buildProfileField('Address: ', _addressController),
                  _buildDivider(),
                  _buildProfileField(
                      'Emergency Contact: ', _emergencyPhoneController),
                  _buildDivider(),
                  _buildProfileField("Parent's Name: ", _parentNameController),
                  _buildDivider(),
                  _buildProfileField(
                      "Parent's Phone: ", _parentPhoneController),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileField(String label, TextEditingController? controller) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          _isEditing
              ? TextFormField(
                  controller: controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                )
              : Text(
                  controller?.text ?? '',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.left,
                ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.deepPurple,
      height: 32,
      thickness: 1,
    );
  }
}
