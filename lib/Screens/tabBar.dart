import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo/Screens/AllTasks.dart';
import 'package:todo/Screens/Completed.dart';
import 'package:todo/class/Tasks.dart';

class TabScreen extends StatefulWidget {
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    setState(() {
      _isLoading = true;
    });

    Provider.of<Tasks>(context).fetchAndSetTasks();
    Provider.of<Tasks>(context).fetchAndSetCompletedTask();

    setState(() {
      _isLoading = false;
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.purple[300],
            title: Text(
              'To Do List',
              textAlign: TextAlign.center,
              style: GoogleFonts.libreBaskerville(
                textStyle: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
            bottom: TabBar(
              labelColor: Colors.purple,
              unselectedLabelColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  color: Colors.white),
              tabs: [
                Tab(
                  icon: Icon(TablerIcons.layout_list),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text('Tasks'),
                  ),
                ),
                Tab(
                  icon: Icon(TablerIcons.list_check),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text('Completed'),
                  ),
                )
              ],
            ),
          ),
          body: (_isLoading)
              ? Center(child: CircularProgressIndicator())
              : TabBarView(children: [AllTasks(), Completed()]),
        ));
  }
}
