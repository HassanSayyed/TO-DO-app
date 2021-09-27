import 'package:flutter/foundation.dart';

class Task {
  final int taskId;
  final String taskDescription;
  bool taskIsDone;
  final DateTime taskDate;
  final double taskCost;

  Task(
      {required this.taskId,
      required this.taskDescription,
      required this.taskIsDone,
      required this.taskDate,
      required this.taskCost});
}
