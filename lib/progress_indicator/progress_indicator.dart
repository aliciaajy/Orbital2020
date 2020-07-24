import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//import 'package:login/shoppingpages/shoppinglist_home_page.dart';
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
            title: Text("Work Progress"), backgroundColor: Colors.purple),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              CircularPercentIndicator(
                //circular progress indicator
                radius: 300.0, //radius for circle
                lineWidth: 40.0, //width of circle line
                animation:
                    true, //animate when it shows progress indicator first
                percent: MyTaskHomePageState().getProportionCompleted(),
                center: Text(
                  (MyTaskHomePageState().getProportionCompleted() * 100)
                          .toStringAsFixed(1) +
                      "%",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
                ), //center text, you can set Icon as well
                footer: Text(
                  "Percentage Of Work Done",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
                ), //footer text
                backgroundColor: Colors.black12, //backround of progress bar
                circularStrokeCap: CircularStrokeCap
                    .round, //corner shape of progress bar at start/end
                progressColor: Colors.purpleAccent, //progress bar color
                // ),
                // CircularPercentIndicator(
                //   //circular progress indicator
                //   radius: 230.0, //radius for circle
                //   lineWidth: 30.0, //width of circle line
                //   animation: true, //animate when it shows progress indicator first
                //   percent: ShoppingList().getProportionCompleted(),
                //   center: Text(
                //     (ShoppingList().getProportionCompleted() * 100)
                //             .toStringAsFixed(1) +
                //         "%",
                //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                //   ), //center text, you can set Icon as well
                //   footer: Text(
                //     "Shopping List: Proportion of items bought",
                //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                //   ), //footer text
                //   backgroundColor: Colors.redAccent, //backround of progress bar
                //   circularStrokeCap: CircularStrokeCap
                //       .round, //corner shape of progress bar at start/end
                //   progressColor: Colors.green[300], //progress bar color
                // )
              )
            ])));
  }
}
