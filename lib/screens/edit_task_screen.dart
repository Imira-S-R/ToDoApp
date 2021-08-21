import 'package:flutter/material.dart';
import 'package:manage_my_time/db/task_database.dart';
import 'package:manage_my_time/models/task_model.dart';

class EditTaskScreen extends StatefulWidget {
  final String title;
  final String description;
  final int id;
  final Function updateTask;

  EditTaskScreen(
      {required this.title,
      required this.description,
      required this.id,
      required this.updateTask});

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.red[900],
      ),
      body: Column(
        children: [
          Container(
            height: 60.0,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.red[900],
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0))),
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.0, 5.0, 10.0, 0.0),
              child: Text('Edit Task',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Title',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14.0),
                ),
                TextFormField(
                  maxLength: 100,
                  initialValue: widget.title,
                  onChanged: (value) {
                    title.text = value;
                  },
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                Text(
                  'Description',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14.0),
                ),
                TextFormField(
                  maxLength: 100,
                  initialValue: '${widget.description}',
                  onChanged: (value) {
                    description.text = value;
                  },
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (title.text == '' && description.text == '') {
                          Navigator.pop(context);
                        } else if (title.text == '') {
                          TaskDatabase.instance.update(Task(
                              isCompleted: false,
                              title: widget.title,
                              description: description.text,
                              id: widget.id));
                          widget.updateTask();
                          Navigator.pop(context);
                        } else if (description.text == '') {
                          TaskDatabase.instance.update(Task(
                              isCompleted: false,
                              title: title.text,
                              description: widget.description,
                              id: widget.id));
                          widget.updateTask();
                          Navigator.pop(context);
                        } else {
                          TaskDatabase.instance.update(Task(
                              isCompleted: false,
                              title: title.text,
                              description: description.text,
                              id: widget.id));
                          widget.updateTask();
                          Navigator.pop(context);
                        }
                      },
                      child: Container(
                        height: 60.0,
                        width: 100.0,
                        child: Center(
                            child: Text(
                          'Done',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        )),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(30.0)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
