import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app_with_bloc/blocs/bloc/tasks_bloc.dart';
import 'package:task_app_with_bloc/screens/add_task_screen.dart';
import 'package:task_app_with_bloc/widgets/tasks_list.dart';

import '../models/task_model.dart';

class TasksScreen extends StatelessWidget {
   TasksScreen({super.key});

  TextEditingController titleController = TextEditingController();

  void _addTask(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: AddTaskScreen(),
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(builder: (context, state) {
      List<Task> tasksList = state.allTasks;
      return Scaffold(
        appBar: AppBar(
          title: const Text("Tasks App"),
          actions: [IconButton(onPressed:()=>_addTask(context), icon: const Icon(Icons.add))],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: Chip(label: Text("Tasks")),
            ),
            TasksList(tasksList: tasksList),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: ()=>_addTask(context),
          tooltip: "Add Task",
          child: const Icon(Icons.add),
        ),
      );
    });
  }
}
