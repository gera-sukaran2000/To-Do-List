import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CompletedStylingWidget extends StatelessWidget {
  final singleCompObject;

  CompletedStylingWidget(this.singleCompObject);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: ListTile(
          isThreeLine: true,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.5, color: Colors.purple))),
            child: Icon(
              TablerIcons.check,
              color: Colors.purple,
              size: 30.0,
            ),
          ),
          title: Text(singleCompObject.mytask,
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
              Text(singleCompObject.shortRef,
                  style: TextStyle(color: Colors.purple, fontSize: 15)),
              SizedBox(
                height: 2,
              ),
              Text(
                  'Completed on - ${DateFormat.yMMMd().format(DateTime.now())}',
                  style: TextStyle(color: Colors.purple, fontSize: 15)),
            ],
          ),
        ),
      ),
    );
  }
}
