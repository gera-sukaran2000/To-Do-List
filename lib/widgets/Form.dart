import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/class/Tasks.dart';

class NewTask extends StatefulWidget {
  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  void _addNewTask(
    String shortRef,
    String title,
  ) {
    final task = Task(
        id: DateTime.now().toString(),
        mytask: title,
        shortRef: shortRef,
        date: DateTime.now());

    Provider.of<Tasks>(context, listen: false).addtoTask(task);
  }

  final titleController = TextEditingController();

  final refController = TextEditingController();

  void submit() {
    final titlesubmit = titleController.text;
    final ShortRef = refController.text;

    if (titlesubmit.isEmpty || ShortRef.isEmpty) {
      return;
    }
    _addNewTask(refController.text, titleController.text);

    Navigator.of(context)
        .pop(); //closes modal sheet when we press confrim on keyboard
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          TextField(
            decoration: InputDecoration(labelText: "Task's title"),
            autofocus: false,
            /*onChanged: (String value) {
                    title_inputvalue = value;
                  }*/
            controller: titleController,
            onSubmitted: (_) {
              submit(); //when we press ok in the keyboard
            },
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Short reference'),
            keyboardType: TextInputType.text,
            autofocus: false,
            controller: refController,
            onSubmitted: (_) {
              submit();
            },
          ),
          SizedBox(
            height: 10,
          ),
          RaisedButton(
              onPressed: submit,
              color: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(18.0),
              ),
              child: Text(
                'ADD TASK',
                style: TextStyle(color: Colors.white),
              ))
        ]),
      ),
    );
  }
}
