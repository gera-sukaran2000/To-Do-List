import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/class/Tasks.dart';
import 'package:todo/widgets/Form.dart';
import 'package:todo/widgets/SingeTaskStyling.dart';

class AllTasks extends StatefulWidget {
  //not added notifyllistens antwhere till now
  @override
  _AllTasksState createState() => _AllTasksState();
}

class _AllTasksState extends State<AllTasks> {
  void _addNewTask(BuildContext ctx) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1.0),
                    child: NewTask(),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                  ),
                  SizedBox(height: 10.0),
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    final list = Provider.of<Tasks>(context).myTasksList;

    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (ctx, index) {
              return StylingWidget(list[index]);
            },
            itemCount: list.length,
          ),
        ),
        FloatingActionButton(
          onPressed: () {
            _addNewTask(context);
          },
          backgroundColor: Colors.purple[300],
          child: Icon(Icons.add),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
