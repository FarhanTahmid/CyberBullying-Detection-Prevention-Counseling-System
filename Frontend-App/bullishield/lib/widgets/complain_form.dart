import 'dart:convert';
import 'dart:io';
import 'package:bullishield/backend.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:bullishield/user.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;
import 'package:async/async.dart';

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
    // Windows-specific image capturing
    if (Platform.isWindows) {
      print("here");
      final filePickerResult = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
      );

      if (filePickerResult != null) {
        final pickedFiles =
            filePickerResult.paths.map((path) => File(path!)).toList();
        setState(() {
          _images.addAll(pickedFiles);
        });
      }
    } else {
      final picker = ImagePicker();
      final pickedImages = await picker.pickMultiImage();
      if (pickedImages != null) {
        setState(() {
          _images = pickedImages
              .map((pickedImage) => File(pickedImage.path))
              .toList();
        });
      }
    }
  }

  Future<void> _getBullyImages() async {
    // Windows-specific image capturing
    if (Platform.isWindows) {
      final filePickerResult = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
      );

      if (filePickerResult != null) {
        final pickedFiles =
            filePickerResult.paths.map((path) => File(path!)).toList();
        setState(() {
          _bullyImage.addAll(pickedFiles);
        });
      }
    } else {
      final picker = ImagePicker();
      final pickedImages = await picker.pickMultiImage();

      if (pickedImages != null) {
        setState(() {
          _bullyImage = pickedImages
              .map((pickedImage) => File(pickedImage.path))
              .toList();
        });
      }
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
      var stream = http.ByteStream(DelegatingStream.typed(image.openRead()));
      var length = await image.length();

      var multipartFile = http.MultipartFile(
        'image_proves',
        stream,
        length,
        filename: path.basename(image.path),
      );

      request.files.add(multipartFile);
    }

    // Add bully image file to the request
    for (var image in _bullyImage) {
      var stream = http.ByteStream(DelegatingStream.typed(image.openRead()));
      var length = await image.length();

      var multipartFile = http.MultipartFile(
        'bully_image',
        stream,
        length,
        filename: path.basename(image.path),
      );

      request.files.add(multipartFile);
    }
    // Send the request
    try{
      var response = await request.send();

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
    } catch (e) {
      if (Platform.isAndroid) {
        Fluttertoast.showToast(
          msg: "Please check your internet connection and try agin!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey[700],
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else if (Platform.isWindows) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Please check your internet connection and try agin!"),
        ));
      }
    }
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
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16.0),
            Text(
              'Bully Details',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: _bullyNameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: _bullyIdController,
              decoration: InputDecoration(labelText: 'ID'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Incident Details',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: TextField(
                  controller: _dateController,
                  decoration: InputDecoration(
                    labelText: 'Date',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Description',
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Select Harassment Type',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            FutureBuilder<List<String>>(
              future: getHarassmentTypes(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List<String> harassmentTypes = snapshot.data ?? [];
                  return DropdownButtonFormField<String>(
                    value: _selectedHarassmentType,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedHarassmentType = newValue;
                      });
                    },
                    items: harassmentTypes.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: 'Select Type',
                      border: OutlineInputBorder(),
                    ),
                  );
                }
              },
            ),
            SizedBox(height: 16.0),
            Text(
              'Upload Evidence',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: _getImages,
              child: Text('Select Images'),
            ),
            SizedBox(height: 8.0),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              children: List.generate(_images.length, (index) {
                File image = _images[index];
                return Image.file(image);
              }),
            ),
            SizedBox(height: 16.0),
            Text(
              'Upload Bully Images',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: _getBullyImages,
              child: Text('Select Bully Images'),
            ),
            SizedBox(height: 8.0),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              children: List.generate(_bullyImage.length, (index) {
                File image = _bullyImage[index];
                return Image.file(image);
              }),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (_bullyNameController.text.isEmpty ||
                    _bullyIdController.text.isEmpty ||
                    _dateController.text.isEmpty ||
                    _descriptionController.text.isEmpty ||
                    _selectedHarassmentType == null) {
                  if (Platform.isAndroid) {
                    Fluttertoast.showToast(
                      msg: 'Please fill all the fields and select images',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                    );
                  } else if (Platform.isWindows) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                          Text("Please fill all the fields and select images"),
                    ));
                  }
                } else {
                  complainRegistration(
                    _bullyNameController.text,
                    _bullyIdController.text,
                    _dateController.text,
                    _descriptionController.text,
                    _selectedHarassmentType,
                  );
                }
              },
              child: Text('Submit'),
            ),
            TextButton(
              onPressed: () {
                // Clear the form fields
                _nameController.clear();
                _idController.clear();
                _bullyNameController.clear();
                _bullyIdController.clear();
                _bullyingDateTimeController.clear();
                _descriptionController.clear();
                setState(() {
                  _images = []; // Clear the selected images
                  _bullyImage = []; // Clear the selected bully images
                  _selectedHarassmentType =
                      null; // Clear the selected harassment type
                });
              },
              child: Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}
