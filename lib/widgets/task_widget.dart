import 'package:flutter/material.dart';
import 'package:manage_my_time/db/task_database.dart';
import 'package:manage_my_time/models/task_model.dart';
import 'package:manage_my_time/screens/task_viewer_screen.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({Key? key}) : super(key: key);

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  late List<Task> tasks = [];
  late final Task? task;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  // @override
  // void dispose() {
  //   TaskDatabase.instance.close();

  //   super.dispose();
  // }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    this.tasks = await TaskDatabase.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0),
      child: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, int index) {
          return Dismissible(
            key: UniqueKey(),
            onDismissed: (direction) {
              TaskDatabase.instance.delete(tasks[index].id!);

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  'Task Dismissed',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                backgroundColor: Colors.red,
              ));
            },
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => TaskViewerScreen(
                              index: index,
                              id: tasks[index].id!,
                            )));
              },
              child: Container(
                height: 53.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white),
                child: Column(
                  children: [
                    Row(
                      children: <Widget>[
                        IconButton(
                            onPressed: () {
                              setState(() {
                                final snackBar = SnackBar(
                                    content: Text(
                                      'Completed Task ${tasks[index].title}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    backgroundColor: Colors.red);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                TaskDatabase.instance.delete(tasks[index].id!);
                                tasks.removeAt(index);
                              });
                            },
                            icon: Icon(Icons.done_outline_rounded),
                            color: Colors.green),
                        SizedBox(
                          width: 5.0,
                        ),
                        Flexible(
                          child: Text(
                            tasks[index].title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.blue[900],
                                fontWeight: FontWeight.w800,
                                fontSize: 20.0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
