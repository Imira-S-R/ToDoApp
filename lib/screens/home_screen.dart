import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:manage_my_time/db/task_database.dart';
import 'package:manage_my_time/models/task_model.dart';
import 'package:manage_my_time/screens/add_task_screen.dart';
import 'package:manage_my_time/screens/edit_task_screen.dart';
import 'package:manage_my_time/screens/settings_screen.dart';
import 'package:manage_my_time/screens/shopping_cart_screen.dart';
import 'package:manage_my_time/screens/task_viewer_screen.dart';
import 'package:manage_my_time/widgets/no_task_found_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isCompleted = false;
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
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => AddTaskScreen(
                        updateTasks: refreshNotes,
                      )));
        },
        backgroundColor: Colors.red,
        splashColor: Colors.red[900],
        tooltip: 'Add New Task',
        child: Icon(
          Icons.add_rounded,
          color: Colors.white,
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.blue[900],
        leading: SizedBox.shrink(),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => ShoppingCartScreen()));
            },
            icon: Icon(Icons.shopping_cart_rounded),
            color: Colors.white,
            tooltip: 'Shopping List',
          ),
          IconButton(
            tooltip: 'Settings',
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => Settings()));
            },
            icon: Icon(Icons.info_rounded),
            color: Colors.white,
          ),
        ],
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
          SizedBox(
            height: 20.0,
          ),
          Expanded(
              child: ListView.builder(
            itemCount: tasks.length == 0 ? 1 : tasks.length,
            itemBuilder: (context, int index) {
              return tasks.length == 0
                  ? NoTaskFound()
                  : Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        setState(() {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              'Deleted "${tasks[index].title}"',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            backgroundColor: Colors.red,
                          ));
                          TaskDatabase.instance.delete(tasks[index].id!);
                          tasks.removeAt(index);
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: OpenContainer(
                          transitionType: ContainerTransitionType.fadeThrough,
                          closedBuilder:
                              (BuildContext _, VoidCallback openContainer) {
                            return ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      tasks[index].title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .headline1!
                                              .color,
                                          fontWeight: FontWeight.bold,
                                          decoration: tasks[index].isCompleted
                                              ? TextDecoration.lineThrough
                                              : TextDecoration.none,
                                          decorationColor: Colors.grey[800],
                                          decorationThickness: 2.0),
                                    ),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => EditTaskScreen(
                                                    title: tasks[index].title,
                                                    description: tasks[index]
                                                        .description,
                                                    id: tasks[index].id!,
                                                    updateTask: refreshNotes)));
                                      },
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.red,
                                      ))
                                ],
                              ),
                              onTap: openContainer,
                              tileColor: Theme.of(context).accentColor,
                              leading: IconButton(
                                iconSize: 22.0,
                                onPressed: () {
                                  setState(() {
                                    isCompleted = !isCompleted;
                                    TaskDatabase.instance.update(Task(
                                        isCompleted: isCompleted,
                                        title: tasks[index].title,
                                        description: tasks[index].description,
                                        id: tasks[index].id));
                                    refreshNotes();
                                  });
                                },
                                icon: Icon(Icons.done_outline_rounded),
                                color: Colors.green,
                              ),
                            );
                          },
                          openBuilder: (BuildContext _, VoidCallback __) {
                            return TaskViewerScreen(
                                index: index, id: tasks[index].id!);
                          },
                          onClosed: (_) => HomeScreen(),
                          transitionDuration: Duration(milliseconds: 400),
                          openColor: Theme.of(context).primaryColor,
                          middleColor: Theme.of(context).primaryColor,
                        ),
                      ),
                    );
            },
          )),
        ],
      ),
    );
  }
}
