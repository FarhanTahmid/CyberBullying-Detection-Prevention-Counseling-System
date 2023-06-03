import 'dart:convert';
import 'dart:io';
import 'package:bullishield/backend.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:bullishield/user.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';


class ComplainForm extends StatefulWidget {
  final User currentUser;

  const ComplainForm({Key? key, required this.currentUser}) : super(key: key);

  @override
  _ComplainFormState createState() => _ComplainFormState();
}

class _ComplainFormState extends State<ComplainForm> {
  Backend backend = Backend();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _idController = TextEditingController();
  TextEditingController _bullyNameController = TextEditingController();
  TextEditingController _bullyIdController = TextEditingController();
  TextEditingController _bullyingDateTimeController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  List<File> _images = [];
  List<File> _bullyImage = [];
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

  Future<void> _getBullyImages() async {
    final picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage();

    if (pickedImages != null) {
      setState(() {
        _bullyImage =
            pickedImages.map((pickedImage) => File(pickedImage.path)).toList();
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
}

  Future<List<String>> getHarassmentTypes() async {
    final List<String> harassmentTypes = [];
    // Make an HTTP GET request to your API endpoint
    Backend backend = Backend();
    String backendMeta = backend.backendMeta;
    final response =
        await http.get(Uri.parse('$backendMeta/apis/complain_types'));

    // Check if the request was successful
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      jsonResponse['types'].forEach((key, value) {
        harassmentTypes.add(value);
      });
    }
    return harassmentTypes;
  }

  // SEND COMPLAIN DATA THROUGH API

  void complainRegistration(String bullyName, String bullyid,
      String incidentDate, String description, String? harrasmentType) async {
    User currentUser = widget.currentUser;
    String backendMeta = backend.backendMeta;
    String postComplainUrl = '$backendMeta/apis/complain_reg/';
    String user_id = currentUser.user_id;
    String user_name = currentUser.full_name;

    // Create a new multipart request
    var request = http.MultipartRequest('POST', Uri.parse(postComplainUrl));

    // Add string fields to the request
    request.fields['user_id'] = user_id;
    request.fields['user_name'] = user_name;
    request.fields['bully_name'] = bullyName;
    request.fields['bully_id'] = bullyid;
    request.fields['incident_date'] = _dateController.text.trim();
    request.fields['description'] = description;
    request.fields['harrasment_type'] = harrasmentType ?? '';

    // Add image files to the request
    for (var image in _images) {
      var imageFile =
          await http.MultipartFile.fromPath('image_proves', image.path);
      request.files.add(imageFile);
    }

    // Add bully image file to the request
    for (var image in _bullyImage) {
      var bullyImageFile =
          await http.MultipartFile.fromPath('bully_image', image.path);
      request.files.add(bullyImageFile);
    }
    // Send the request
    var response = await request.send();
    print(request);
    if (response.statusCode == 200) {
      if (Platform.isAndroid) {
        Fluttertoast.showToast(
          msg: "Complain posted successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey[700],
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else if (Platform.isWindows) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Complain posted successfully"),
        ));
      } else {
        if (Platform.isAndroid) {
          Fluttertoast.showToast(
            msg: "Something went wrong! Please try again later.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey[700],
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else if (Platform.isWindows) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Something went wrong! Please try again later."),
          ));
        }
      }
    }
    // } catch (e) {
    //   if (Platform.isAndroid) {
    //     Fluttertoast.showToast(
    //       msg: "Please check your internet connection and try agin!",
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.BOTTOM,
    //       timeInSecForIosWeb: 1,
    //       backgroundColor: Colors.grey[700],
    //       textColor: Colors.white,
    //       fontSize: 16.0,
    //     );
    //   } else if (Platform.isWindows) {
    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //       content: Text("Please check your internet connection and try agin!"),
    //     ));
    //   }
    // }
  }

  List<String> _harassmentTypes = [];

  @override
  void initState() {
    super.initState();
    fetchHarassmentTypes();
  }

  Future<void> fetchHarassmentTypes() async {
    try {
      List<String> types = await getHarassmentTypes();
      setState(() {
        _harassmentTypes = types;
      });
    } catch (e) {
      // Handle the error if the harassment types couldn't be fetched
      print('Error: $e');
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
                  itemCount: _bullyImage.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(4),
                      child: Image.file(
                        _bullyImage[index],
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
                onTap: _getBullyImages,
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
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _dateController,
                    decoration: InputDecoration(
                      labelText: 'Date of being Bullied',
                    ),
                  ),
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
                items: _harassmentTypes.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
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
                      String bullyName = _bullyNameController.text;
                      String bullyId = _bullyIdController.text;
                      String bullyingDateTime =
                          _bullyingDateTimeController.text;
                      String description = _descriptionController.text;
                      String? harassmentType = _selectedHarassmentType;

                      // Perform complain registration action with the form data
                      complainRegistration(bullyName, bullyId, bullyingDateTime,
                          description, harassmentType);
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
