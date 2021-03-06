import 'package:flutter/material.dart';
import 'task_tile.dart';
import 'package:todoey_flutter/models/task.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/models/task_data.dart';

class TaskList extends StatelessWidget {
  //use provider instead passing values
  // List<Task>? tasks;
  // TaskList({required this.tasks});
//return it to statelesswidget
//   @override
//   State<TaskList> createState() => _TaskListState();
// }
//
// class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    //user ListView.builder unKnown number of ListTile or Infinte numbers
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        final CurrentTask = Provider.of<TaskData>(context).tasks[index];
        return ListTile(
          onLongPress: () {
            Provider.of<TaskData>(context, listen: false)
                .deleteTask(CurrentTask);
          },
          //title: Text((context.read<Task>().tasks[index].name!)),
          title: Text(
            CurrentTask.name!,
            style: TextStyle(
              decoration:
                  CurrentTask.isDone ? TextDecoration.lineThrough : null,
            ),
          ),
          //Error sovled by toString() -->'String Function(dynamic)' can't be assigned to the parameter type 'String'.
          trailing: Checkbox(
            value: CurrentTask
                .isDone, //(newText) => context.watch<Task>().tasks[index].isDone,
            onChanged: (bool? value) {
              // Provider.of<TaskData>(context).updateTask(<TaskData>(context).tasks[index]);
              Provider.of<TaskData>(context, listen: false).updateTask(
                  CurrentTask,
                  value!); // listen: false  Mandatory or will not update list.
              // setState(() {
              //   Provider.of<TaskData>(context).tasks[index].isDone = value!;
              // });
            },
          ),
          // title: widget.tasks![index].name!,
          // checkedBox: widget.tasks![index].isDone,
        );
      },
      //mandatory -->Crash App
      //itemCount: context.watch<Task>().tasks.length, //int.parse(().toString()),
      itemCount: (Provider.of<TaskData>(context)
          .taskCount), //int.parse(().toString()),
      //Error sovled by toString() -->error: The argument type 'int Function(dynamic)' can't be assigned to the parameter type 'int?'.
    );
  }
}
