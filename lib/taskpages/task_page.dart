import 'package:flutter/material.dart';
import 'package:login/widgets/custom_button.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class Task {
  final String task;
  final bool isFinish;
  const Task(this.task, this.isFinish);
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
        return _taskList[index].isFinish
        ? _taskComplete(_taskList[index].task)
        : _taskUncomplete(_taskList[index]);
      },
    );
}

 Widget _taskUncomplete(Task data) {
    return InkWell(
      onTap: (){
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("Confirm Task", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
                    SizedBox(
                      height: 24,
                    ),
                    Text(data.task),
                    SizedBox(
                      height: 24,
                    ),
                    Text("Time"),
                    SizedBox(
                      height: 24,
                    ),
                    CustomButton(
                      onPressed: (){
                        //todo: implement database request to complete
                      }, 
                      color: Colors.purple,
                      textColor: Colors.white,
                      buttonText: "Complete")
                    
                  ],
                ),
              ),
            );
          }
        );
      },
      onDoubleTap: (){
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("Delete Task", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
                    SizedBox(
                      height: 24,
                    ),
                    Text(data.task),
                    SizedBox(
                      height: 24,
                    ),
                    Text("Date"),
                    SizedBox(
                      height: 24,
                    ),
                    CustomButton(
                      onPressed: (){
                        //todo: implement database request to complete
                      }, 
                      color: Colors.purple,
                      textColor: Colors.white,
                      buttonText: "Delete"
                      )
                  ],
                ),
              ),
            );
          });
      },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
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
                Text(data.task)
              ],
            ),
          ),
    );
  }

  Widget _taskComplete(String task) {
    return Container(
      foregroundDecoration: BoxDecoration(color: Color(0x60FDFDFD)),
      child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
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
