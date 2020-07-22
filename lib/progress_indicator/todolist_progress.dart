import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:login/shoppingpages/shoppinglist_home_page.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:login/taskpages/task_home_page.dart';

class ProgressPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ToDoProgressIndicator();
}

class ToDoProgressIndicator extends State<ProgressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Progress Indicator"), backgroundColor: Colors.purple),
        body: Center(
            child: Column(children: <Widget>[
          CircularPercentIndicator(
            //circular progress indicator
            radius: 230.0, //radius for circle
            lineWidth: 30.0, //width of circle line
            animation: true, //animate when it shows progress indicator first
            percent: MyTaskHomePageState().getProportionOfWorkDone(),
            center: Text(
              MyTaskHomePageState()
                  .getProportionOfWorkDone()
                  .toStringAsFixed(1),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ), //center text, you can set Icon as well
            footer: Text(
              "To Do List Progress: Proportion of work done",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
            ), //footer text
            backgroundColor: Colors.redAccent, //backround of progress bar
            circularStrokeCap: CircularStrokeCap
                .round, //corner shape of progress bar at start/end
            progressColor: Colors.green[300], //progress bar color
          ),
          CircularPercentIndicator(
            //circular progress indicator
            radius: 230.0, //radius for circle
            lineWidth: 30.0, //width of circle line
            animation: true, //animate when it shows progress indicator first
            percent: ShoppingList().getProportionCompleted(),
            center: Text(
              (ShoppingList().getProportionCompleted() * 100)
                      .toStringAsFixed(0) +
                  "%",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ), //center text, you can set Icon as well
            footer: Text(
              "Shopping List: Proportion of items bought",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
            ), //footer text
            backgroundColor: Colors.redAccent, //backround of progress bar
            circularStrokeCap: CircularStrokeCap
                .round, //corner shape of progress bar at start/end
            progressColor: Colors.green[300], //progress bar color
          )
        ])));
  }
}
