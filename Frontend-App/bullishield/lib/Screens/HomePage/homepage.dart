import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../widgets/list_widget.dart';
import '../../widgets/nav.dart';
import '../Complain/complain.dart';
import '../../../constants.dart';


class HomePage extends StatefulWidget {
  final String name = "BulliSheild";
  const HomePage({
    Key? key,
  }) : super(key: key);
  @override
  State<HomePage>createState()=>HomePageState();
}

class HomePageState extends State<HomePage>{



  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "BulliSheild",
          textScaleFactor: 1.5,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        
        child: (ComplainModel.list != null && ComplainModel.list.isNotEmpty)
            ? ListView.builder(
                itemCount: ComplainModel.list.length,
                itemBuilder: (context, index) => ListWidget(
                  list: ComplainModel.list,
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
      drawer: MyDrawer(),
    );
  }
}
