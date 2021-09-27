import 'package:flutter/material.dart';

class startNewTask extends StatefulWidget {
  final Function addTask;

  startNewTask(this.addTask);

  @override
  _startNewTaskState createState() => _startNewTaskState();
}

class _startNewTaskState extends State<startNewTask> {
  final _descriptionController = TextEditingController();
  final _costController = TextEditingController();
  late DateTime _currentDate;

  void _submitData() {
    if (_costController.text.isEmpty  || _descriptionController.text.isEmpty) {
      return;
    }
    final _enteredDescription = _descriptionController.text;
    final _enteredCost = double.parse(_costController.text);
    _currentDate = DateTime.now();

    

    widget.addTask(
      _enteredDescription,
      _enteredCost,
      _currentDate
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Description '),
              controller: _descriptionController,
              onSubmitted: (_) => _submitData(),
              // onChanged: (val) {
              //   titleInput = val;
              // },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _costController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submitData(),
              // onChanged: (val) => amountInput = val,
            ),
            RaisedButton(
              child: Text('Add Task'),
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).primaryColorLight,
              onPressed: _submitData,
            ),
          ],
        ),
      ),
    );
  }
}
