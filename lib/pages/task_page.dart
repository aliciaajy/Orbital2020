import 'package:flutter/material.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class Task {
  final String task;
  final bool isComplete;
  const Task(this.task, this.isComplete);
}

final List<Task> _taskList = [
  new Task("LiftOff", false),
  new Task("MileStone 1", false),
  new Task("MileStone 2", false),
  new Task("MileStone 3", false),
  new Task("Poster", true),
  new Task("Proposal", true),
];

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      itemCount: _taskList.length,
      itemBuilder: (context, index) {
        return _taskList[index].isComplete 
        ? _taskComplete(_taskList[index].task)
        : _taskUncomplete(_taskList[index].task);
      },
    );
}

 Widget _taskUncomplete(String task) {
    return Padding(
          padding: const EdgeInsets.only(left: 20.0, 
          bottom: 24.0),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.radio_button_unchecked,
              color: Theme.of(context).accentColor,
              size: 20,
              ),
              SizedBox(
                width: 28,
                ),
              Text(task)
            ],
          ),
        );
  }

  Widget _taskComplete(String task) {
    return Container(
      foregroundDecoration: BoxDecoration(color: Color(0x60FDFDFD)),
      child: Padding(
            padding: const EdgeInsets.only(left: 20.0, 
            top: 24.0),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.radio_button_checked,
                color: Theme.of(context).accentColor,
                size: 20,
                ),
                SizedBox(
                  width: 28,
                  ),
                Text(task)
              ],
            ),
          ),
    );
  }
}