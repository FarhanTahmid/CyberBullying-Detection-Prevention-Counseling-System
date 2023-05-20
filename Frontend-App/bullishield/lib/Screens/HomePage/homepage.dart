import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../widgets/list_widget.dart';
import '../../widgets/nav.dart';
import '../Complain/complain.dart';

class HomePage extends StatelessWidget {
  final String name = "BulliSheild";

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "BulliSheild",
          textScaleFactor: 2.5,
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
