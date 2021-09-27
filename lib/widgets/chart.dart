import 'package:flutter/material.dart';
import '../models/TaskModel.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:countup/countup.dart';

class Chart extends StatefulWidget {
  List<Task> _tasks;

  Chart(this._tasks);

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  int get tasksCount {
    return widget._tasks.length;
  }

  int get tasksDone {
    return widget._tasks
        .fold(0, (sum, element) => sum + (element.taskIsDone == true ? 1 : 0));
  }

  double get tasksPendingCost {
    return widget._tasks.fold(
        0.0,
        (sum, element) =>
            sum + (element.taskIsDone == false ? element.taskCost : 0));
  }

  @override
  Widget build(BuildContext context) {
    // 1 third of screen width
    final double screenFactor = (MediaQuery.of(context).size.width / 4);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Card(
          elevation: 6,
          margin: EdgeInsets.all(20),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              // TDOD fix width
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  width: screenFactor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Total Tasks \n ",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        ' $tasksCount',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: screenFactor,
                  child: Center(
                    child: new CircularPercentIndicator(
                      // TODO   fix width for web -relative to containergit
                      radius: constraints.maxHeight*0.50,
                      animation: true,
                      animationDuration: 900,

                      lineWidth: 15.0,
                      percent: tasksDone / tasksCount,
                      center: new Text(
                        "Progress",
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      circularStrokeCap: CircularStrokeCap.butt,
                      backgroundColor: Colors.redAccent.shade700,
                      progressColor: Colors.greenAccent.shade400,
                    ),
                  ),
                ),
                Container(
                  width: screenFactor,
                  height: screenFactor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                          child: Text(
                        " Pending  \n  costs",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      )),
                      Countup(
                        begin: 0,
                        end: tasksPendingCost,
                        duration: Duration(seconds: 3),
                        separator: ',',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
