import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app_with_bloc/widgets/my_popup_menu.dart';

import '../blocs/tasks_bloc/tasks_bloc.dart';
import '../models/task_model.dart';

class TaskTile extends StatelessWidget {
  Task task;

  TaskTile({super.key, required this.task});

  void _removeOrDeleteTask(BuildContext context, Task task) {
    task.isDeleted!
        ? context.read<TasksBloc>().add(DeleteTask(task: task))
        : context.read<TasksBloc>().add(RemoveTask(task: task));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                !task.isFavourite
                    ? const Icon(Icons.star_outline)
                    : const Icon(Icons.star),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 18,
                            decoration: task.isDone!
                                ? TextDecoration.lineThrough
                                : null),
                      ),
                      Text(task.date),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Checkbox(
                value: task.isDone,
                onChanged: !task.isDeleted!
                    ? (bool? value) {
                        context.read<TasksBloc>().add(UpdateTask(task: task));
                      }
                    : null,
              ),
              MyPopupMenu(
                task: task,
                cancelOrderDelete: () => _removeOrDeleteTask(context, task),
                likeOrDislike: () => context.read<TasksBloc>().add(
                      MarkFavouriteOrUnFavouriteTask(task: task),
                    ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

// ListTile(
// onLongPress: ()=>_removeOrDeleteTask(context, task),
// title: Text(
// task.title,
// overflow: TextOverflow.ellipsis,
// style: TextStyle(decoration: task.isDone! ? TextDecoration.lineThrough:null),),
// trailing: Checkbox(
// value: task.isDone,
// onChanged: !task.isDeleted! ? (bool? value) {
// context.read<TasksBloc>().add(UpdateTask(task: task));
// } : null,
// ),
// )
