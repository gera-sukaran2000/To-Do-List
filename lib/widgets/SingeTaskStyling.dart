import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo/class/Tasks.dart';
import 'package:intl/intl.dart';

class StylingWidget extends StatelessWidget {
  Task singleobject;
  StylingWidget(this.singleobject);

  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Dismissible(
          key: ValueKey(singleobject.id),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            Provider.of<Tasks>(context, listen: false)
                .removeTask(singleobject.id);
          },
          confirmDismiss: (direction) {
            return showDialog(
                context: context,
                builder: (ctx) {
                  return AlertDialog(
                    title: Text('Are You Sure ?'),
                    content: Text(
                        'Are You Sure You Want To Remove This Item From Cart ?'),
                    actions: <Widget>[
                      FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: Text('No')),
                      FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                          child: Text('Yes')),
                    ],
                  );
                });
          },
          background: Container(
            alignment: Alignment.centerRight,
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
            color: Colors.red[300],
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          child: ListTile(
              isThreeLine: true,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              leading: Container(
                padding: EdgeInsets.only(right: 12.0),
                decoration: new BoxDecoration(
                    border: new Border(
                        right:
                            new BorderSide(width: 1.5, color: Colors.purple))),
                child: Icon(
                  TablerIcons.caret_right,
                  color: Colors.purple,
                  size: 30.0,
                ),
              ),
              title: Text(singleobject.mytask,
                  style: GoogleFonts.quicksand(
                      color: Colors.purple,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)
                  // TextStyle(
                  //     color: Colors.purple,
                  //     fontSize: 20,
                  //     fontWeight: FontWeight.bold),
                  ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(singleobject.shortRef,
                      style: TextStyle(color: Colors.purple, fontSize: 15)),
                  SizedBox(
                    height: 2,
                  ),
                  Text(DateFormat.yMMMd().format(singleobject.date),
                      style: TextStyle(color: Colors.purple, fontSize: 15)),
                ],
              ),
              //   Text(singleobject.shortRef,
              //     style: TextStyle(color: Colors.purple))),
              trailing: Wrap(
                spacing: 12,
                children: [
                  IconButton(
                      onPressed: () async {
                        await Provider.of<Tasks>(context, listen: false)
                            .addToCompletedTask(singleobject.id);
                      },
                      icon: Icon(TablerIcons.checkbox,
                          color: Colors.purple, size: 30.0)),
                  IconButton(
                      onPressed: () async {
                        try {
                          await Provider.of<Tasks>(context, listen: false)
                              .removeTask(singleobject.id);
                        } catch (error) {
                          scaffold.showSnackBar(SnackBar(
                              content: Text('Error Deleting Product')));
                        }
                      },
                      icon: Icon(TablerIcons.trash,
                          color: Colors.purple, size: 30.0))
                  // Icon(TablerIcons.checkbox, color: Colors.purple, size: 30.0),
                  // Icon(TablerIcons.trash, color: Colors.purple, size: 30.0),
                ],
              )),
        ),
      ),
    );
  }
}
