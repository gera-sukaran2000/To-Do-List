import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/class/Tasks.dart';
import 'package:todo/widgets/CompletedStylingWidget.dart';

class Completed extends StatefulWidget {
  @override
  _CompletedState createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  @override
  Widget build(BuildContext context) {
    var completedlist = Provider.of<Tasks>(context).completedTasks;
    return (completedlist.isEmpty)
        ? Center(
            child: Container(
              height: 200,
              width: 200,
              child: Text(
                "You have not completed any tasks till now , Start by Doing one",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.purple, fontSize: 15),
              ),
            ),
          )
        : Scaffold(
            resizeToAvoidBottomInset: true,
            body: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (ctx, index) {
                      return CompletedStylingWidget(completedlist[index]);
                    },
                    itemCount: completedlist.length,
                  ),
                ),
              ],
            ),
          );
  }
}
