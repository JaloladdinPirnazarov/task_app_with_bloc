import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app_with_bloc/blocs/bloc/tasks_bloc.dart';

import '../models/task_model.dart';

class TasksList extends StatelessWidget {
  List<Task> tasksList;

  TasksList({super.key, required this.tasksList});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: tasksList.length,
        itemBuilder: (context, position) {
          var task = tasksList[position];
          return ListTile(
            title: Text(task.title),
            trailing: Checkbox(
              value: task.isDone,
              onChanged: (bool? value) {
                context.read<TasksBloc>().add(UpdateTask(task: task));
              },
            ),
          );
        },
      ),
    );
  }
}
