import 'package:flutter/material.dart';
import 'package:manage_my_time/db/task_database.dart';
import 'package:manage_my_time/models/task_model.dart';
import 'package:manage_my_time/screens/home_screen.dart';

class TaskViewerScreen extends StatefulWidget {
  late int index;
  late int id;
  TaskViewerScreen({required this.index, required this.id});

  @override
  _TaskViewerScreenState createState() => _TaskViewerScreenState();
}

class _TaskViewerScreenState extends State<TaskViewerScreen> {
  late List<Task> tasks = [];
  bool isLoading = false;
  bool isCompleted = false;
  final snackBar = SnackBar(content: Text('Task Completed And Removed', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),), backgroundColor: Colors.red);

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    this.tasks = await TaskDatabase.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[900],
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.red[900],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => HomeScreen()));
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              TaskDatabase.instance.delete(widget.id);
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => HomeScreen()));
            },
            icon: Icon(Icons.delete_rounded, color: Colors.white,),
            tooltip: 'Delete Task',
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.0, 20.0, 10.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: Text(
                  tasks[widget.index].title,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Theme.of(context).textTheme.headline1!.color,
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Divider(height: 5.0, color: Colors.black,),
               SizedBox(
                height: 10.0,
              ),
              Text(
                'Description',
                style: TextStyle(
                    color: Theme.of(context).textTheme.headline2!.color,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                    letterSpacing: 0.2),
              ),
              SizedBox(
                height: 5.0,
              ),
              Flexible(
                child: Text(
                  tasks[widget.index].description == ''
                      ? 'No Description'
                      : tasks[widget.index].description,
                  maxLines: 12,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.headline1!.color,
                    fontSize: 18.0,
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              GestureDetector(
                onTap: (){
                  TaskDatabase.instance.delete(tasks[widget.index].id!);
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
                },
                child: Container(
                  height: 50.0,
                  width: 150.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(7.0)),
                      color: Colors.red),
                  child: Center(
                    child: Text(
                      'Mark As Completed',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
