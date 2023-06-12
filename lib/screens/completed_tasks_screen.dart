import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app_with_bloc/widgets/tasks_list.dart';

import '../blocs/tasks_bloc/tasks_bloc.dart';
import '../models/task_model.dart';

class CompletedTasksScreen extends StatelessWidget {
  CompletedTasksScreen({super.key});
  static const id = "tasks_screen";

  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(builder: (context, state) {
      List<Task> tasksList = state.completedTasks;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Chip(label: Text("${state.completedTasks.length} Tasks")),
          ),
          TasksList(tasksList: tasksList),
        ],
      );
    });
  }
}
