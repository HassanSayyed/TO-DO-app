import 'package:flutter/material.dart';
import '../models/TaskModel.dart';

class TasksListView extends StatelessWidget {
  final List<Task> tasks;
  
  final Function deleteTask;
  final Function updateList;

  TasksListView(
      {required this.tasks,
      
      required this.deleteTask,
      required this.updateList});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: tasks.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    )),
              ],
            )
          : Container(
           /* child : Checkbox(
                          value: tasks[1].taskIsDone,
                          onChanged: (bool) {
                         
                            updateList(1);
                             
                          },
                        ), */
             child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      margin: EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                      shadowColor: ThemeData.light().primaryColorLight,
                      child: ListTile(
                        leading: Checkbox(
                          value: tasks[index].taskIsDone,
                          onChanged: (bool) {
                            print("Check Box onChange");
                            updateList(index);
                          },
                        ),
                        title:
                            Text('${tasks[index].taskDescription.toString()}',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23 ),
                            
                            ),
                        subtitle: Text(" \$ ${tasks[index].taskCost}", style: TextStyle( fontSize: 17),),
                        tileColor: tasks[index].taskIsDone  ? Theme.of(context).accentColor : Theme.of(context).errorColor,
                        trailing: IconButton(
                           icon: Icon(Icons.delete_outlined, color: Colors.grey ,) ,

                           onPressed: ()=> deleteTask(index),         ),
                      ),
                    );
                  }), 
                
           
            ),
    );
  }
}
