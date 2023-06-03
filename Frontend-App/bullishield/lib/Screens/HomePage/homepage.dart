import 'dart:convert';
import 'dart:io';
import 'package:bullishield/Screens/NavScreens/ComplainFormScreen.dart';
import 'package:bullishield/Screens/Complain/complain.dart';
import 'package:bullishield/backend.dart';
import 'package:flutter/material.dart';
import 'package:bullishield/user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../widgets/list_widget.dart';
import '../../widgets/nav.dart';
import '../../../constants.dart';
import 'package:http/http.dart' as http;
import 'package:bullishield/widgets/list_widget.dart';

class HomePage extends StatefulWidget {
  final User currentUser;

  const HomePage({Key? key, required this.currentUser}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Complain> complainList = [];

  @override
  void initState() {
    super.initState();
    fetchComplainList(); // Fetch the complain data when the widget is initialized
  }

  Future<void> fetchComplainList() async {
    Backend backend = Backend();
    String backendMeta = backend.backendMeta;
    User currentUser = widget.currentUser;
    String userId = currentUser.user_id;
    final response = await http.get(Uri.parse('$backendMeta/apis/user_complains/$userId'));

    if (response.statusCode == 200) {
      var responseBody = response.body;
      if (responseBody != null && responseBody.isNotEmpty) {
        var data = jsonDecode(responseBody);
        setState(() {
          complainList = List<Complain>.from(data['complains'].map((complainData) {
            return Complain(
              id: complainData['id'],
              complaineeId: complainData['complainee_id_id'],
              organizationId: complainData['organization_id_id'],
              bullyName: complainData['bully_name'],
              bullyId: complainData['bully_id'],
              bullyPicture: complainData['bully_picture'],
              incidentDate: complainData['incident_date'],
              complainTypeId: complainData['complain_type_id'],
              complainDescription: complainData['complain_description'],
              complainValidation: complainData['complain_validation'],
              complainStatus: complainData['complain_status'],
              complainDecision: complainData['complain_decision'] ?? '',
              bullyGuilty: complainData['bully_guilty'],
            );
          }));
        });
      } else {
        if(Platform.isAndroid){
          Fluttertoast.showToast(
            msg: "Currently you dont have any complains lodged",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey[700],
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }else if(Platform.isWindows){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Currently you dont have any complains lodged"),
          ));
        }
      }
    } else {
      if(Platform.isAndroid){
          Fluttertoast.showToast(
            msg: "Something went wrong! Please try again later!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey[700],
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }else if(Platform.isWindows){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Something went wrong! Please try again later!"),
          ));
        }
    }
  }

  Future<void> _refreshList() async {
    await fetchComplainList(); // Refresh the complain list
  }

  @override
  Widget build(BuildContext context) {
    User user = widget.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "BulliShield",
          textScaleFactor: 1.5,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RefreshIndicator(
          onRefresh: _refreshList, // Call the refresh function when pulling down the list
          child: (complainList.isNotEmpty)
              ? ListView.builder(
                  itemCount: complainList.length,
                  itemBuilder: (context, index) {
                    Complain complain = complainList[index];
                    return ListTile(
                      title: Text("Complain Against: ${complain.bullyName}"),
                      subtitle: Text("Complain Description: ${complain.complainDescription}"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ComplainDetailsScreen(complain: complain),
                          ),
                        );
                      },
                    );
                  },
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
      drawer: MyDrawer(currentUser: user),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the Complain screen to create a new complain
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ComplainFormScreen(currentUser: user),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}