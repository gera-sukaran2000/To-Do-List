import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:todo/widgets/waves.dart';

class GetStarted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 130,
            ),
            Icon(
              TablerIcons.list,
              size: 80,
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              child: Text(
                'Welcome, Let us get started', //tr is from get for translate
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            SizedBox(height: 8),
            Container(
              child: Text(
                "Subtracting from your list of priorities \nis as important as adding to it.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ButtonTheme(
              minWidth: 250.0,
              height: 50,
              child: RaisedButton(
                //shape: ,
                color: Colors.purple,
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('TabScreen');
                },
                child: Text(
                  ('NEXT'),
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            Expanded(child: Waves()),
          ],
        ),
      ),
    );
  }
}
