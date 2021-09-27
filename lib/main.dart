import 'package:flutter/material.dart';
import 'package:test4/widgets/task_list.dart';

import 'widgets/chart.dart';
import '../models/TaskModel.dart';
import './widgets/new_task.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.greenAccent,
        errorColor: Colors.redAccent.shade100,
        fontFamily: 'GemunuLibre',
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'GemunuLibre',
                  fontSize: 30,
                ),
              ),
        ),
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
          headline3: TextStyle(fontSize: 30.0, fontWeight: FontWeight.normal),
          bodyText1: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w100),
          bodyText2: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w600),
        ),
      ),
      home: MyHomePage(title: 'TODO Application'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  final List<Task> myTasksList = [
    Task(
        taskId: 1,
        taskDescription: "taskDescription 1",
        taskIsDone: false,
        taskDate: DateTime.now(),
        taskCost: 90),
    Task(
        taskId: 2,
        taskDescription: "taskDescription 2",
        taskIsDone: true,
        taskDate: DateTime.now(),
        taskCost: 90),
    Task(
        taskId: 3,
        taskDescription: "taskDescription 3",
        taskIsDone: true,
        taskDate: DateTime.now(),
        taskCost: 90),
  ];

  void _addTask(String txDescription, double txCost, DateTime txcurrentDate) {
    Task newTask = Task(
      taskId: myTasksList.length,
      taskDescription: txDescription,
      taskIsDone: false,
      taskDate: txcurrentDate,
      taskCost: txCost,
    );

    setState(() {
      myTasksList.add(newTask);
    });
  }

  
  void _startAddTask(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: startNewTask(_addTask),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTask(int index) {
    setState(() {
      myTasksList.removeAt(index);
    });
  }

  void _updateTaskList(int id) {
    bool val = myTasksList[id].taskIsDone;
    setState(() {
      
      myTasksList[id].taskIsDone = !val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
        
          children: <Widget>[
            Container(
              height: (MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      AppBar().preferredSize.height) *
                  0.28,
              child: Chart(myTasksList),
            ),
            Container(
              height: (MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      AppBar().preferredSize.height) *
                  0.72,
              child: TasksListView(
                tasks: myTasksList,
                deleteTask: _deleteTask,
                updateList: _updateTaskList,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddTask(context),
      ),
    );
  }
}
