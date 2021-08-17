import 'package:flutter/material.dart';
import 'package:manage_my_time/db/task_database.dart';
import 'package:manage_my_time/models/task_model.dart';
import 'package:manage_my_time/screens/add_task_screen.dart';
import 'package:manage_my_time/screens/settings_screen.dart';
import 'package:manage_my_time/widgets/task_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => AddTaskScreen()));
        },
        backgroundColor: Colors.red,
        splashColor: Colors.red[900],
        tooltip: 'Add New Task',
        child: Icon(Icons.add_rounded),
      ),
      backgroundColor: Color(0xfff5f5f5),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.blue[900],
        actions: [IconButton(tooltip: 'About', onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (_) => Settings()));}, icon: Icon(Icons.info_rounded))],
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blue[900],
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0)),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Hi,',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Let's be productive today",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          Expanded(child: TaskWidget()),
        ],
      ),
    );
  }
}
