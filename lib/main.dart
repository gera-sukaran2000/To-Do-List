import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Screens/Completed.dart';
import 'package:todo/Screens/GetStarted.dart';
import 'package:todo/Screens/tabBar.dart';
import 'package:todo/class/Tasks.dart';
import 'package:shared_preferences/shared_preferences.dart';

int startScreen;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  startScreen = await preferences.getInt('startScreen');
  await preferences.setInt('startScreen', 1);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Tasks(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        initialRoute: startScreen == 0 || startScreen == null
            ? 'GetStarted'
            : 'TabScreen',
        routes: {
          'GetStarted': (ctx) => GetStarted(),
          'TabScreen': (ctx) => TabScreen(),
          'CompletedTask': (ctx) => Completed()
        },
      ),
    );
  }
}
