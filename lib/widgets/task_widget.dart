import 'package:flutter/material.dart';
import 'package:manage_my_time/db/task_database.dart';
import 'package:manage_my_time/models/task_model.dart';
import 'package:manage_my_time/screens/home_screen.dart';
import 'package:manage_my_time/screens/task_viewer_screen.dart';
import 'package:animations/animations.dart';
import 'package:manage_my_time/widgets/no_task_found_widget.dart';

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
    return ListView.builder(
      itemCount: tasks.length == 0 ? 1 : tasks.length,
      itemBuilder: (context, int index) {
        return tasks.length == 0 ? NoTaskFound() : Padding(
          padding: EdgeInsets.all(8.0),
          child: OpenContainer(
            transitionType: ContainerTransitionType.fadeThrough,
            closedBuilder: (BuildContext _, VoidCallback openContainer) {
              return ListTile(
                  title: Text(
                    tasks[index].title,
                    style: TextStyle(
                        color: Theme.of(context).textTheme.headline1!.color, fontWeight: FontWeight.bold),
                  ),
                  onTap: openContainer,
                  tileColor: Theme.of(context).accentColor,
                  leading: IconButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          'Completed "${tasks[index].title}"',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        backgroundColor: Colors.red,
                      ));
                      TaskDatabase.instance.delete(tasks[index].id!);
                      tasks.remove(tasks[index]);
                      refreshNotes();
                    },
                    icon: Icon(Icons.done_outline_rounded),
                    color: Colors.green,
                  ),
              );
            },
            openBuilder: (BuildContext _, VoidCallback __) {
              return TaskViewerScreen(index: index, id: tasks[index].id!);
            },
            onClosed: (_) => HomeScreen(),
            transitionDuration: Duration(milliseconds: 400),
            openColor: Theme.of(context).primaryColor,
            middleColor: Theme.of(context).primaryColor,
          ),
        );
      },
    );
  }
}


// ListView.builder(
//         itemCount: tasks.length,
//         itemBuilder: (context, int index) {
//           return OpenContainer(
//             transitionType: ContainerTransitionType.fadeThrough,
//             closedBuilder: (BuildContext _, VoidCallback openContainer) {
//               return Dismissible(
//                 key: UniqueKey(),
//                 onDismissed: (direction) {
//                   setState(() {
//                     TaskDatabase.instance.delete(tasks[index].id!);
//                     refreshNotes();
//                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                       content: Text(
//                         'Dismissed "${tasks[index].title}"',
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       backgroundColor: Colors.red,
//                     ));
//                   });
//                 },
//                 child: ListTile(
//                   leading: IconButton(
//                       onPressed: () {
//                         setState(() {
//                           TaskDatabase.instance.delete(tasks[index].id!);
//                           refreshNotes();
//                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                             content: Text('Completed "${tasks[index].title}"'),
//                             backgroundColor: Colors.red,
//                           ));
//                         });
//                       },
//                       color: Colors.green,
//                       icon: Icon(Icons.done_all_rounded)),
//                   title: Flexible(
//                     child: Text(
//                       '${tasks[index].title}',
//                       // maxLines: 1,
//                       // overflow: TextOverflow.ellipsis,
//                       style: TextStyle(
//                           color: Colors.blue[900], fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   onTap: openContainer,
//                 ),
//               );
//             },
//             openBuilder: (BuildContext _, VoidCallback __) {
//               return TaskViewerScreen(index: index, id: tasks[index].id!);
//             },
//             onClosed: (_) => HomeScreen(),
//             transitionDuration: Duration(milliseconds: 400),
//           );
//         },
//     );