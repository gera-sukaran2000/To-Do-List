import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class DrawerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        AppBar(
          title: Text('Hello User'),
        ),
        Divider(),
        ListTile(
          leading: Icon(TablerIcons.list),
          title: Text('Tasks'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/');
          },
        ),
        ListTile(
          leading: Icon(TablerIcons.list_check),
          title: Text('Completed Tasks'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed('CompletedTask');
          },
        ),
      ],
    ));
  }
}
