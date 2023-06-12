import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/tasks_bloc/tasks_bloc.dart';
import '../models/task_model.dart';

class TaskTile extends StatelessWidget {
  Task task;
  TaskTile({super.key, required this.task});

  void _removeOrDeleteTask(BuildContext context, Task task){
    task.isDeleted!
        ? context.read<TasksBloc>().add(DeleteTask(task: task))
        : context.read<TasksBloc>().add(RemoveTask(task: task));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: ()=>_removeOrDeleteTask(context, task),
      title: Text(task.title, style: TextStyle(decoration: task.isDone! ? TextDecoration.lineThrough:null),),
      trailing: Checkbox(
        value: task.isDone,
        onChanged: !task.isDeleted! ? (bool? value) {
          context.read<TasksBloc>().add(UpdateTask(task: task));
        } : null,
      ),
    );
  }
}
